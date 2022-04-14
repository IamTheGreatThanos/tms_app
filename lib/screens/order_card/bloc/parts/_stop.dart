part of '../bloc_order_card.dart';

extension Stop on BlocOrderCard {
  Future<void> _stop(EventStopOrder event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.stopOrder(orderId!, event.cause);
      result.isCurrent = true;
      orderDetails = result;
      if(orderDetails.status == "stopped"){
        emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      }
      emit(StateStopSuccess());
      // add(EventInitialOrderCard(orderId!));
    } catch (e) {
      emit(StateOrderCardError(
          error: AppError(
              message: "Что то пошло не так"
          )
      ));
    }
  }
}
