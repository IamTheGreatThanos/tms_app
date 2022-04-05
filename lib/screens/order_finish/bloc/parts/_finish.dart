part of "../bloc_order_finish.dart";

extension Finish on BlocOrderFinish {
  Future<void> _finish(EventOrderProductFinish event,
      Emitter<StateBlocOrderFinish> emit) async {
    try {
      final result = await repository.orderProductFinish(event.productId, event.code);
      add(EventOrderFinishInitial(pointId: pointId!));
    } catch (e) {
      emit(StateOrderFinishError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          )));
    }
  }
}
