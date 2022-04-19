part of 'bloc_order_finish.dart';

@immutable
abstract class StateBlocOrderFinish {}

class StateLoadingOrderFinish extends StateBlocOrderFinish {}

class StateLoadOrderPoint extends StateBlocOrderFinish {
  final OrderPoint orderPoint;
  final bool areAllFinished;

  StateLoadOrderPoint({
    required this.orderPoint,
    this.areAllFinished = false,
  });
}

class StateLoadPointWithoutScan extends StateBlocOrderFinish {
  final OrderPoint orderPoint;
  final bool areAllFinished;

  StateLoadPointWithoutScan({
    required this.orderPoint,
    this.areAllFinished = false,
  });
}

class StateOrderFinishError extends StateBlocOrderFinish {
  final AppError error;

  StateOrderFinishError({
    required this.error,
  });
}
