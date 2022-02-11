part of '../bloc_auth.dart';

extension RegisterConfirm on BlocAuth {
  Future<void> _registerConfirm(EventRegisterConfirm event,
      Emitter<StateBlocAuth> emit) async {
    try {
      PhoneCodeRegisterResponse response =
      await repository.registerConfirm(event.password, registerToken);
      print(response);
      emit(StateRegisterConfirmSuccess());
    } catch(e) {
      print(e);
      emit(StateAuthError(AppError(
        message: e.dioErrorMessage,
        code: e.dioErrorStatusCode,
      )));
    }
  }
}
