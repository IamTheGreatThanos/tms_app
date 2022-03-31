import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:europharm_flutter/widgets/main_text_field/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class OrderDetails extends StatefulWidget {
  final OrderData ordersData;
  final List<MapObject<dynamic>> mapObjects;

  const OrderDetails({
    Key? key,
    required this.ordersData,
    required this.mapObjects,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _controller = PageController();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          print(_tabController.index);
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
        body: BlocConsumer<BlocOrderCard, StateBlocOrderCard>(
          listener: (context, state) {
            if (state is StateSuccessfullyScanned) {
              showAppDialog(context, title: "Успешно отсканирован ${state.barcode}");
            }
          },
          builder: (context, state) {
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
                        //Yandex Map
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorPalette.background,
                                borderRadius: BorderRadius.circular(100)),
                            width: 700,
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
                        SizedBox(
                          height: 28,
                        ),
                        SizedBox(
                          width: 700,
                          height: MediaQuery.of(context).size.height / 2,
                          child: TabBarView(children: [
                            Center(
                                child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 17, left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(9),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF22863A)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: SvgPicture.asset(
                                              "assets/images/svg/box.svg")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.ordersData.points?[index].name ??
                                            "No data",
                                        style: ProjectTextStyles.ui_14Medium
                                            .copyWith(color: Colors.black),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: widget.ordersData.points?.length,
                            )),
                            Center(
                                child: Text(
                              "1",
                              style: TextStyle(fontSize: 40),
                            )),
                            Center(
                                child: Text(
                              "1",
                              style: TextStyle(fontSize: 40),
                            )),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, bottom: 24),
                  child: GestureDetector(
                      onTap: () async {
                        showCreatePasswordBottomDialog(context);
                        // String barcodeScanRes =
                        //     await FlutterBarcodeScanner.scanBarcode(
                        //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                        // print(barcodeScanRes);
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

void showCreatePasswordBottomDialog(BuildContext context) {
  showAppBottomSheet(context,
      initialChildSize: 0.45,
      useRootNavigator: true,
      child: _BuildScanMethodChoose(
        blocContext: context,
      ));
}

class _BuildScanMethodChoose extends StatelessWidget {
  final BuildContext blocContext;

  const _BuildScanMethodChoose({Key? key, required this.blocContext})
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
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              String barcode = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', true, ScanMode.BARCODE);
              if (barcode.isNotEmpty) {
                Navigator.pop(context, barcode);
                blocContext
                    .read<BlocOrderCard>()
                    .add(EventScanBarcode(barcode: barcode));
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
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showBarcodeEnterDialog(context, blocContext);
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

void showBarcodeEnterDialog(BuildContext context, BuildContext blocContext) {
  showAppBottomSheet(context,
      initialChildSize: 0.45,
      useRootNavigator: true,
      child: BuildBarcodeEnterField(blocContext: blocContext));
}

class BuildBarcodeEnterField extends StatefulWidget {
  final BuildContext blocContext;

  const BuildBarcodeEnterField({Key? key, required this.blocContext})
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
          Text(
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
              widget.blocContext
                  .read<BlocOrderCard>()
                  .add(EventScanBarcode(barcode: controller.text));
              Navigator.pop(context, controller.text);
            },
          )
        ],
      ),
    );
  }
}
