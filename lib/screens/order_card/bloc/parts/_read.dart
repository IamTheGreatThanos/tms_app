part of '../bloc_order_card.dart';

extension Read on BlocOrderCard {
  Future<void> _read(EventInitialOrderCard event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      final response = await repository.orderPoints(event.orderId);
      orderId = event.orderId;
      if(orderDetails.status == "stopped"){
        emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      }
      emit(StateLoadDataOrderCard(orders: response));
    } catch (e) {
      emit(StateOrderCardError(
         error: AppError(
           message: "Что то пошло не так"
         )
      ));
    }
  }
}
