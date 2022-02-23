part of '../bloc_order_card.dart';

extension Read on BlocOrderCard {
  Future<void> _read(EventInitialOrderCard event,
      Emitter<StateBlocOrderCard> emit) async {
    try {
      final List<Address> addresses = [
        Address(
          title: "ЖК Жагалау, проспект Сарыарка",
          streetName: "Нур-Султан, KZ",
          isFrom: false,
        ),
        Address(
          title: "улица Розыбакиева 33/1",
          streetName: "Алматы, KZ",
          isFrom: true,
        ),
      ];
      final List<OrdersResponse> orders = [
        OrdersResponse(
          customerName: "Имя Заказчика",
          date: "34 минуты назад",
          addresses: addresses,
          isCurrent: true,
        ),
        OrdersResponse(
          customerName: "Имя Заказчика",
          date: "34 минуты назад",
          addresses: addresses,
        ),
        OrdersResponse(
          customerName: "Имя Заказчика",
          date: "34 минуты назад",
          addresses: addresses,
        ),
        OrdersResponse(
          customerName: "Имя Заказчика",
          date: "34 минуты назад",
          addresses: addresses,
        ),
      ];
      emit(StateLoadDataOrderCard(orders: orders));
    } catch (e) {}
  }
}
