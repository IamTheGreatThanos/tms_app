import 'dart:async';
import 'dart:developer';

import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cities_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'parts/_read.dart';
part 'states.dart';

class OrdersBloc extends Bloc<EventBlocOrdersScreen, StateBlocOrdersScreen> {
  OrdersBloc({
    required this.repository,
  }) : super(StateLoadingOrdersScreen()) {
    on<EventInitialOrdersScreen>(_read);
  }

  final GlobalRepository repository;
  int? cityId;
}
