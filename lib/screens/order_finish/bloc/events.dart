part of 'bloc_order_finish.dart';

@immutable
abstract class EventBlocOrderFinish {}

class EventOrderFinishInitial extends EventBlocOrderFinish {
  final int pointId;

  EventOrderFinishInitial({
    required this.pointId,
  });
}

class EventOrderProductFinish extends EventBlocOrderFinish {
  final int productId;
  final String code;

  EventOrderProductFinish({
    required this.productId,
    required this.code,
  });
}
