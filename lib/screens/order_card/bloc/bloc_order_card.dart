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

class BlocOrderCard extends Bloc<EventBlocOrderCard, StateBlocOrderCard> {
  BlocOrderCard({
    required this.repository,
    required this.orderDetails,
  }) : super(StateLoadingOrderCard()) {
    on<EventInitialOrderCard>(_read);
    on<EventStopOrder>(_stop);
    on<EventStartOrder>(_start);
    on<EventResumeOrder>(_resume);
  }

  final GlobalRepository repository;
  OrderData orderDetails;
  int? orderId;

  ///
  ///
  /// METHODS
  ///
  ///
  Future<void> _read(
      EventInitialOrderCard event, Emitter<StateBlocOrderCard> emit) async {
    try {
      emit(StateLoadingOrderCard());
      bool isFinished = true;
      final response = await repository.orderPoints(event.orderId);
      orderId = event.orderId;
      if (orderDetails.status == "stopped") {
        emit(StateShowTimerInitial(
            startTimer: orderDetails.orderStatus!.stopTimer!));
      }
      for (int i = 0; i < orderDetails.points!.length; i++) {
        isFinished = true;
        for (var product in orderDetails.points![i].products!) {
          if (product.status != "finished") {
            isFinished = false;
          }
        }
        if (isFinished) {
          orderDetails.points![i].status = "finished";
        }
      }
      emit(StateLoadDataOrderCard(orderPoints: response, order: orderDetails));
    } catch (e) {
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так 1"),
        ),
      );
    }
  }

  Future<void> _resume(
      EventResumeOrder event, Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.resumeOrder(orderId!);
      result.isCurrent = true;
      orderDetails = result;
      // if(orderDetails.status == "stopped"){
      //   emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      // }
      emit(StateResumeSuccess());
      add(EventInitialOrderCard(orderId!));
    } catch (e) {
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так 2"),
        ),
      );
    }
  }

  Future<void> _start(
      EventStartOrder event, Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.acceptOrder(orderId!);
      orderDetails = result;
      orderDetails.isCurrent = true;
      emit(StateStartSuccess());
      add(EventInitialOrderCard(orderId!));
    } catch (e) {
      if (e is DioError && e.response!.statusCode == 500) {
        emit(StateStartSuccess());
        add(EventInitialOrderCard(orderId!));
      } else {
        emit(
          StateOrderCardError(
            error: const AppError(message: "Что то пошло не так 3"),
          ),
        );
      }
    }
  }

  Future<void> _stop(
      EventStopOrder event, Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.stopOrder(orderId!, event.cause);
      result.isCurrent = true;
      orderDetails = result;
      // if(orderDetails.status == "stopped"){
      //   emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      // }
      emit(StateStopSuccess());
      add(EventInitialOrderCard(orderId!));
    } catch (e) {
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так 4"),
        ),
      );
    }
  }
}
