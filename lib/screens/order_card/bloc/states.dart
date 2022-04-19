part of 'bloc_order_card.dart';

@immutable
abstract class StateBlocOrderCard {}

class StateLoadingOrderCard extends StateBlocOrderCard {}

class StateStopSuccess extends StateBlocOrderCard {}

class StateStartSuccess extends StateBlocOrderCard {}

class StateResumeSuccess extends StateBlocOrderCard {}

class StateLoadOrderDetails extends StateBlocOrderCard {
  final OrderData order;

  StateLoadOrderDetails({
    required this.order,
  });
}

class StateLoadDataOrderCard extends StateBlocOrderCard {
  final OrderPointsResponse orderPoints;
  final OrderData order;

  StateLoadDataOrderCard({
    required this.orderPoints,
    required this.order,
  });
}

class StateShowTimerInitial extends StateBlocOrderCard {
  final DateTime startTimer;

  StateShowTimerInitial({
    required this.startTimer,
  });
}

class StateOrderCardError extends StateBlocOrderCard {
  final AppError error;

  StateOrderCardError({
    required this.error,
  });
}
