import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/register_phone.dart';
part 'parts/register_phone_code.dart';
part 'parts/register_confirm.dart';

class BlocAuth extends Bloc<EventBlocAuth, StateBlocAuth> {
  BlocAuth({
    required this.repository,
}) : super(SignInInitial()) {
    on<EventRegisterPhone>(_registerPhone);
    on<EventRegisterPhoneCode>(_registerPhoneCode);
    on<EventRegisterConfirm>(_registerConfirm);
    on<EventAuthInit>((event, emit) => emit(SignInInitial()));
  }

  final GlobalRepository repository;
  String registerToken = '';
}
