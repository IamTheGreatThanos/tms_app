part of '../bloc_order_card.dart';

extension Resume on BlocOrderCard {
  Future<void> _resume(EventResumeOrder event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      await repository.resumeOrder(orderId!);
      emit(StateResumeSuccess());
    } catch (e) {
      emit(StateOrderCardError(
          error: AppError(
              message: "Что то пошло не так"
          )
      ));
    }
  }
}
