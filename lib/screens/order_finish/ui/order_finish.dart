import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/screens/order_finish/bloc/bloc_order_finish.dart';
import 'package:europharm_flutter/screens/order_finish/ui/widgets/success_order_finished.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class OrderFinish extends StatefulWidget {
  final List<MapObject<dynamic>> mapObjects;

  const OrderFinish({
    Key? key,
    required this.mapObjects,
  }) : super(key: key);

  @override
  _OrderFinishState createState() => _OrderFinishState();
}

class _OrderFinishState extends State<OrderFinish>
    with TickerProviderStateMixin {
  List<String> buttonText = [
    "Дальше в путь",
    "Принять оплату",
    "Принять и подписать",
  ];
  int _current = 0;

  late TabController _tabController;
  late PageController _controller;
  String? selectedValue;
  int? productId;

  @override
  void initState() {
    super.initState();
    productId = 0;
    _tabController = TabController(length: 3, vsync: this);
    _controller = PageController();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          if (kDebugMode) {
            print(_tabController.index);
          }
          _current = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: ColorPalette.white,
        body: BlocConsumer<BlocOrderFinish, StateBlocOrderFinish>(
          listener: (context, state) {
            if (state is StateOrderFinishError) {
              showAppDialog(context,
                  title: state.error.message,
                  onTap: () => Navigator.pop(context));
            }
          },
          buildWhen: (p, c) => c is StateLoadOrderPoint,
          builder: (context, state) {
            if (state is StateLoadOrderPoint) {
              // if(state.areAllFinished){
              //   setState(() {
              //     _current = 2;
              //     _controller.animateToPage(_current,
              //         duration:
              //         const Duration(milliseconds: 50),
              //         curve: Curves.ease);
              //   });
              // }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: ColorPalette.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    YandexMap(
                                      mapObjects: widget.mapObjects,
                                      fastTapEnabled: true,
                                      mode2DEnabled: true,
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorPalette.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
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
                                              style:
                                                  ProjectTextStyles.ui_12Medium,
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
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "20 ноября 2021 в 14:45",
                                      style: ProjectTextStyles.ui_12Medium
                                          .copyWith(
                                              color: ColorPalette.commonGrey),
                                    ),
                                    const Text(
                                      "Склад Europharm в Караганде",
                                      // order.customerName ?? S.of(context).no_data,
                                      style: ProjectTextStyles.ui_16Medium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorPalette.background,
                                  borderRadius: BorderRadius.circular(100)),
                              height: 46,
                              child: TabBar(
                                isScrollable: false,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorPalette.main),
                                labelPadding: const EdgeInsets.all(0),
                                labelColor: ColorPalette.white,
                                labelStyle: ProjectTextStyles.ui_16Medium,
                                unselectedLabelColor: ColorPalette.commonGrey,
                                controller: _tabController,
                                onTap: (index) {
                                  setState(() {
                                    _current = index;
                                    _controller.animateToPage(_current,
                                        duration:
                                            const Duration(milliseconds: 50),
                                        curve: Curves.ease);
                                  });
                                },
                                tabs: const [
                                  Tab(
                                    child: Text("Товар"),
                                  ),
                                  Tab(
                                    child: Text("В путь"),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Оплата",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          SizedBox(
                            width: 700,
                            height: MediaQuery.of(context).size.height - 389,
                            child: PageView(controller: _controller, children: [
                              Center(
                                  child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 17, left: 10, right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (productId ==
                                              state.orderPoint.products?[index]
                                                  .id) {
                                            productId = 0;
                                          } else {
                                            productId = state.orderPoint
                                                .products?[index].id!;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: state.orderPoint
                                                      .products?[index].id ==
                                                  productId
                                              ? ColorPalette.main
                                                  .withOpacity(0.1)
                                              : null,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF22863A)
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        "assets/images/svg/box.svg")),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  state
                                                          .orderPoint
                                                          .products?[index]
                                                          .name ??
                                                      "No data",
                                                  style: ProjectTextStyles
                                                      .ui_14Medium
                                                      .copyWith(
                                                          color: Colors.black),
                                                )
                                              ],
                                            ),
                                            if (state.orderPoint
                                                    .products?[index].status ==
                                                "finished")
                                              SvgPicture.asset(
                                                  "assets/images/svg/ic_check.svg"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: state.orderPoint.products?.length,
                              )),
                              Container(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: ColorPalette.main
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/images/svg/payments.svg"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Тип оплаты: ",
                                              style: ProjectTextStyles
                                                  .ui_16Medium),
                                          TextSpan(
                                              text: "Наличными",
                                              style: ProjectTextStyles
                                                  .ui_16Medium
                                                  .copyWith(
                                                      color:
                                                          ColorPalette.main)),
                                        ])),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Сумма оплаты: ",
                                              style: ProjectTextStyles
                                                  .ui_16Medium),
                                          TextSpan(
                                              text: "95 310. 00 ₸",
                                              style: ProjectTextStyles
                                                  .ui_16Medium
                                                  .copyWith(
                                                      color:
                                                          ColorPalette.main)),
                                        ])),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                    child: GestureDetector(
                        onTap:  () {
                                showCreatePasswordBottomDialog(
                                    context, productId!);
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
                                  "Отсканировать",
                                  style: ProjectTextStyles.ui_16Medium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 18,
                                  child: SvgPicture.asset(
                                    "assets/images/svg/scan.svg",
                                  ))
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, bottom: 24),
                    child: state.areAllFinished && _current == 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _current = 1;
                                _controller.animateToPage(_current,
                                    duration: const Duration(milliseconds: 50),
                                    curve: Curves.ease);
                                _tabController.animateTo(_current);
                              });
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
                                      "Дальше в путь",
                                      style: ProjectTextStyles.ui_16Medium
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 15,
                                      child: SvgPicture.asset(
                                        "assets/images/svg/arrow_right.svg",
                                      ))
                                ],
                              ),
                            ))
                        : _current == 0
                            ? GestureDetector(
                                onTap: productId != 0
                                    ? () {
                                        showCreatePasswordBottomDialog(
                                            context, productId!);
                                      }
                                    : null,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                      color: productId != 0
                                          ? ColorPalette.main
                                          : ColorPalette.lightGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          "Отсканировать",
                                          style: ProjectTextStyles.ui_16Medium
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 18,
                                          child: SvgPicture.asset(
                                            "assets/images/svg/scan.svg",
                                          ))
                                    ],
                                  ),
                                ))
                            : _current == 1
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _current = 2;
                                        _controller.animateToPage(_current,
                                            duration: const Duration(
                                                milliseconds: 50),
                                            curve: Curves.ease);
                                        _tabController.animateTo(_current);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.main,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Text(
                                              "Принять оплату",
                                              style: ProjectTextStyles
                                                  .ui_16Medium
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: 15,
                                              child: SvgPicture.asset(
                                                "assets/images/svg/arrow_right.svg",
                                              ))
                                        ],
                                      ),
                                    ))
                                : GestureDetector(
                                    onTap: () {
                                      AppRouter.pushReplacement(
                                          context, SuccessOrderFinished());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.main,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Text(
                                              "Принять и подписать",
                                              style: ProjectTextStyles
                                                  .ui_16Medium
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                  )
                ],
              );
            }
            return const Center(
              child: Text("1"),
            );
          },
        ),
      ),
    );
  }
}

