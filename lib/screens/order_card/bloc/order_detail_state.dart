part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailState {}

class StateLoadingOrderCard extends OrderDetailState {}

class StateStopSuccess extends OrderDetailState {}

class StateStartSuccess extends OrderDetailState {}

class StateResumeSuccess extends OrderDetailState {}

class StateChangedDriverOrderCard extends OrderDetailState {}

// class StateLoadOrderDetails extends StateBlocOrderCard {
//   final OrderData order;

//   StateLoadOrderDetails({
//     required this.order,
//   });
// }

class StateLoadDataOrderCard extends OrderDetailState {
  final List<PointDTO> orderPoints;
  final OrderData order;

  StateLoadDataOrderCard({
    required this.orderPoints,
    required this.order,
  });
}

class StateShowTimerInitial extends OrderDetailState {
  final DateTime startTimer;

  StateShowTimerInitial({
    required this.startTimer,
  });
}

class StateOrderCardError extends OrderDetailState {
  final AppError error;

  StateOrderCardError({
    required this.error,
  });
}

// @freezed
// class BlocOrderCardState with _$BlocOrderCardState {
//   const factory BlocOrderCardState.loadingState() = _LoadingState;

//   const factory BlocOrderCardState.startedState() = _StartedState;

//   const factory BlocOrderCardState.stopedState() = _StopedState;

//   const factory BlocOrderCardState.resumedState() = _ResumedState;

//   const factory BlocOrderCardState.loadedState({

//   }) = _LoadingState;

//   const factory BlocOrderCardState.loadingState() = _LoadingState;

//   const factory BlocOrderCardState.loadingState() = _LoadingState;
// }
