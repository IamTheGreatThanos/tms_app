part of 'bloc_orders_screen.dart';

@immutable
abstract class StateBlocOrdersScreen {}

class StateLoadingOrdersScreen extends StateBlocOrdersScreen {}

class StateLoadDataOrdersScreen extends StateBlocOrdersScreen {
  final List<OrdersResponse> orders;

  StateLoadDataOrdersScreen({
    required this.orders,
  });
}

class StateOrdersScreenError extends StateBlocOrdersScreen {
  final AppError error;

  StateOrdersScreenError({
    required this.error,
  });
}
