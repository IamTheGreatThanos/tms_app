import 'dart:math';

import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'data/bloc/map_cubit.dart';
import 'data/bloc/map_state.dart';

class SessionPage extends StatefulWidget {
  final int orderId;
  final OrderData orderData;

  const SessionPage({Key? key, required this.orderId, required this.orderData})
      : super(key: key);

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<SessionPage> {
  YandexMapController? controller;

  late final List<MapObject> mapObjects = [];
  final placemarks = [];
  final List<RequestPoint> points = [];
  final List<DrivingSessionResult> results = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapCubit>(context).getMap(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapCubit, MapState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MapLoadedState) {
              _requestRoutes(state.loadedMap);
              return YandexMap(
                onMapCreated: (YandexMapController yandexMapController) async {
                  controller = yandexMapController;
                  controller!.moveCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: Point(
                          longitude: state.loadedMap.first.long!,
                          latitude: state.loadedMap.first.lat!,
                          // longitude: widget.orderData.fromLong!,
                          // latitude: widget.orderData.fromLat!,
                        ),
                        zoom: 5)),
                    animation: const MapAnimation(duration: 2.0),
                  );
                },
                mapObjects: mapObjects,
              );
            }

            if (state is MapInitState) {
              if (kDebugMode) {
                print('init');
              }
              return YandexMap(
                mapObjects: mapObjects,
              );
            }

            if (state is MapErrorState) {
              return Center(
                child: Text(
                  state.messsage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ),
              );
            }
          }),
    );
  }

  Future<void> _requestRoutes(List<OrderPoint> data) async {
    for (int i = 0; i < data.length; i++) {
      placemarks.add(Placemark(
        mapId: MapObjectId('placeMark $i'),
        point: Point(
            latitude: data[i].lat as double, longitude: data[i].long as double),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
                'assets/images/${i == data.length - 1 ? "route_end" : i == 0 ? "route_start" : "route_stop_by"}.png'),
            scale: 1)),
      ));
    }

    for (int i = 0; i < placemarks.length; i++) {
      mapObjects.add(placemarks[i]);
      points.add(RequestPoint(
          point: placemarks[i].point,
          requestPointType: RequestPointType.wayPoint));
    }

    final DrivingSessionResult result = await YandexDriving.requestRoutes(
            points: points,
            drivingOptions: const DrivingOptions(
                initialAzimuth: 0, routesCount: 1, avoidTolls: false))
        .result;

    if (result.routes != null) {
      results.add(result);
      for (int i = 0; i < result.routes!.length; i++) {
        mapObjects.add(
          Polyline(
            mapId: MapObjectId('route_${i}_polyline'),
            coordinates: result.routes![i].geometry,
            strokeColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            strokeWidth: 3,
          ),
        );

        if (i == result.routes!.length - 1) {
          final state = BlocProvider.of<MapCubit>(context);
          state.emit(MapInitState());
        }
      }
    }
  }
}
