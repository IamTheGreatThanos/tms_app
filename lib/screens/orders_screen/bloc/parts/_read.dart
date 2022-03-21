part of '../bloc_orders_screen.dart';

extension Read on BlocOrdersScreen {
  Future<void> _read(EventInitialOrdersScreen event,
      Emitter<StateBlocOrdersScreen> emit) async {
    CitiesResponse citiesResponse = CitiesResponse();
    OrdersResponse ordersResponse = OrdersResponse();
    AcceptedOrdersResponse currentOrders = AcceptedOrdersResponse();
    List<OrdersData> overallOrders = [];
    try {
      emit(StateLoadingOrdersScreen());
      citiesResponse = await repository.getCities();
      try {
        ordersResponse = await repository.getOrdersByCities(event.cityId);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      try {
        currentOrders = await repository.acceptedOrders();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if(currentOrders.data != null) {
        for (var element in currentOrders.data!) {
          if(element.order != null && element.order!.fromCityId!.id.toString() == event.cityId) {
            overallOrders.add(element.order!);
          }
        }
      }
      overallOrders.addAll(ordersResponse.data ?? []);
      emit(StateLoadDataOrdersScreen(
          orders: overallOrders, cities: citiesResponse.data ?? []));
    } catch (e) {
      emit(StateOrdersScreenError(
          error: AppError(
        message: e.dioErrorMessage,
        code: e.dioErrorStatusCode,
      )));
      // if (e.dioErrorStatusCode == 400) {
      //   emit(StateLoadDataOrdersScreen(
      //       orders: ordersResponse.data ?? [],
      //       cities: citiesResponse.data ?? []));
      // }
    }
  }
}
