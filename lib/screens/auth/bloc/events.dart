part of 'bloc_auth.dart';

abstract class EventBlocAuth {}

class EventAuthInit extends EventBlocAuth {}

class EventAuthLogout extends EventBlocAuth {}

class EventAuthPhone extends EventBlocAuth {
  final String phoneNumber;
  final String password;

  EventAuthPhone({
    required this.phoneNumber,
    required this.password,
  });
}


