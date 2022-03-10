import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../network/models/dto_models/response/error.dart';
import '../../../network/models/dto_models/response/marks_response.dart';
import '../../../network/repository/global_repository.dart';
import '../ui/_vmodel.dart';

part 'events.dart';

part 'states.dart';

class BlocVerification
    extends Bloc<EventBlocVerification, StateBlocVerification> {
  BlocVerification({
    required this.repository,
  }) : super(StateVerificationInitial()) {
    on<EventInitialVerification>((event, emit) {
      emit(StateVerificationFirstStep());
    });
    on<EventVerificationFirstStep>((event, emit) {
      emit(StateVerificationFirstStep());
    });
    on<EventVerificationSecondStep>((event, emit) {
      emit(StateVerificationSecondStep(
        idImages: event.idImages,
      ));
    });
    on<EventVerificationThirdStep>((event, emit) {
      emit(StateVerificationThirdStep());
    });
    on<EventVerificationFourthStep>((event, emit) async {
      try {
        emit(StateVerificationLoading());
        var response = await repository.getMarks();
        for (int i = 0; i < response.data!.length; i++) {
          for (int k = i + 1; k < response.data!.length; k++) {
            if (response.data![i].name == response.data![k].name) {
              response.data!.removeAt(k);
            }
          }
        }
        marks = response.data!;
        emit(StateVerificationFourthStep(marks));
      } catch (e) {
        emit(StateVerificationError(
            error: AppError(
              message: e.dioErrorMessage,
              code: e.dioErrorStatusCode,
            )));
      }
    });
    on<EventVerificationVerify>((event, emit) async {
      try {
        emit(StateVerificationLoading());
        if (!event.vmodel.isFilled()) {
          await repository.verify(event.vmodel);
          emit(StateSuccessfulVerification());
        } else {
          throw "Заполните все поля";
        }
      } catch (e) {
        if (e is DioError) {
          emit(StateVerificationError(
              error: AppError(
                message: e.dioErrorMessage,
                code: e.dioErrorStatusCode,
              )));
        } else {
          emit(StateVerificationError(
              error: AppError(
                message: e.toString(),
                code: 0,
              )));
        }
        emit(StateVerificationFourthStep(marks));
      }
    });
  }

  final GlobalRepository repository;
  List<Marks> marks = [];
}
