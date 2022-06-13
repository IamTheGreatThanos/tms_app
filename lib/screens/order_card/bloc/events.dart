part of 'bloc_order_card.dart';

@immutable
abstract class EventBlocOrderCard {}

class EventInitialOrderCard extends EventBlocOrderCard {
  final int orderId;

  EventInitialOrderCard(this.orderId);
}

class EventStopOrder extends EventBlocOrderCard {
  final String cause;
  final UserDTO? emptyDriver;

  EventStopOrder({
    required this.cause,
    this.emptyDriver
  });
}

class EventStartOrder extends EventBlocOrderCard {}

class EventResumeOrder extends EventBlocOrderCard {}