void showCreatePasswordBottomDialog(BuildContext context, int productId) {
  showAppBottomSheet(context,
      initialChildSize: 0.45,
      useRootNavigator: true,
      child: _BuildScanMethodChoose(
        onScan: (code) =>
            context.read<BlocOrderFinish>().add(EventOrderProductFinish(
                  productId: productId,
                  code: code,
                )),
      ));
}

class _BuildScanMethodChoose extends StatelessWidget {
  final Function onScan;

  const _BuildScanMethodChoose({Key? key, required this.onScan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Center(
            child: Text(
              "Выберите способ сканирования",
              style: ProjectTextStyles.ui_16Medium.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              String barcode = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', true, ScanMode.BARCODE);
              if (barcode.isNotEmpty) {
                Navigator.pop(context, barcode);
                onScan.call(barcode);
                // blocContext.read<BlocOrderFinish>().add(EventOrderProductFinish(
                //     productId: productId, code: barcode));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: ColorPalette.main,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Сфотографировать",
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showBarcodeEnterDialog(context, onScan);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: ColorPalette.main,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Ручной сканнер",
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showBarcodeEnterDialog(BuildContext context, Function onScan) {
  showAppBottomSheet(context,
      initialChildSize: 0.45,
      useRootNavigator: true,
      child: BuildBarcodeEnterField(onScan: onScan));
}

class BuildBarcodeEnterField extends StatefulWidget {
  final Function onScan;

  const BuildBarcodeEnterField({Key? key, required this.onScan})
      : super(key: key);

  @override
  _BuildBarcodeEnterField createState() => _BuildBarcodeEnterField();
}

class _BuildBarcodeEnterField extends State<BuildBarcodeEnterField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Введите код",
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            controller: controller,
            hintStyle: ProjectTextStyles.ui_16Medium.copyWith(
              color: ColorPalette.commonGrey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            title: "Подтвердить",
            onTap: () {
              Navigator.pop(context, controller.text);
              widget.onScan(controller.text);
            },
          )
        ],
      ),
    );
  }
}
