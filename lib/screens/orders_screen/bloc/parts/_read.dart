part of '../bloc_orders_screen.dart';

extension Read on BlocOrdersScreen {
  Future<void> _read(EventInitialOrdersScreen event,
      Emitter<StateBlocOrdersScreen> emit) async {
    CitiesResponse citiesResponse = CitiesResponse();
    OrdersResponse ordersResponse = OrdersResponse();
    OrdersResponse currentOrders = OrdersResponse();
    List<OrderData> overallOrders = [];
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
        for(int i = 0; i < currentOrders.data!.length; i++){
          currentOrders.data![i].isCurrent = true;
            if(currentOrders.data![i].fromCityId!.id.toString() == event.cityId) {
              overallOrders.add(currentOrders.data![i]);
            }
        }
      }
      overallOrders.addAll(ordersResponse.data!.toList());
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
