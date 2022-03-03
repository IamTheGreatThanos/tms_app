import 'package:dotted_line/dotted_line.dart';
import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders.dart';
import 'package:europharm_flutter/screens/orders_screen/bloc/bloc_orders_screen.dart';
import 'package:europharm_flutter/screens/user_confirmation/bloc/bloc_verification.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/personal_info_verification.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:another_xlider/another_xlider.dart';
import '../bloc/bloc_order_card.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  List<String> cities = [
    "Нур-Султан",
    "Алмата",
    "Шымкент",
  ];
  double _lowerValue = 50;
  double _upperValue = 180;
  double _currentSliderValue = 20;
  String? selectedValue;
  final RestorableDouble _continuousValue = RestorableDouble(25);

  @override
  void initState() {
    super.initState();
    selectedValue = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocOrderCard()..add(EventInitialOrderCard()),
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        appBar: AppBar(
          title: Text(
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
            const SizedBox(
              height: 23,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              const YandexMap(
                                tiltGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                modelsEnabled: false,
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
                    //Yandex Map
                    SizedBox(height: 15),
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
                                "24 нояюря, 20:08",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.commonGrey),
                              ),
                              Text("Karagandy, KZ")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "24 нояюря, 20:08",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.commonGrey),
                              ),
                              Text("Bishkek, KZ")
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: FlutterSlider(
                                    jump: false,
                                    disabled: false,
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
                                    // handlerHeight: 0,
                                    // handlerWidth: 0,
                                    // handler: customHandler(Icons.circle_outlined),
                                    // rightHandler: customHandler(Icons.chevron_left),
                                    // tooltip: FlutterSliderTooltip(
                                    //   // leftPrefix: const Icon(
                                    //   //   Icons.circle_outlined,
                                    //   //   size: 10,
                                    //   //   color: Colors.black45,
                                    //   // ),
                                    //   // rightSuffix: Icon(
                                    //   //   Icons.attach_money,
                                    //   //   size: 19,
                                    //   //   color: Colors.black45,
                                    //   // ),
                                    //   textStyle: TextStyle(fontSize: 17, color: Colors.black45),
                                    // ),
                                    //сколько отрезков в слайдере
                                    // fixedValues: [
                                    //   FlutterSliderFixedValue(percent: 0, value: '1000'),
                                    //   FlutterSliderFixedValue(percent: 10, value: '10K'),
                                    //   FlutterSliderFixedValue(percent: 50, value: 50000),
                                    //   FlutterSliderFixedValue(percent: 80, value: '80M'),
                                    //   FlutterSliderFixedValue(percent: 100, value: '100B'),
                                    // ],
                                    // onDragging: (handlerIndex, lowerValue, upperValue) {
                                    //   lowerValue = lowerValue;
                                    //
                                    //   // _upperValue = upperValue;
                                    //
                                    //   setState(() {
                                    //     // _lowerValue = 180;
                                    //
                                    //   });
                                    // },
                                    onDragCompleted:
                                        (handlerIndex, lowerValue, upperValue) {
                                      _lowerValue = lowerValue;
                                      _upperValue = upperValue;

                                      setState(() {
                                        _lowerValue = lowerValue;
                                        _upperValue = upperValue;
                                      });
                                    },
                                    onDragStarted:
                                        (handlerIndex, lowerValue, upperValue) {
                                      _lowerValue = lowerValue;
                                      _upperValue = upperValue;

                                      setState(() {
                                        _lowerValue = lowerValue;
                                        _upperValue = upperValue;
                                      });
                                    },

                                    handler: FlutterSliderHandler(
                                      // rightHandler: customHandler(Icons.chevron_left),
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: Material(
                                        // type: MaterialType.canvas,
                                        color: ColorPalette.main,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                            width: 18,
                                            height: 18,
                                            padding: EdgeInsets.all(7),
                                            child: Icon(
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/png/orders_truck.png'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Mercedes-Benz Sprinter",
                                style: ProjectTextStyles.ui_16Medium,
                              ),
                              Text(
                                "A 986 DBN",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.darkGrey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /*Hatch Mark Example*/

                    BlocConsumer<BlocOrderCard, StateBlocOrderCard>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is StateLoadDataOrderCard) {
                          if (state.orders.isEmpty) {
                            return Center(
                              child: Text(
                                S.of(context).no_orders,
                                style: ProjectTextStyles.ui_16Medium.copyWith(
                                  color: ColorPalette.commonGrey,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 1,
                                // state.orders.length,
                                itemBuilder: (context, index) {
                                  return _BuildOrderItem(
                                    order: state.orders[index],
                                  );
                                });
                          }
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: MainButton(
                title: "Поехали",
                // S.of(context).next_step,
                onTap: () {
                  // if (state is StateVerificationFirstStep
                  // // && vmodel.firstStepValidated
                  // ) {
                  //   context
                  //       .read<BlocVerification>()
                  //       .add(EventVerificationSecondStep());
                  // }
                  // if (state is StateVerificationSecondStep
                  // // && vmodel.secondStepValidated
                  // ) {
                  //   context
                  //       .read<BlocVerification>()
                  //       .add(EventVerificationThirdStep());
                  // }
                  // if (state is StateVerificationThirdStep) {
                  //   context
                  //       .read<BlocVerification>()
                  //       .add(EventVerificationFourthStep());
                  // }
                  // if (state is StateVerificationFourthStep
                  // // && vmodel.lastStepValidated
                  // ) {
                  //   AppRouter.push(context, SuccessfulScreen());
                  //   // context
                  //   //     .read<BlocVerification>()
                  //   //     .add(EventVerificationFourthStep());
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlutterSliderHandler customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(5),
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
  final OrdersResponse order;

  const _BuildOrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 40),
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashColor: ColorPalette.commonGrey,
                    lineLength: MediaQuery.of(context).size.height * 0.75,
                  ),
                ),
              ),
              Column(
                children: [
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.only(left: 40),
                      expandedAlignment: Alignment.topLeft,
                      title: Row(
                        children: [
                          Container(
                            width: 33,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: order.isCurrent
                                  ? ColorPalette.main
                                  : ColorPalette.lightBlue,
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
                                  "20 ноября 2021 в 14:45",
                                  style: ProjectTextStyles.ui_12Medium
                                      .copyWith(color: ColorPalette.commonGrey),
                                ),
                                Text(
                                  "Склад Europharm в Караганде",
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
                              "Количество товара: 8",
                              textAlign: TextAlign.left,
                              style: ProjectTextStyles.ui_12Medium
                                  .copyWith(color: ColorPalette.black),
                            ),
                            for (int i = 0; i < 8; i++)
                              Text(
                                "ANGZ0112201-1-7; ANGZ0112201${i * 2}",
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.commonGrey),
                              ),
                          ],
                        ),
                      ]),
                  for (int i = 0; i < 10; i++)
                    ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: Alignment.topLeft,
                        childrenPadding: EdgeInsets.only(left: 40),
                        title: Row(
                          children: [
                            Container(
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
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
                                    "20 ноября 2021 в 14:45",
                                    style: ProjectTextStyles.ui_12Medium
                                        .copyWith(
                                            color: ColorPalette.commonGrey),
                                  ),
                                  Text(
                                    "Z05P1P4, ​проспект ",
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
                                "Количество товара: 8",
                                textAlign: TextAlign.left,
                                style: ProjectTextStyles.ui_12Medium
                                    .copyWith(color: ColorPalette.black),
                              ),
                              for (int i = 0; i < 8; i++)
                                Text(
                                  "ANGZ0112201-1-7; ANGZ0112201${i * 2}",
                                  style: ProjectTextStyles.ui_12Medium
                                      .copyWith(color: ColorPalette.commonGrey),
                                ),
                            ],
                          ),
                        ]),
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
                    order.addresses.first.streetName ?? S.of(context).no_data,
                    style: ProjectTextStyles.ui_16Medium,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    order.addresses.first.title ?? S.of(context).no_data,
                    style: ProjectTextStyles.ui_12Medium
                        .copyWith(color: ColorPalette.commonGrey),
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
