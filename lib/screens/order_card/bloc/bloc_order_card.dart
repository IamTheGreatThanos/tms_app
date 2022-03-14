import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_points_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';
part 'parts/_stop.dart';

class BlocOrderCard extends Bloc<EventBlocOrderCard, StateBlocOrderCard> {
  BlocOrderCard({required this.repository}) : super(StateLoadingOrderCard()) {
    on<EventInitialOrderCard>(_read);
    on<EventStopOrder>(_stop);
  }

  final GlobalRepository repository;
  int? orderId;
}
