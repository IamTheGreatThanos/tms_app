part of '../bloc_order_card.dart';

extension Start on BlocOrderCard {
  Future<void> _start(
      EventStartOrder event, Emitter<StateBlocOrderCard> emit) async {
    try {
      final result = await repository.acceptOrder(orderId!);
      orderDetails = result;
      orderDetails.isCurrent = true;
      emit(StateStartSuccess());
      add(EventInitialOrderCard(orderId!));
    } catch (e) {
      if (e is DioError && e.response!.statusCode == 500) {
        emit(StateStartSuccess());
        add(EventInitialOrderCard(orderId!));
      } else {
        emit(StateOrderCardError(
            error: AppError(message: "Что то пошло не так")));
      }
    }
  }
}
