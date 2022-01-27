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
      if (ridesHistory.isEmpty) {
        Random rand = Random();
        for (int i = 0; i < 500; i++) {
          DateTime date = DateTime.now().subtract(
              Duration(days: rand.nextInt(365), minutes: rand.nextInt(720)));
          ridesHistory.add(RidesResponse(date: date, name: "ANGZ01010101001"));
        }
        ridesHistory.sort((a, b) => b.date!.compareTo(a.date!));
        for (int i = 0; i < ridesHistory.length - 1; i++) {
          if (!ridesHistory[i].date!.isEquals(ridesHistory[i + 1].date!)) {
            ridesHistory[i].showTime = true;
          }
        }
      }
      ridesHistory[0].showTime = true;

      emit(StateLoadRideHistory(
        history: ridesHistory
            .where((element) =>
                element.date!.isAfter(event.from ??
                    DateTime.now().subtract(Duration(days: 31))) &&
                element.date!.isBefore(event.to ?? DateTime.now()))
            .toList(),
        from: event.from ?? DateTime.now().subtract(Duration(days: 31)),
        to: event.to ?? DateTime.now(),
      ));
    } catch (e) {}
  }
}
