import 'dart:developer';

import 'package:another_xlider/another_xlider.dart';
import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/screens/map_screen/data/bloc/map_cubit.dart';
import 'package:europharm_flutter/screens/map_screen/data/repo_map.dart';
import 'package:europharm_flutter/screens/map_screen/map.dart';
import 'package:europharm_flutter/screens/order_card/bloc/order_detail_bloc.dart';
import 'package:europharm_flutter/screens/order_card/bloc/empty_drivers_cubit.dart';
import 'package:europharm_flutter/screens/order_card/provider/order_detail_provider.dart';
import 'package:europharm_flutter/screens/order_card/ui/cause_bottom_sheet.dart';
import 'package:europharm_flutter/screens/order_card/ui/widgets/timer.dart';
import 'package:europharm_flutter/screens/order_card/ui/widgets/transfer_order_bottom_sheet.dart';
import 'package:europharm_flutter/screens/order_finish/bloc/point_page_bloc.dart';
import 'package:europharm_flutter/screens/order_finish/ui/point_page.dart';
import 'package:europharm_flutter/screens/orders_screen/bloc/orders_bloc.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:europharm_flutter/utils/app_router.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_bottom_sheet.dart';
import 'package:europharm_flutter/widgets/app_bottom_sheets/app_dialog.dart';
import 'package:europharm_flutter/widgets/app_loader_overlay.dart';
import 'package:europharm_flutter/widgets/main_button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderDTO order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  // double _lowerValue = 0;
  // PointDTO? point;
  // bool isScan = false;

  @override
  void initState() {
    Provider.of<OrderDetailProvider>(context, listen: false).init();
    BlocProvider.of<OrderDetailBloc>(context).add(OrderDetailEventReset());
    BlocProvider.of<OrderDetailBloc>(context).getCurrentOrder(widget.order);
    BlocProvider.of<EmptyDriversCubit>(context).getEmptyDrivers();
    BlocProvider.of<OrderDetailBloc>(context).add(
      OrderDetailRefreshEvent(
        orderId: widget.order.id,
      ),
    );
    super.initState();
    // int count = 0;

    // try {
    //   for (final element in widget.order.points!) {
    //     if (element.status == "finished") {
    //       count++;
    //     }
    //   }
    //   _lowerValue = count * 100 / widget.order.points!.length;
    // } catch (e) {
    //   _lowerValue = 0;
    // }
    // if (_lowerValue is! int) {
    //   _lowerValue = 0;
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "#0000000${widget.order.id}",
            style: const TextStyle(
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

        ///
        ///
        /// Scaffold Body
        ///
        ///
        body: Column(
          children: [
            Visibility(
              visible: widget.order.isCurrent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        //height: 300,
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: BlocProvider<MapCubit>(
                          create: (_) => MapCubit(
                            mapRepository: MapRepository(),
                            repository: context.read<GlobalRepository>(),
                          ),
                          child: SessionPage(
                            orderId: widget.order.id,
                            order: widget.order,
                            orderPoints: const [],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
                listener: (context, state) {
                  if (state is OrderDetailStateLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (state is OrderDetailStateError) {
                    showAppDialog(context, body: state.error.message);
                  }
                  if (state is OrderDetailStateStartSuccess) {
                    showAppDialog(context, body: "заказ успешно принят");
                    // Navigator.of(context).pop();
                    // setState(() {
                    //   widget.order.status = "accepted";
                    //   widget.order.isCurrent = true;
                    // });

                    BlocProvider.of<OrderDetailBloc>(context).add(
                      OrderDetailRefreshEvent(orderId: widget.order.id),
                    );
                    BlocProvider.of<OrdersBloc>(context).add(
                      EventInitialOrdersScreen(),
                    );
                  }
                  if (state is OrderDetailStateResumeSuccess) {
                    showAppDialog(context, body: "заказ успешно запущен");
                    Navigator.of(context).pop();
                    BlocProvider.of<OrderDetailBloc>(context).add(
                      OrderDetailRefreshEvent(orderId: widget.order.id),
                    );
                    // setState(() {
                    //   widget.order.status = "accepted";
                    // });
                  }
                  if (state is OrderDetailStateShowTimer) {
                    final time = state.startTimer.isBefore(DateTime.now())
                        ? Duration.zero
                        : state.startTimer.difference(DateTime.now());
                    showAppBottomSheet(
                      context,
                      useRootNavigator: true,
                      isDismissible: false,
                      enableDrag: false,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Перерыв",
                            style: ProjectTextStyles.ui_20Medium,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 100,
                            child: TimerPage(
                              duration: time,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                MainButton(
                                  width: 80,
                                  icon: "assets/images/svg/arrow_left.svg",
                                  iconColor: ColorPalette.white,
                                  onTap: () {
                                    Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                MainButton(
                                  width: MediaQuery.of(context).size.width -
                                      90 -
                                      20,
                                  onTap: () {
                                    context
                                        .read<OrderDetailBloc>()
                                        .add(OrderDetailEventResume());
                                    Navigator.pop(context);
                                  },
                                  title: "Выйти на линию",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is OrderDetailStateStopSuccess) {
                    showAppDialog(context, body: "заказ успешно остановлен");
                    Navigator.of(context).pop();
                    // setState(() {
                    //   widget.order.status = "stopped";
                    // });
                    BlocProvider.of<OrderDetailBloc>(context).add(
                      OrderDetailRefreshEvent(orderId: widget.order.id),
                    );
                  }

                  if (state is OrderDetailStateChangedDriverOrderCard) {
                    BlocProvider.of<OrdersBloc>(context).add(
                      EventInitialOrdersScreen(),
                    );
                    Navigator.pop(context);
                  }
                },
                buildWhen: (p, c) {
                  if (c is OrderDetailStateLoaded) {
                    return true;
                  }
                  // else if (p is OrderDetailStateLoaded &&
                  //     c is OrderDetailStateLoading) {
                  //   return true;
                  // }
                  else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is OrderDetailStateLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    DateFormat("dd MMMM, hh:mm")
                                        .format(state.order.startDate!),
                                    style:
                                        ProjectTextStyles.ui_12Medium.copyWith(
                                      color: ColorPalette.commonGrey,
                                    ),
                                  ),
                                  Text(state.order.from!),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    DateFormat("dd MMMM, hh:mm")
                                        .format(state.order.endDate!),
                                    style:
                                        ProjectTextStyles.ui_12Medium.copyWith(
                                      color: ColorPalette.commonGrey,
                                    ),
                                  ),
                                  Text(state.order.to!),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: ColorPalette.lightGrey,
                          thickness: 2,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: _BuildOrderItem(
                              order: state.order,
                              callback: ({
                                required bool isOpened,
                                required PointDTO orderPoint,
                              }) {
                                log('isOpened in _BuildOrderItem : $isOpened');
                                // setState(() {
                                //   isScan = isOpened;
                                //   Provider.of<OrderDetailProvider>(context,
                                //           listen: false)
                                //       .point = orderPoint;
                                // });
                                Provider.of<OrderDetailProvider>(context,
                                        listen: false)
                                    .isScan = isOpened;
                                Provider.of<OrderDetailProvider>(context,
                                        listen: false)
                                    .point = orderPoint;
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox(); // const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),

        ///
        ///
        /// FAB section
        ///
        ///
        floatingActionButton: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailStateLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 60,
                  ),
                  child: _FABWidget(
                    isScan: Provider.of<OrderDetailProvider>(context).isScan,
                    point: Provider.of<OrderDetailProvider>(context).point,
                    order: state.order,
                  ),
                  //   child: isScan &&
                  //           // point!.products!.isNotEmpty && // TODO
                  //           (state.order.status == "accepted" ||
                  //               state.order.status == "in_process")
                  //       ? GestureDetector(
                  //           onTap: () {
                  //             AppRouter.push(
                  //               context,
                  //               BlocProvider<BlocOrderFinish>(
                  //                 create: (context) => BlocOrderFinish(
                  //                   repository:
                  //                       context.read<GlobalRepository>(),
                  //                 )..add(
                  //                     EventOrderFinishInitial(
                  //                       pointId: point!.id,
                  //                     ),
                  //                   ),
                  //                 child: OrderFinish(
                  //                   order: state.order,
                  //                   isScan: widget.order.points!.first.id ==
                  //                       point!.id,
                  //                   // isScan: ,
                  //                 ),
                  //               ),
                  //             ).then(
                  //               (value) {
                  //                 context.read<OrderDetailBloc>().add(
                  //                       EventInitialOrderCard(
                  //                         state.order.id,
                  //                       ),
                  //                     );
                  //               },
                  //             );
                  //           },
                  //           child: Container(
                  //             padding: const EdgeInsets.symmetric(vertical: 16),
                  //             decoration: BoxDecoration(
                  //               color: ColorPalette.main,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Stack(
                  //               children: [
                  //                 Center(
                  //                   child: Text(
                  //                     "Приехал",
                  //                     style: ProjectTextStyles.ui_16Medium
                  //                         .copyWith(
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Positioned(
                  //                   top: 3,
                  //                   right: 15,
                  //                   child: SvgPicture.asset(
                  //                     "assets/images/svg/arrow_right.svg",
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       : state.order.status == "accepted" ||
                  //               state.order.status == "in_process"
                  //           ? GestureDetector(
                  //               onTap: () async {
                  //                 // showModalBottomSheet(
                  //                 //   context: context,
                  //                 //   isScrollControlled: true,
                  //                 //   isDismissible: true,
                  //                 //   backgroundColor: const Color(0xFFFFFFFF),
                  //                 //   shape: const RoundedRectangleBorder(
                  //                 //     borderRadius: BorderRadius.vertical(
                  //                 //       top: Radius.circular(16),
                  //                 //     ),
                  //                 //   ),
                  //                 //   builder: (context) {
                  //                 //     return const TransferOrderBottomSheet();
                  //                 //   },
                  //                 // );
                  //                 // return;
                  //                 await showAppBottomSheet(
                  //                   context,
                  //                   initialChildSize: 0.45,
                  //                   useRootNavigator: true,
                  //                   child: const BuildCauses(),
                  //                 ).then(
                  //                   (value) async {
                  //                     if (value != null) {
                  //                       if (value == items[0] ||
                  //                           value == items[1] ||
                  //                           value == items[2]) {
                  //                         context.read<OrderDetailBloc>().add(
                  //                               EventStopOrder(
                  //                                 cause: value == items[0]
                  //                                     ? "snack"
                  //                                     : value == items[1]
                  //                                         ? "sleep"
                  //                                         : "relax",
                  //                               ),
                  //                             );
                  //                       }
                  //                       if (value == items[4]) {
                  //                         /// FIXME
                  //                         // context.read<BlocOrderCard>().add(
                  //                         //       EventStopOrder(
                  //                         //         cause: "change_driver",
                  //                         //       ),
                  //                         //     );
                  //                         await showModalBottomSheet(
                  //                           useRootNavigator: true,
                  //                           context: context,
                  //                           isScrollControlled: true,
                  //                           isDismissible: true,
                  //                           backgroundColor:
                  //                               const Color(0xFFFFFFFF),
                  //                           shape: const RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.vertical(
                  //                               top: Radius.circular(16),
                  //                             ),
                  //                           ),
                  //                           builder: (context) {
                  //                             return const TransferOrderBottomSheet();
                  //                           },
                  //                         ).then(
                  //                           (value) => context
                  //                               .read<OrderDetailBloc>()
                  //                               .add(
                  //                                 EventStopOrder(
                  //                                   cause: "change_driver",
                  //                                   emptyDriver: value,
                  //                                 ),
                  //                               ),
                  //                         );
                  //                         // showAppBottomSheet(
                  //                         //   context,
                  //                         //   // initialChildSize: 0.5,
                  //                         //   useRootNavigator: true,
                  //                         //   child:
                  //                         //       const TransferOrderBottomSheet(),
                  //                         // );
                  //                       }
                  //                     }
                  //                   },
                  //                 );
                  //               },
                  //               child: Container(
                  //                 padding: const EdgeInsets.symmetric(
                  //                   vertical: 16,
                  //                 ),
                  //                 decoration: BoxDecoration(
                  //                   color: ColorPalette.white,
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   border: Border.all(
                  //                     color: ColorPalette.main,
                  //                   ),
                  //                 ),
                  //                 child: Stack(
                  //                   children: [
                  //                     Center(
                  //                       child: Text(
                  //                         "Стоп",
                  //                         style: ProjectTextStyles.ui_16Medium
                  //                             .copyWith(
                  //                           color: ColorPalette.main,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Positioned(
                  //                       top: 3,
                  //                       right: 15,
                  //                       child: SvgPicture.asset(
                  //                         "assets/images/svg/chevrone_down.svg",
                  //                         width: 24,
                  //                         height: 24,
                  //                         color: ColorPalette.main,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             )
                  //           : state.order.status == "stopped"
                  //               ? GestureDetector(
                  //                   onTap: () {
                  //                     context
                  //                         .read<OrderDetailBloc>()
                  //                         .add(EventResumeOrder());
                  //                   },
                  //                   child: Container(
                  //                     padding: const EdgeInsets.symmetric(
                  //                       vertical: 16,
                  //                     ),
                  //                     decoration: BoxDecoration(
                  //                       color: ColorPalette.main,
                  //                       borderRadius: BorderRadius.circular(10),
                  //                     ),
                  //                     child: Stack(
                  //                       children: [
                  //                         Center(
                  //                           child: Text(
                  //                             "Выйти на линию",
                  //                             style: ProjectTextStyles
                  //                                 .ui_16Medium
                  //                                 .copyWith(
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Positioned(
                  //                           top: 3,
                  //                           right: 15,
                  //                           child: SvgPicture.asset(
                  //                             "assets/images/svg/arrow_right.svg",
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : GestureDetector(
                  //                   onTap: () {
                  //                     context
                  //                         .read<OrderDetailBloc>()
                  //                         .add(EventStartOrder());
                  //                   },
                  //                   child: Container(
                  //                     padding: const EdgeInsets.symmetric(
                  //                       vertical: 16,
                  //                     ),
                  //                     decoration: BoxDecoration(
                  //                       color: ColorPalette.main,
                  //                       borderRadius: BorderRadius.circular(10),
                  //                     ),
                  //                     child: Stack(
                  //                       children: [
                  //                         Center(
                  //                           child: Text(
                  //                             "Поехали",
                  //                             style: ProjectTextStyles
                  //                                 .ui_16Medium
                  //                                 .copyWith(
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Positioned(
                  //                           top: 3,
                  //                           right: 15,
                  //                           child: SvgPicture.asset(
                  //                             "assets/images/svg/arrow_right.svg",
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),

                  // //
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
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

class _FABWidget extends StatelessWidget {
  final OrderDTO order;
  final bool isScan;
  final PointDTO? point;
  const _FABWidget({
    required this.order,
    required this.isScan,
    required this.point,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///
    ///
    /// Приехал
    ///
    ///
    if (isScan &&
        (order.status == "accepted" || order.status == "in_process")) {
      return GestureDetector(
        onTap: () {
          AppRouter.push(
            context,
            BlocProvider<PointPageBloc>(
              create: (context) => PointPageBloc(
                repository: context.read<GlobalRepository>(),
              )..add(
                  PointPageEventLoadProducts(
                    pointId: point!.id,
                  ),
                ),
              child: PointPage(
                order: order,
                point: point!,
                isScan: order.points!.first.id == point!.id,
                // isScan: ,
              ),
            ),
          );
          // .then(
          //   (value) {
          //     context.read<OrderDetailBloc>().add(
          //           EventInitialOrderCard(
          //             order.id,
          //           ),
          //         );
          //   },
          // );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: ColorPalette.main,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Приехал",
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 15,
                child: SvgPicture.asset(
                  "assets/images/svg/arrow_right.svg",
                ),
              )
            ],
          ),
        ),
      );
    }

    ///
    ///
    /// Стоп
    ///
    ///
    else if (order.status == "accepted" || order.status == "in_process") {
      return Row(
        children: [
          Expanded(
            child: Material(
              color: ColorPalette.main,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  BlocProvider.of<OrderDetailBloc>(context)
                      .add(OrderDetailEventFinishOrder(orderId: order.id));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // color: ColorPalette.main,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color: ColorPalette.main,
                    // ),
                  ),
                  child: Center(
                    child: Text(
                      'Завершить маршрут',
                      style: ProjectTextStyles.ui_16Medium.copyWith(
                        color: ColorPalette.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await showAppBottomSheet(
                  context,
                  initialChildSize: 0.45,
                  useRootNavigator: true,
                  child: const BuildCauses(),
                ).then(
                  (value) async {
                    if (value != null) {
                      if (value == items[0] ||
                          value == items[1] ||
                          value == items[2]) {
                        context.read<OrderDetailBloc>().add(
                              OrderDetailEventStop(
                                cause: value == items[0]
                                    ? "snack"
                                    : value == items[1]
                                        ? "sleep"
                                        : "relax",
                              ),
                            );
                      }
                      if (value == items[4]) {
                        /// FIXME
                        // context.read<BlocOrderCard>().add(
                        //       EventStopOrder(
                        //         cause: "change_driver",
                        //       ),
                        //     );
                        await showModalBottomSheet(
                          useRootNavigator: true,
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          backgroundColor: const Color(0xFFFFFFFF),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (context) {
                            return const TransferOrderBottomSheet();
                          },
                        ).then(
                          (value) => context.read<OrderDetailBloc>().add(
                                OrderDetailEventStop(
                                  cause: "change_driver",
                                  emptyDriver: value,
                                ),
                              ),
                        );
                      }
                    }
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorPalette.main,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "Стоп",
                        style: ProjectTextStyles.ui_16Medium.copyWith(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    ///
    ///
    /// Выйти на линию
    ///
    ///
    else if (order.status == "stopped") {
      return GestureDetector(
        onTap: () {
          context.read<OrderDetailBloc>().add(OrderDetailEventResume());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: ColorPalette.main,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Выйти на линию",
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 15,
                child: SvgPicture.asset(
                  "assets/images/svg/arrow_right.svg",
                ),
              )
            ],
          ),
        ),
      );
    }

    ///
    ///
    /// Поехали
    ///
    ///
    else {
      return GestureDetector(
        onTap: () {
          context.read<OrderDetailBloc>().add(OrderDetailEventStart());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: ColorPalette.main,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Поехали",
                  style: ProjectTextStyles.ui_16Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 15,
                child: SvgPicture.asset(
                  "assets/images/svg/arrow_right.svg",
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class _BuildOrderItem extends StatefulWidget {
  final OrderDTO order;
  final Function({
    required bool isOpened,
    required PointDTO orderPoint,
  }) callback;

  const _BuildOrderItem({
    Key? key,
    required this.order,
    required this.callback,
  }) : super(key: key);

  @override
  State<_BuildOrderItem> createState() => _BuildOrderItemState();
}

class _BuildOrderItemState extends State<_BuildOrderItem> {
  // int selected = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      padding: const EdgeInsets.all(15),
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _BuildPointItem(
            icon: "orders_geo",
            city: widget.order.crossdockName ?? widget.order.from,
            date: widget.order.startDate,
          ),
          const SizedBox(height: 10),
          if (widget.order.points != null && widget.order.points!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.order.points!.length,
              itemBuilder: (context, index) {
                return _BuildExpandablePointItem(
                  point: widget.order.points![index],
                  isExpanded: index ==
                      Provider.of<OrderDetailProvider>(context).selected,
                  onExpansionChanged: (bool isOpened) {
                    if (isOpened) {
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .selected = index;
                    } else {
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .selected = -1;
                    }
                    // if (widget.order.points![i].status == "finished") {
                    widget.callback.call(
                      isOpened: widget.order.points![index].status ==
                                  "finished" ||
                              (index != 0 &&
                                  widget.order.points![0].status != "finished")
                          ? false
                          : isOpened,
                      orderPoint: widget.order.points![index],
                    );
                    // }
                    // setState(() {});
                  },
                );
              },
            ),
          const SizedBox(height: 10),
          _BuildPointItem(
            icon: "orders_geo_done",
            city: widget.order.to,
            date: widget.order.endDate,
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}

class _BuildPointItem extends StatelessWidget {
  final String icon;
  final String? city;
  final DateTime? date;

  const _BuildPointItem({
    Key? key,
    required this.icon,
    required this.city,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 33,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorPalette.main,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            "assets/images/svg/$icon.svg",
            color: ColorPalette.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("dd MMMM yyyy, в hh:mm")
                    .format(date ?? DateTime.now()),
                style: ProjectTextStyles.ui_12Medium
                    .copyWith(color: ColorPalette.commonGrey),
              ),
              Text(
                city ?? S.of(context).no_data,
                style: ProjectTextStyles.ui_16Medium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildExpandablePointItem extends StatelessWidget {
  final PointDTO point;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;

  const _BuildExpandablePointItem({
    Key? key,
    required this.point,
    required this.isExpanded,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ExpansionTile(
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: isExpanded,
        tilePadding: EdgeInsets.zero,
        expandedAlignment: Alignment.topLeft,
        childrenPadding: const EdgeInsets.only(left: 40),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: point.status == "finished"
                    ? ColorPalette.main
                    : ColorPalette.lightGrey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                "assets/images/svg/order_item.svg",
                color: point.status == "finished" ? ColorPalette.white : null,
                width: 12,
                height: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: ColorPalette.lightGrey,
                  ),
                  Text(
                    DateFormat("dd MMMM yyyy, в hh:mm")
                        .format(point.date ?? DateTime.now()),
                    style: ProjectTextStyles.ui_12Medium
                        .copyWith(color: ColorPalette.commonGrey),
                  ),
                  Text(
                    point.crossdockName != null
                        ? '${point.crossdockName} (Кроссдок)'
                        : (point.name ?? S.of(context).no_data),
                    style: ProjectTextStyles.ui_16Medium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isExpanded)
                        SvgPicture.asset(
                          "assets/images/svg/pin-location.svg",
                          color: point.status == "finished"
                              ? ColorPalette.main
                              : null,
                        ),
                      if (!isExpanded)
                        const SizedBox(
                          width: 4,
                        ),
                      if (!isExpanded)
                        Text(
                          point.address == null
                              ? S.of(context).no_data
                              : MediaQuery.of(context).size.width < 400
                                  ? point.address!.length > 20
                                      ? '${point.address!.substring(0, 20)}...'
                                      : point.address!
                                  : point.address!.length > 40
                                      ? '${point.address!.substring(0, 37)}...'
                                      : point.address!,
                          style: ProjectTextStyles.ui_12Medium.copyWith(
                            color: ColorPalette.commonGrey,
                          ),
                        ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: ColorPalette.lightGrey,
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
                point.address == null ? S.of(context).no_data : point.address!,
                style: ProjectTextStyles.ui_12Medium.copyWith(
                  color: ColorPalette.commonGrey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Количество контейнеров - ${point.countProducts.toString()} ",
                textAlign: TextAlign.left,
                style: ProjectTextStyles.ui_12Medium
                    .copyWith(color: ColorPalette.black),
              ),
              if (point.products != null)
                for (int k = 0; k < point.products!.length; k++)
                  Text(
                    point.products?[k].name ?? S.of(context).no_data,
                    style: ProjectTextStyles.ui_12Medium
                        .copyWith(color: ColorPalette.commonGrey),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
