part of 'bloc_ride_history.dart';

@immutable
abstract class StateBlocRideHistory {}

class StateRideHistoryInitial extends StateBlocRideHistory {}

class StateLoadRideHistory extends StateBlocRideHistory {
  final List<RidesResponse> history;
  final DateTime from;
  final DateTime to;

  StateLoadRideHistory({
    required this.history,
    required this.from,
    required this.to,
  });
}
