import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cities_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/screens/personal_data_screen/ui/widgets/_vmodel.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';

part 'parts/_edit.dart';

class BlocPersonalData
    extends Bloc<EventBlocPersonalData, StateBlocPersonalData> {
  BlocPersonalData({
    required this.repository,
  }) : super(StateLoadingPersonalData()) {
    on<EventInitialPersonalData>(_read);
    on<EventEditProfile>(_edit);
  }

  final GlobalRepository repository;
}
