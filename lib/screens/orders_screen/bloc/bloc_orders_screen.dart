import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocOrdersScreen extends Bloc<EventBlocOrdersScreen, StateBlocOrdersScreen> {
  BlocOrdersScreen() : super(StateLoadingOrdersScreen()) {
    on<EventInitialOrdersScreen>(_read);
  }
}
