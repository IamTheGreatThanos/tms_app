import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';

class BlocAuth extends Bloc<EventBlocAuth, StateBlocAuth> {
  BlocAuth() : super(SignInInitial()) {
  }
}
