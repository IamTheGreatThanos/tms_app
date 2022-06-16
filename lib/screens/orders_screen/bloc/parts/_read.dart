part of '../orders_bloc.dart';

extension Read on OrdersBloc {
  Future<void> _read(
    EventInitialOrdersScreen event,
    Emitter<StateBlocOrdersScreen> emit,
  ) async {
    CitiesResponse citiesResponse = CitiesResponse();
    List<OrderDTO> ordersResponse = [];
    List<OrderDTO> currentOrders = [];
    List<OrderDTO> overallOrders = [];
    try {
      emit(StateLoadingOrdersScreen());
      citiesResponse = await repository.getCities();
      try {
        ordersResponse =
            await repository.getOrdersByCities(); // (cityId: event.cityId);
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
      for (int i = 0; i < currentOrders.length; i++) {
        // currentOrders[i].isCurrent = true;
        currentOrders[i] = currentOrders[i].copyWith(isCurrent: true);
        // if (currentOrders.data![i].fromCityId!.id.toString() ==
        //     event.cityId) {
        overallOrders.add(currentOrders[i]);
        // }
      }

      overallOrders.addAll(ordersResponse);

      // log(overallOrders.map((e) => e.isCurrent).toList().toString());
      emit(
        StateLoadDataOrdersScreen(
          orders: overallOrders,
          cities: citiesResponse.data ?? [],
        ),
      );
    } catch (e) {
      emit(
        StateOrdersScreenError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }
}
