part of 'bloc_order_card.dart';

@immutable
abstract class EventBlocOrderCard {}

class EventInitialOrderCard extends EventBlocOrderCard {
  final int orderId;

  EventInitialOrderCard(this.orderId);
}

class EventStopOrder extends EventBlocOrderCard {
  final String cause;

  EventStopOrder({required this.cause});
}

class EventStartOrder extends EventBlocOrderCard {}

class EventResumeOrder extends EventBlocOrderCard {}

class EventScanBarcode extends EventBlocOrderCard {
  final String barcode;

  EventScanBarcode({required this.barcode});
}
