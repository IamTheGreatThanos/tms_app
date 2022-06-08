part of 'orders_bloc.dart';

@immutable
abstract class EventBlocOrdersScreen {}

class EventInitialOrdersScreen extends EventBlocOrdersScreen {
  final String? cityId;

  EventInitialOrdersScreen({
     this.cityId,
  });
}
