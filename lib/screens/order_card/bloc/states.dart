part of 'bloc_order_card.dart';

@immutable
abstract class StateBlocOrderCard {}

class StateLoadingOrderCard extends StateBlocOrderCard {}

class StateLoadDataOrderCard extends StateBlocOrderCard {
  final List<OrdersResponse> orders;

  StateLoadDataOrderCard({
    required this.orders,
  });
}

class StateOrderCardError extends StateBlocOrderCard {
  final AppError error;

  StateOrderCardError({
    required this.error,
  });
}
