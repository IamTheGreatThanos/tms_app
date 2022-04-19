part of '../bloc_order_card.dart';

extension Resume on BlocOrderCard {
  Future<void> _resume(EventResumeOrder event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.resumeOrder(orderId!);
      result.isCurrent = true;
      orderDetails = result;
      // if(orderDetails.status == "stopped"){
      //   emit(StateShowTimerInitial(startTimer: orderDetails.orderStatus!.stopTimer!));
      // }
      emit(StateResumeSuccess());
      add(EventInitialOrderCard(orderId!));
    } catch (e) {
      emit(StateOrderCardError(
          error: AppError(
              message: "Что то пошло не так"
          )
      ));
    }
  }
}
