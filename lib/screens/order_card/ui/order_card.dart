import 'dart:async';
import 'dart:math';

import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart'
    as od;
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/app_loader_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:another_xlider/another_xlider.dart';
import '../../../widgets/main_button/main_button.dart';
import '../../../widgets/main_text_field/app_text_field.dart';
import '../bloc/bloc_order_card.dart';
import 'cause_bottom_sheet.dart';

class OrderCard extends StatefulWidget {
  final od.OrdersData order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  List<String> cities = [
    "Нур-Султан",
    "Алмата",
    "Шымкент",
  ];
  final List<DrivingSessionResult> results = [];
  Duration duration = const Duration(minutes: 30);
  final Placemark startPlacemark = Placemark(
    mapId: const MapObjectId('start_placemark'),
    point: const Point(latitude: 43.238949, longitude: 76.889709),
    icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage(
            'assets/images/png/route_start.png'),
        scale: 0.3)),
  );
  final Placemark stopByPlacemark = Placemark(
    mapId: const MapObjectId('stop_by_placemark'),
    point: const Point(latitude: 43.605108, longitude: 73.763114),
    icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage(
            'assets/images/png/route_stop_by.png'),
        scale: 0.3)),
  );
  final Placemark endPlacemark = Placemark(
      mapId: const MapObjectId('end_placemark'),
      point: const Point(latitude: 49.804684, longitude: 73.109383),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
              'assets/images/png/route_end.png'),
          scale: 0.3)));

  double _lowerValue = 0;
  String? selectedValue;

  // Timer? timer;
  late final List<MapObject> mapObjectsMain = [startPlacemark, endPlacemark];

  Future<void> _init(Future<DrivingSessionResult> result) async {
    try {
      await _handleResult(await result);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    if (result.error != null) {
      if (kDebugMode) {
        print('Error: ${result.error}');
      }
      return;
    }

    setState(() {
      results.add(result);
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjectsMain.add(Polyline(
          mapId: MapObjectId('route_${i}_polyline'),
          coordinates: route.geometry,
          strokeColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: startPlacemark.point,
              requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: stopByPlacemark.point,
              requestPointType: RequestPointType.viaPoint),
          RequestPoint(
              point: endPlacemark.point,
              requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));
    _init(resultWithSession.result);
    selectedValue = cities[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: BlocProvider<BlocOrderCard>(
        create: (context) =>
            BlocOrderCard(repository: context.read<GlobalRepository>())
              ..add(EventInitialOrderCard(widget.order.id!)),
        child: Scaffold(
          backgroundColor: ColorPalette.white,
          appBar: AppBar(
            title: const Text(
              "#222222",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/images/svg/arrow_back.svg",
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              YandexMap(
                                mapObjects: mapObjectsMain,
                                fastTapEnabled: true,
                                mode2DEnabled: true,
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorPalette.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.5,
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 6,
                                        width: 6,
                                        decoration: BoxDecoration(
                                          color: ColorPalette.red,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "LIVE",
                                        style: ProjectTextStyles.ui_12Medium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "24 ноября, 20:08",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.commonGrey),
                              ),
                              const Text("Karagandy, KZ")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "24 ноября, 20:08",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.commonGrey),
                              ),
                              const Text("Bishkek, KZ")
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "KRG",
                            style: ProjectTextStyles.ui_12Medium
                                .copyWith(color: ColorPalette.main),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 90,
                                child: Container(
                                  height: 80,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: FlutterSlider(
                                    jump: false,
                                    disabled: true,
                                    selectByTap: true,
                                    // visibleTouchArea: true,
                                    max: 500,
                                    min: 0,
                                    values: [_lowerValue],
                                    trackBar: const FlutterSliderTrackBar(
                                        activeDisabledTrackBarColor:
                                            ColorPalette.commonBlue,
                                        activeTrackBarHeight: 1,
                                        inactiveTrackBarHeight: 1),
                                    onDragCompleted:
                                        (handlerIndex, lowerValue, upperValue) {
                                      _lowerValue = lowerValue;

                                      setState(() {
                                        _lowerValue = lowerValue;
                                      });
                                    },
                                    onDragStarted:
                                        (handlerIndex, lowerValue, upperValue) {
                                      _lowerValue = lowerValue;

                                      setState(() {
                                        _lowerValue = lowerValue;
                                      });
                                    },

                                    handler: FlutterSliderHandler(
                                      // rightHandler: customHandler(Icons.chevron_left),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Material(
                                        // type: MaterialType.canvas,
                                        color: ColorPalette.main,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                            width: 18,
                                            height: 18,
                                            padding: const EdgeInsets.all(7),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 4,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "FRU",
                            style: ProjectTextStyles.ui_12Medium
                                .copyWith(color: ColorPalette.dark),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                      'assets/images/png/orders_truck.png'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Mercedes-Benz Sprinter",
                                        style: ProjectTextStyles.ui_16Medium,
                                      ),
                                      Text(
                                        "A 986 DBN",
                                        style: ProjectTextStyles.ui_12Medium
                                            .copyWith(
                                                color: ColorPalette.darkGrey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            BlocConsumer<BlocOrderCard, StateBlocOrderCard>(
                              listener: (context, state) {
                                if (state is StateLoadingOrderCard) {
                                  context.loaderOverlay.show();
                                } else {
                                  context.loaderOverlay.hide();
                                }
                                if (state is StateOrderCardError) {
                                  showAppDialog(context,
                                      body: state.error.message);
                                }
                                if (state is StateStartSuccess) {
                                  showAppDialog(context,
                                      body: "заказ успешно запущен");
                                  Navigator.of(context).pop();
                                  setState(() {
                                    widget.order.status = "accepted";
                                  });
                                  // context.read<BlocOrdersScreen>().add(
                                  //     EventInitialOrdersScreen(cityId:))
                                }
                                if (state is StateStopSuccess) {
                                  showAppDialog(context,
                                      body: "заказ успешно остановлен");
                                  Navigator.of(context).pop();
                                  setState(() {
                                    widget.order.status = "send";
                                  });
                                  // context.read<BlocOrdersScreen>().add(
                                  //     EventInitialOrdersScreen(cityId:))
                                }
                              },
                              buildWhen: (p, c) => c is StateLoadDataOrderCard,
                              builder: (context, state) {
                                if (state is StateLoadDataOrderCard) {
                                  // if (state.orders.isEmpty) {
                                  //   return Center(
                                  //     child: Text(
                                  //       S.of(context).no_orders,
                                  //       style: ProjectTextStyles.ui_16Medium.copyWith(
                                  //         color: ColorPalette.commonGrey,
                                  //       ),
                                  //     ),
                                  //   );
                                  // } else {
                                  return _BuildOrderItem(
                                    order: widget.order,
                                  );
                                  // return ListView.builder(
                                  //     physics:
                                  //         const NeverScrollableScrollPhysics(),
                                  //     shrinkWrap: true,
                                  //     itemCount: 1,
                                  //     // state.orders.length,
                                  //     itemBuilder: (context, index) {
                                  //       return _BuildOrderItem(
                                  //         order: widget.order,
                                  //       );
                                  //     });
                                  // }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Hatch Mark Example*/
                  ],
                ),
              ),

              ///Button
              BlocBuilder<BlocOrderCard, StateBlocOrderCard>(
                builder: (context, state) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: widget.order.status == "accepted"
                        ? GestureDetector(
                            onTap: () {
                              // showCauseBottomSheet(context);
                              showAppBottomSheet(context,
                                      initialChildSize: 0.45,
                                      useRootNavigator: true,
                                      child: const BuildCauses())
                                  .then((value) {
                                if (value != null) {
                                  if (value == items[0] ||
                                      value == items[1] ||
                                      value == items[2]) {
                                    context
                                        .read<BlocOrderCard>()
                                        .add(EventStopOrder(cause: "relax"));
                                    // startTimer();
                                    showAppBottomSheet(context,
                                        // initialChildSize: 0.5,
                                        useRootNavigator: true,
                                        child: Column(
                                          children: [
                                            const Text("Перерыв"),
                                            SizedBox(
                                                height: 100,
                                                child: TimerPage(
                                                  duration: Duration(
                                                      minutes: value == items[0]
                                                          ? 30
                                                          : value == items[1]
                                                              ? 480
                                                              : 15),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18.0,
                                                      horizontal: 10),
                                              child: MainButton(
                                                onTap: () {
                                                  context
                                                      .read<BlocOrderCard>()
                                                      .add(EventStartOrder());
                                                },
                                                title: "Выйти на линию",
                                              ),
                                            )
                                          ],
                                        ));
                                  }
                                  if (value == items[4]) {
                                    context.read<BlocOrderCard>().add(
                                        EventStopOrder(cause: "change_driver"));
                                    showAppBottomSheet(context,
                                        // initialChildSize: 0.5,
                                        useRootNavigator: true,
                                        child: Column(
                                          children: [
                                            const Text(
                                                "Передать заказ другому водителю"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AppTextField(
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                hintText: "Поиск",
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: EmployerCard(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18.0,
                                                      horizontal: 10),
                                              child: MainButton(
                                                onTap: () {},
                                                title: "Готово",
                                              ),
                                            )
                                          ],
                                        ));
                                  }
                                  // if (value == "Закончил рабочий день") {
                                  //   context.read<BlocOrderCard>().add(
                                  //       EventStopOrder(cause: "finish_day"));
                                  // }
                                  // if (value == "Отмена заказа") {
                                  //   context
                                  //       .read<BlocOrderCard>()
                                  //       .add(EventStopOrder(cause: "decline"));
                                  // }
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  color: ColorPalette.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: ColorPalette.main)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      "Стоп",
                                      style: ProjectTextStyles.ui_16Medium
                                          .copyWith(
                                        color: ColorPalette.main,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 3,
                                      right: 15,
                                      child: SvgPicture.asset(
                                        "assets/images/svg/chevrone_down.svg",
                                        width: 24,
                                        height: 24,
                                        color: ColorPalette.main,
                                      ))
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              context
                                  .read<BlocOrderCard>()
                                  .add(EventStartOrder());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  color: ColorPalette.main,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      "Поехали",
                                      style: ProjectTextStyles.ui_16Medium
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 3,
                                      right: 15,
                                      child: SvgPicture.asset(
                                          "assets/images/svg/arrow_right.svg"))
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlutterSliderHandler customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: const Offset(0, 1))
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
          child: Icon(
            icon,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
    );
  }
}

class _BuildOrderItem extends StatelessWidget {
  final od.OrdersData order;

  const _BuildOrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        // color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, top: 40),
              //   child: DottedLine(
              //     direction: Axis.vertical,
              //     dashColor: ColorPalette.commonGrey,
              //     lineLength: MediaQuery.of(context).size.height * 0.75,
              //   ),
              // ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 33,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorPalette.main,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                            "assets/images/svg/orders_geo.svg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat("dd MMMM")
                                  .format(order.startDate ?? DateTime.now()),
                              style: ProjectTextStyles.ui_12Medium
                                  .copyWith(color: ColorPalette.commonGrey),
                            ),
                            Text(
                              order.from ?? S.of(context).no_data,
                              // order.customerName ?? S.of(context).no_data,
                              style: ProjectTextStyles.ui_16Medium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < order.points!.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: Alignment.topLeft,
                        childrenPadding: const EdgeInsets.only(left: 40),
                        title: Row(
                          children: [
                            Container(
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.lock_clock_outlined,
                                size: 30,
                              ),
                              // SvgPicture.asset("assets/images/svg/orders_geo.svg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat("dd MMMM").format(
                                        order.points?[i].date ??
                                            DateTime.now()),
                                    style: ProjectTextStyles.ui_12Medium
                                        .copyWith(
                                            color: ColorPalette.commonGrey),
                                  ),
                                  Text(
                                    order.points?[i].address ??
                                        S.of(context).no_data,
                                    // order.customerName ?? S.of(context).no_data,
                                    style: ProjectTextStyles.ui_16Medium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Количество товаров - ${order.points?[i].countProducts.toString() ?? S.of(context).no_data} ",
                                textAlign: TextAlign.left,
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.black),
                              ),
                              for (int k = 0;
                                  k < order.points![i].products!.length;
                                  k++)
                                Text(
                                  order.points![i].products?[k].name ??
                                      S.of(context).no_data,
                                  style: ProjectTextStyles.ui_12Medium
                                      .copyWith(color: ColorPalette.commonGrey),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorPalette.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    SvgPicture.asset("assets/images/svg/orders_geo_done.svg"),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("dd MMMM")
                        .format(order.endDate ?? DateTime.now()),
                    style: ProjectTextStyles.ui_12Medium
                        .copyWith(color: ColorPalette.commonGrey),
                  ),
                  Text(
                    order.to ?? S.of(context).no_data,
                    // order.customerName ?? S.of(context).no_data,
                    style: ProjectTextStyles.ui_16Medium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  final Duration duration;

  const TimerPage({Key? key, required this.duration}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? timer;

  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (kDebugMode) {
      print("1");
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration!.inSeconds - addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  TextStyle bold44 = const TextStyle(fontSize: 44, color: Colors.black);

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration!.inMinutes.remainder(60));
    final seconds = twoDigits(duration!.inSeconds.remainder(60));
    final hours = twoDigits(duration!.inHours.remainder(24));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(hours, style: bold44),
              const Text(
                "Ч",
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ":",
            style: bold44,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(minutes, style: bold44),
              const Text(
                "Мин",
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ":",
            style: bold44,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(seconds, style: bold44),
              const Text(
                "Сек",
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTime(),
    );
  }
}

class EmployerCard extends StatefulWidget {
  const EmployerCard({Key? key}) : super(key: key);

  @override
  State<EmployerCard> createState() => _EmployerCardState();
}

class _EmployerCardState extends State<EmployerCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Бауыржан Тайманов",
              style: ProjectTextStyles.ui_16Regular,
            ),
            Text(
              "Водитель-экспедитор",
              style: ProjectTextStyles.ui_12Regular
                  .copyWith(color: ColorPalette.gray),
            ),
          ],
        )
      ],
    );
  }
}
