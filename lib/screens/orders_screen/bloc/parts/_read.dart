part of '../bloc_orders_screen.dart';

extension Read on BlocOrdersScreen {
  Future<void> _read(EventInitialOrdersScreen event,
      Emitter<StateBlocOrdersScreen> emit) async {
    var citiesResponse;
    try {
      emit(StateLoadingOrdersScreen());
      citiesResponse = await repository.getCities();
      var ordersResponse = await repository.getOrdersByCities(event.cityId);

      emit(StateLoadDataOrdersScreen(orders: ordersResponse.data!, cities: citiesResponse.data ?? []));
    } catch (e) {
      if(e.dioErrorStatusCode == 400){
        emit(StateLoadDataOrdersScreen(orders: const [], cities: citiesResponse.data ?? []));

      }
    }
  }
}
