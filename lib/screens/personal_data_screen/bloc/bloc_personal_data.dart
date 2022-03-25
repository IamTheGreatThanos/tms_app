import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cities_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';

class BlocPersonalData
    extends Bloc<EventBlocPersonalData, StateBlocPersonalData> {
  BlocPersonalData({
    required this.repository,
  }) : super(StateLoadingPersonalData()) {
    on<EventInitialPersonalData>(_read);
  }

  final GlobalRepository repository;
}
