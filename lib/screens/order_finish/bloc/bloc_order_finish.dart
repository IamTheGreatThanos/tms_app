import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';
part 'parts/_finish.dart';

class BlocOrderFinish extends Bloc<EventBlocOrderFinish, StateBlocOrderFinish> {
  BlocOrderFinish({
    required this.repository,
  }) : super(StateLoadingOrderFinish()) {
    on<EventOrderFinishInitial>(_read);
    on<EventOrderProductFinish>(_finish);
  }

  final GlobalRepository repository;
  int? pointId;
}
