import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/rides.dart';
import 'package:europharm_flutter/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/read.dart';
class BlocRideHistory extends Bloc<EventBlocRideHistory, StateBlocRideHistory> {
  BlocRideHistory() : super(StateRideHistoryInitial()) {
    on<EventReadRideHistory>(_read);
  }

  List<RidesResponse> ridesHistory = [];
}