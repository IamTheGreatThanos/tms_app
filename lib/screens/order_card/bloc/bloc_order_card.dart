import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocOrderCard extends Bloc<EventBlocOrderCard, StateBlocOrderCard> {
  BlocOrderCard() : super(StateLoadingOrderCard()) {
    on<EventInitialOrderCard>(_read);
  }
}
