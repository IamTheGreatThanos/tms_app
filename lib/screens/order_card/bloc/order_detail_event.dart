part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent {}

class EventInitialOrderCard extends OrderDetailEvent {
  final int orderId;

  EventInitialOrderCard(this.orderId);
}

class EventStopOrder extends OrderDetailEvent {
  final String cause;
  final UserDTO? emptyDriver;

  EventStopOrder({
    required this.cause,
    this.emptyDriver
  });
}

class EventStartOrder extends OrderDetailEvent {}

class EventResumeOrder extends OrderDetailEvent {}

class OrderDetailRefreshEvent extends OrderDetailEvent {
  final int orderId;

  OrderDetailRefreshEvent({
    required this.orderId,
  });
}
