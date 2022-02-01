part of '../bloc_orders_screen.dart';

extension Read on BlocOrdersScreen {
  Future<void> _read(EventInitialOrdersScreen event,
      Emitter<StateBlocOrdersScreen> emit) async {
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
      emit(StateLoadDataOrdersScreen(orders: orders));
    } catch (e) {}
  }
}
