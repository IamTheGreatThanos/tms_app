import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/screens/order_card/bloc/bloc_order_card.dart';
import 'package:europharm_flutter/screens/order_card/ui/order_detail_screen.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderData order;
  const OrderDetailPage({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocOrderCard>(
      create: (context) => BlocOrderCard(
        repository: context.read<GlobalRepository>(),
        orderDetails: widget.order,
      )..add(
          EventInitialOrderCard(widget.order.id!),
        ),
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
        body: OrderDetailScreen(
          order: widget.order,
        ),
      ),
    );
  }
}
