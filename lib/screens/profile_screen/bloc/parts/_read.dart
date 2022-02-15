part of '../bloc_profile_screen.dart';

extension Read on BlocProfileScreen {
  Future<void> _read(
      EventProfileInitial event, Emitter<StateBlocProfile> emit) async {
    try {
      final profile = await repository.getProfile();
      emit(StateProfileLoadData(profile: profile));
    } catch (e) {
      emit(
        StateProfileError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }
}
