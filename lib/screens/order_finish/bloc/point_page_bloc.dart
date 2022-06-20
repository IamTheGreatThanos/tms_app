import 'dart:async';

import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
part 'point_page_event.dart';

part 'point_page_state.dart';

part 'parts/_finish.dart';

class PointPageBloc extends Bloc<PointPageEvent, PointPageState> {
  PointPageBloc({
    required this.repository,
  }) : super(PointPageStateLoading()) {
    on<PointPageEventLoadProducts>(_read);
    on<PointPageEventProductFinish>(_finish);
    on<PointPageEventFinishingPoint>(_finishingPoint);
  }

  final GlobalRepository repository;
  int? pointId;

  ///
  ///
  ///
  Future<void> _read(
    PointPageEventLoadProducts event,
    Emitter<PointPageState> emit,
  ) async {
    try {
      bool areAllFinished = true;
      final result = await repository.orderPointProducts(event.pointId);
      pointId = event.pointId;
      for (var element in result.products!) {
        if (element.status != "finished") {
          areAllFinished = false;
        }
      }
      emit(
        PointPageStateLoaded(
          orderPoint: result,
          areAllFinished: areAllFinished,
        ),
      );
    } catch (e) {
      emit(
        PointPageStateError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }

  Future<void> _finishingPoint(
    PointPageEventFinishingPoint event,
    Emitter<PointPageState> emit,
  ) async {
    emit(PointPageStateLoading());

    try {
      await repository.orderPointFinish(pointId: event.pointId);
      emit(PointPageStateFinished());
    } catch (e) {
      emit(
        PointPageStateError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }
}
