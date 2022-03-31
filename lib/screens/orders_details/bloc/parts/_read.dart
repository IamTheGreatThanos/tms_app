part of '../bloc_order_details.dart';

extension Read on BlocOrderDetails {
  Future<void> _read(EventInitialOrderDetails event,
      Emitter<StateBlocOrderDetails> emit) async {
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
      emit(StateLoadDataOrderDetails(orders: orders));
    } catch (e) {}
  }
}

class Address {
  final String title;
  final String streetName;
  final bool isFrom;

  Address({
    required this.title,
    required this.streetName,
    required this.isFrom,
  });
}

class OrdersResponse {
  final String customerName;
  final String date;
  final List<Address> addresses;
  final bool isCurrent;

  OrdersResponse({
    required this.customerName,
    required this.date,
    required this.addresses,
    this.isCurrent = false,
  });
}
