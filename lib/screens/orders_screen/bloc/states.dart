part of 'bloc_orders_screen.dart';

@immutable
abstract class StateBlocOrdersScreen {}

class StateLoadingOrdersScreen extends StateBlocOrdersScreen {}

class StateLoadDataOrdersScreen extends StateBlocOrdersScreen {
  final List<OrdersData> orders;
  final List<CityData> cities;

  StateLoadDataOrdersScreen({
    required this.orders,
    required this.cities,
  });
}

class StateOrdersScreenError extends StateBlocOrdersScreen {
  final AppError error;

  StateOrdersScreenError({
    required this.error,
  });
}
