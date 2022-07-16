import 'dart:async';

import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
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
    on<PointPageEventScanBarcode>(_scanBarcode);
  }

  final GlobalRepository repository;
  int? pointId;
  PointDTO? currentPoint;

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
      currentPoint = result;
      for (var element in currentPoint!.containers!) {
        if (!element.isScanned!) {
          areAllFinished = false;
        }
      }
      emit(
        PointPageStateLoaded(
          orderPoint: currentPoint!,
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

  void _scanBarcode(
    PointPageEventScanBarcode event,
    Emitter<PointPageState> emit,
  ) {
    emit(PointPageStateLoading());

    bool areAllFinished = true;
    bool flag = false;
    for (ContainerDTO e in currentPoint?.containers ?? []) {
      if (e.code == event.code) {
        flag = true;
        e.copyWith(isScanned: true);
        break;
      }
    }
    for (var element in currentPoint!.containers!) {
      if (!element.isScanned!) {
        areAllFinished = false;
      }
    }

    if (flag) {
      emit(PointPageStateLoaded(
          orderPoint: currentPoint!, areAllFinished: areAllFinished));
    } else {
      emit(PointPageStateError(
          error: const AppError(
              message: 'В списке нет товар с таким штрихкодом!')));
    }
  }
}
