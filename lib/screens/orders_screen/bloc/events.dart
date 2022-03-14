part of 'bloc_orders_screen.dart';

@immutable
abstract class EventBlocOrdersScreen {}

class EventInitialOrdersScreen extends EventBlocOrdersScreen{
  final String cityId;

  EventInitialOrdersScreen({required this.cityId});
}
