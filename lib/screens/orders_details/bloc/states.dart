part of 'bloc_order_details.dart';

@immutable
abstract class StateBlocOrderDetails {}

class StateLoadingOrderDetails extends StateBlocOrderDetails {}

class StateLoadDataOrderDetails extends StateBlocOrderDetails {
  final List<OrdersResponse> orders;

  StateLoadDataOrderDetails({
    required this.orders,
  });
}

class StateOrderDetailsError extends StateBlocOrderDetails {
  final AppError error;

  StateOrderDetailsError({
    required this.error,
  });
}
