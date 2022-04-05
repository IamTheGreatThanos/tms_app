part of 'bloc_order_card.dart';

@immutable
abstract class StateBlocOrderCard {}

class StateLoadingOrderCard extends StateBlocOrderCard {}

class StateStopSuccess extends StateBlocOrderCard {}

class StateStartSuccess extends StateBlocOrderCard {}

class StateResumeSuccess extends StateBlocOrderCard {}

class StateLoadDataOrderCard extends StateBlocOrderCard {
  final OrderPointsResponse orders;

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
