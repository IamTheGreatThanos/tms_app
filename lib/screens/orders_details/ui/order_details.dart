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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:another_xlider/another_xlider.dart';
import '../../order_card/ui/order_card.dart';
import '../bloc/bloc_order_details.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> with TickerProviderStateMixin {
  List<String> buttonText = [
    "Дальше в путь",
    "Принять оплату",
    "Принять и подписать",
  ];
  int _current=0;

  late TabController _tabController;
  late PageController _controller;
  String? selectedValue;
  final RestorableDouble _continuousValue = RestorableDouble(25);

  @override
  void initState() {
    super.initState();
    // selectedValue = cities[0];
    _tabController = TabController(length: 3, vsync: this);
    _controller=PageController();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging)

      setState(() {
        print(_tabController.index);
        _current=_tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
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
                        height: _current==1? 500:200,
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
                                        borderRadius: BorderRadius.circular(100),
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      ],
                    ),
                  ),
                  /*Hatch Mark Example*/
                  SizedBox(
                    width: 700,
                    child: TabBar(
                      isScrollable: false,
                      indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), // Creates border
                            color: ColorPalette.main), //Change background color from here
                      labelPadding: EdgeInsets.all(0),
                      labelColor: ColorPalette.white,
                      // indicatorColor: ColorPalette.red,
                      labelStyle: ProjectTextStyles.ui_16Medium,
                      unselectedLabelColor: ColorPalette.grey,
                      controller: _tabController,
                      onTap: (index){
                        setState(() {
                          _current=index;
                          _controller.animateToPage(_current, duration: Duration(milliseconds: 50), curve: Curves.ease);

                        });

                      },

                      tabs:  <Widget>[
                        Tab(
                          child: Text("Товар"),
                        ),
                        Tab(
                          child:Text("В путь"),
            // Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 33,vertical: 12),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20),
                          //       color: ColorPalette.blue,
                          //     ),
                          //     child: Text("Товар",style: ProjectTextStyles.ui_16Medium.copyWith(color: ColorPalette.white),)),
                        ),
                        Tab(
                          child:  Text("Оплата",),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    // width: 500,
                    height: _current==0 ? 300:50,
                    child: PageView(
                      controller: _controller,
                        onPageChanged: (index){
                        setState(() {
                          _current=index;
                          _tabController.index=index;

                        });
                        },
                        children: [
                          BlocConsumer<BlocOrderDetails, StateBlocOrderDetails>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is StateLoadDataOrderDetails) {
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
                          Text(""),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(Icons.monetization_on, size: 30,color: ColorPalette.secondaryMain,),
                              ),
                              SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Тип оплаты: ',
                                        style: ProjectTextStyles.ui_16Medium,
                                        children: const <TextSpan>[
                                          TextSpan(text: 'Наличными', style: TextStyle(color: ColorPalette.secondaryMain)),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Сумма оплаты: ',
                                        style: ProjectTextStyles.ui_16Medium,
                                        children: const <TextSpan>[
                                          TextSpan(text: '95 310Т', style: TextStyle(color: ColorPalette.secondaryMain)),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10),
            child: MainButton(
              title: buttonText[_tabController.index],
                color: _current==2?ColorPalette.green:ColorPalette.main,
                // "Отсканировать",
              // S.of(context).next_step,
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderCard()));
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
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
      decoration: BoxDecoration(
        // color: ColorPalette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: [
                for(int i=0;i<8;i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.margin, color: ColorPalette.main,size: 22,),
                        ),
                        Text(
                          "ANGZ0112201-1-7; ANGZ0112201${i*2}",
                          style: ProjectTextStyles.ui_12Medium
                              .copyWith(color: ColorPalette.commonGrey),
                        ),
                      ],
                    ),
                  ),
            ],
          ),


        ],
      ),
    );
  }
}
