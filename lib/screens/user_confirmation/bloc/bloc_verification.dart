import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

class BlocVerification
    extends Bloc<EventBlocVerification, StateBlocVerification> {
  BlocVerification() : super(StateVerificationInitial()) {
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
    on<EventVerificationFourthStep>((event, emit) {
      emit(StateVerificationFourthStep());
    });
  }
}
