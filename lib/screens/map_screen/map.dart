import 'dart:developer' as dev;
import 'dart:math';

import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
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
        listener: (context, state) {
          if (state is MapLoadedState) {
            _requestRoutes(state.loadedMap);
          }
        },
        builder: (context, state) {
          if (state is MapLoadedState) {
            // _requestRoutes(state.loadedMap);
            return YandexMap(
              onMapCreated: (YandexMapController yandexMapController) async {
                controller = yandexMapController;
                final double? lat = double.tryParse(state.loadedMap.first.lat!);
                final double? long =
                    double.tryParse(state.loadedMap.first.long!);
                if (lat != null && long != null) {
                  controller!.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: Point(
                          longitude: long,
                          latitude: lat,
                          // longitude: widget.orderData.fromLong!,
                          // latitude: widget.orderData.fromLat!,
                        ),
                        zoom: 5,
                      ),
                    ),
                    animation: const MapAnimation(duration: 2.0),
                  );
                }
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
        },
      ),
    );
  }

  Future<void> _requestRoutes(List<OrderPoint> data) async {
    for (int i = 0; i < data.length; i++) {
      final double? lat = double.tryParse(data[i].lat!);
      final double? long = double.tryParse(data[i].long!);
      if (lat != null && long != null) {
        placemarks.add(
          PlacemarkMapObject(
            mapId: MapObjectId('placeMark $i'),
            point: Point(
              latitude: lat, // data[i].lat as double,
              longitude: long, // data[i].long as double,
            ),
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    'assets/images/${i == data.length - 1 ? "route_end" : i == 0 ? "route_start" : "route_stop_by"}.png'),
                scale: 1)),
          ),
        );
      }
    }

    for (int i = 0; i < placemarks.length; i++) {
      mapObjects.add(placemarks[i]);
      points.add(
        RequestPoint(
          point: placemarks[i].point,
          requestPointType: RequestPointType.wayPoint,
        ),
      );
    }

    final DrivingSessionResult result = await YandexDriving.requestRoutes(
      points: points,
      drivingOptions: const DrivingOptions(
        initialAzimuth: 0,
        routesCount: 1,
        avoidTolls: false,
      ),
    ).result;

    if (result.routes != null) {
      results.add(result);
      for (int i = 0; i < result.routes!.length; i++) {
        mapObjects.add(
          PolylineMapObject(
            mapId: MapObjectId('route_${i}_polyline'),
            polyline: Polyline(
              points: result.routes![i].geometry,
            ),
            // coordinates: result.routes![i].geometry,
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
