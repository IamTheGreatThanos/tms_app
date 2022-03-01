part of '../bloc_orders_screen.dart';

extension Read on BlocOrdersScreen {
  Future<void> _read(EventInitialOrdersScreen event,
      Emitter<StateBlocOrdersScreen> emit) async {
    try {
      emit(StateLoadingOrdersScreen());
      var citiesResponse = await repository.getCities();
      var ordersResponse = await repository.getOrdersByCities(event.cityId);

      emit(StateLoadDataOrdersScreen(orders: ordersResponse.data!, cities: citiesResponse.data ?? []));
    } catch (e) {}
  }
}
