part of '../bloc_order_card.dart';

extension Stop on BlocOrderCard {
  Future<void> _stop(EventStopOrder event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      await repository.stopOrder(orderId!, event.cause);
      emit(StateEditSuccess());
    } catch (e) {
      emit(StateOrderCardError(
          error: AppError(
              message: "Что то пошло не так"
          )
      ));
    }
  }
}
