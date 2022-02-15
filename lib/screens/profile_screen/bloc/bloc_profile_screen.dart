import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';

class BlocProfileScreen extends Bloc<EventBlocProfile, StateBlocProfile> {
  BlocProfileScreen({
    required this.repository,
  }) : super(StateProfileLoading()) {
    on<EventProfileInitial>(_read);
  }

  final GlobalRepository repository;
}
