part of "../bloc_order_finish.dart";

extension Read on BlocOrderFinish {
  Future<void> _read(
      EventOrderFinishInitial event, Emitter<StateBlocOrderFinish> emit) async {
    try {
      bool areAllFinished = true;
      final result = await repository.orderPointProducts(event.pointId);
      pointId = event.pointId;
      for (var element in result.products!) {
        if (element.status != "finished") {
          areAllFinished = false;
        }
      }
      emit(StateLoadOrderPoint(
          orderPoint: result, areAllFinished: areAllFinished));
    } catch (e) {
      emit(StateOrderFinishError(
          error: AppError(
        message: e.dioErrorMessage,
        code: e.dioErrorStatusCode,
      )));
    }
  }
}
