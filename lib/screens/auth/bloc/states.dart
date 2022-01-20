part of 'bloc_auth.dart';

abstract class StateBlocAuth {}

class SignInInitial extends StateBlocAuth {}

class StateAuthLoading extends StateBlocAuth {}

class StateAuthError extends StateBlocAuth {
  StateAuthError(this.error);

  final AppError error;

  @override
  String toString() => 'StateAuthError(error: $error)';
}
