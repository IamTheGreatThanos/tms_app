part of '../bloc_ride_history.dart';

extension Read on BlocRideHistory {
  Future<void> _read(
    EventReadRideHistory event,
    Emitter<StateBlocRideHistory> emit,
  ) async {
    try {
      if (event.from != null || event.to != null) {
        emit(StateRideHistoryInitial());
      }
      var historyData = await repository.orderHistory(
          DateFormat("yyyy-dd-MM").format(
              event.from ?? DateTime.now().subtract(const Duration(days: 31))),
          DateFormat("yyyy-dd-MM").format(event.to ?? DateTime.now()));
      var filteredHistory;
      if (historyData.data != null && historyData.data!.isNotEmpty) {
        filteredHistory = historyData.data!
            .where((element) =>
                element.createdAt!.isAfter(event.from ??
                    DateTime.now().subtract(Duration(days: 31))) &&
                element.createdAt!.isBefore(event.to ?? DateTime.now()))
            .toList();
        if (filteredHistory.length > 1 && filteredHistory[0]
            .createdAt!
            .isEquals(filteredHistory[1].createdAt!) ) {
          filteredHistory[1].showTime = false;
          filteredHistory[0].showTime = true;
        }
      }
      emit(StateLoadRideHistory(
        history: filteredHistory,
        from: event.from ?? DateTime.now().subtract(Duration(days: 31)),
        to: event.to ?? DateTime.now(),
      ));
    } catch (e) {}
  }
}
