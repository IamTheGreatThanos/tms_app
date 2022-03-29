import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/accepted_orders_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cities_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../network/models/dto_models/response/orders_response.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocOrdersScreen extends Bloc<EventBlocOrdersScreen, StateBlocOrdersScreen> {
  BlocOrdersScreen({
    required this.repository,
}) : super(StateLoadingOrdersScreen()) {
    on<EventInitialOrdersScreen>(_read);
  }

  final GlobalRepository repository;
  int? cityId;
}
