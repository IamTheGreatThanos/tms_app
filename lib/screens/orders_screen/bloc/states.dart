part of 'orders_bloc.dart';

@immutable
abstract class StateBlocOrdersScreen {}

class StateLoadingOrdersScreen extends StateBlocOrdersScreen {}

class StateLoadDataOrdersScreen extends StateBlocOrdersScreen {
  final List<OrderDTO> orders;
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
