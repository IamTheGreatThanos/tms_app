part of '../bloc_order_card.dart';

extension Read on BlocOrderCard {
  Future<void> _read(EventInitialOrderCard event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      emit(StateLoadingOrderCard());
      bool isFinished = true;
      final response = await repository.orderPoints(event.orderId);
      orderId = event.orderId;
      if(orderDetails.status == "stopped"){
        emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      }
      for (int i = 0; i < orderDetails.points!.length; i++) {
        isFinished = true;
        for (var product in orderDetails.points![i].products!) {
          if(product.status != "finished"){
            isFinished = false;
          }
        }
        if(isFinished){
          orderDetails.points![i].status = "finished";
        }
      }
      emit(StateLoadDataOrderCard(orderPoints: response, order: orderDetails));
    } catch (e) {
      emit(StateOrderCardError(
         error: AppError(
           message: "Что то пошло не так"
         )
      ));
    }
  }
}
