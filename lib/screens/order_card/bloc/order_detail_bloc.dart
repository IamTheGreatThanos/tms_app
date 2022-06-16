import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/models/user_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'order_detail_event.dart';

part 'order_detail_state.dart';

const _tag = 'bloc_order_card.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({
    required this.repository,
    required this.currentOrder,
  }) : super(StateLoadingOrderCard()) {
    on<EventInitialOrderCard>(_read);
    on<EventStopOrder>(_stop);
    on<EventStartOrder>(_start);
    on<EventResumeOrder>(_resume);
    on<OrderDetailRefreshEvent>(_refresh);
  }

  final GlobalRepository repository;
  OrderDTO currentOrder;
  int? orderId;

  ///
  ///
  /// METHODS
  ///
  ///
  Future<void> _read(
    EventInitialOrderCard event,
    Emitter<OrderDetailState> emit,
  ) async {
    try {
      emit(StateLoadingOrderCard());
      //bool isFinished = true;
      final List<PointDTO> response =
          await repository.orderPoints(event.orderId);
      orderId = event.orderId;

      if (currentOrder.status == "stopped") {
        if (currentOrder.orderStatus == null ||
            currentOrder.orderStatus!.stopTimer == null) {
          emit(
            StateOrderCardError(
              error: AppError(
                message:
                    "orderDetails.orderStatus - ${currentOrder.orderStatus}",
              ),
            ),
          );
        } else {
          emit(StateShowTimerInitial(
              startTimer: currentOrder.orderStatus!.stopTimer!));
        }
      }

      // TODO этот фор пока бесполезный
      // for (int i = 0; i < currentOrder.points!.length; i++) {
      //   isFinished = true;
      //   for (var product in currentOrder.points![i].products!) {
      //     if (product.status != "finished") {
      //       isFinished = false;
      //     }
      //   }
      //   if (isFinished) {
      //     // orderDetails.points![i].status = "finished";
      //   }
      // }
      emit(StateLoadDataOrderCard(orderPoints: response, order: currentOrder));
    } catch (e) {
      log('$e', name: _tag);
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так 1"),
        ),
      );
    }
  }

  Future<void> _resume(
    EventResumeOrder event,
    Emitter<OrderDetailState> emit,
  ) async {
    emit(StateLoadingOrderCard());

    try {
      final OrderDTO result = await repository.resumeOrder(orderId!);
      currentOrder = result.copyWith(isCurrent: true);
      // if(orderDetails.status == "stopped"){
      //   emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      // }
      emit(StateResumeSuccess());
      // add(EventInitialOrderCard(orderId!));
    } catch (e) {
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так 2"),
        ),
      );
    }
  }

  Future<void> _start(
    EventStartOrder event,
    Emitter<OrderDetailState> emit,
  ) async {
    emit(StateLoadingOrderCard());

    try {
      emit(StateLoadingOrderCard());
      final result = await repository.acceptOrder(orderId!);
      currentOrder = result.copyWith(isCurrent: true);
      // currentOrder.isCurrent = true;
      emit(StateStartSuccess());
      // add(EventInitialOrderCard(orderId!));
    } catch (e) {
      if (e is DioError && e.response!.statusCode == 500) {
        emit(StateStartSuccess());
        // add(EventInitialOrderCard(orderId!));
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
    EventStopOrder event,
    Emitter<OrderDetailState> emit,
  ) async {
    emit(StateLoadingOrderCard());

    try {
      if (event.cause == 'change_driver') {
        final OrderDTO result = await repository.stopOrderAndChangeDriver(
          orderId!,
          event.cause,
          emptyDriver: event.emptyDriver,
        );
        // result.isCurrent = true;
        currentOrder = result.copyWith(isCurrent: true);
      } else {
        final result = await repository.stopOrder(
          orderId!,
          event.cause,
          emptyDriver: event.emptyDriver,
        );
        // result.isCurrent = true;
        currentOrder = result.copyWith(isCurrent: true);
      }

      // if(orderDetails.status == "stopped"){
      //   emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      // }
      if (event.cause == 'change_driver') {
        emit(StateChangedDriverOrderCard());
      } else {
        emit(StateStopSuccess());
        // add(EventInitialOrderCard(orderId!));
      }
    } catch (e) {
      emit(
        StateOrderCardError(
          error: const AppError(message: "Что то пошло не так (_stop method)"),
        ),
      );
    }
  }

  Future<void> _refresh(
    OrderDetailRefreshEvent event,
    Emitter<OrderDetailState> emit,
  ) async {
    try {
      emit(StateLoadingOrderCard());
      //bool isFinished = true;
      final OrderDTO refreshedOrder = await repository.getOrderByOrderId(
        orderId: event.orderId,
      );
      currentOrder = refreshedOrder;
      orderId = event.orderId;

      if (currentOrder.status == "stopped") {
        if (currentOrder.orderStatus == null ||
            currentOrder.orderStatus!.stopTimer == null) {
          emit(
            StateOrderCardError(
              error: AppError(
                message:
                    "orderDetails.orderStatus - ${currentOrder.orderStatus}",
              ),
            ),
          );
        } else {
          emit(StateShowTimerInitial(
              startTimer: currentOrder.orderStatus!.stopTimer!));
        }
      }

      final List<PointDTO> points = await repository.orderPoints(event.orderId);
      emit(
        StateLoadDataOrderCard(
          orderPoints: points,
          order: currentOrder.copyWith(
            isCurrent: currentOrder.status == 'accepted' ||
                currentOrder.status == 'in_process' ||
                currentOrder.status == 'stopped',
          ),
        ),
      );
    } catch (e) {
      log('$e', name: _tag);
      emit(
        StateOrderCardError(
          error:
              const AppError(message: "Что то пошло не так (_refresh method)"),
        ),
      );
    }
  }
}
