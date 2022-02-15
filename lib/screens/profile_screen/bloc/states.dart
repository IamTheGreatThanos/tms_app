part of 'bloc_profile_screen.dart';

@immutable
abstract class StateBlocProfile {}

class StateProfileLoading extends StateBlocProfile {}

class StateProfileError extends StateBlocProfile {
  final AppError error;

  StateProfileError({
    required this.error,
  });
}

class StateProfileLoadData extends StateBlocProfile {
  final ProfileResponse profile;

  StateProfileLoadData({
    required this.profile,
  });
}
