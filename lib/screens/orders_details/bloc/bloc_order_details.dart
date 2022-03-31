import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocOrderDetails extends Bloc<EventBlocOrderDetails, StateBlocOrderDetails> {
  BlocOrderDetails() : super(StateLoadingOrderDetails()) {
    on<EventInitialOrderDetails>(_read);
  }
}
