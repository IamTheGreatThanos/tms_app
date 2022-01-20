part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitialLoginEvent extends LoginEvent {}

class LogInEvent extends LoginEvent {
  final String accessToken;
  final String refreshToken;

  LogInEvent(this.accessToken, this.refreshToken);
}

class LogOutEvent extends LoginEvent {}

