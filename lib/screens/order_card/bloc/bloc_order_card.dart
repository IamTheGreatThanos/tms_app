import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_points_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';

part 'parts/_stop.dart';

part 'parts/_start.dart';
part 'parts/_resume.dart';

class BlocOrderCard extends Bloc<EventBlocOrderCard, StateBlocOrderCard> {
  BlocOrderCard({
    required this.repository,
    required this.orderDetails,
  }) : super(StateLoadingOrderCard()) {
    on<EventInitialOrderCard>(_read);
    on<EventStopOrder>(_stop);
    on<EventStartOrder>(_start);
    on<EventResumeOrder>(_resume);
    on<EventScanBarcode>((event, emit)async{
      print(event.barcode);
      emit(StateSuccessfullyScanned(barcode: event.barcode));
    });
  }

  final GlobalRepository repository;
  OrderData orderDetails;
  int? orderId;
}
