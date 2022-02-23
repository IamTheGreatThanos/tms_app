import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_wrapper.dart';
import 'package:europharm_flutter/network/dio_wrapper/side_dio_wrapper.dart';
import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:path_provider/path_provider.dart';

import '../../screens/user_confirmation/ui/_vmodel.dart';

class NetworkService {
  late final DioWrapper _dioWrapper;
  final SideDioWrapper _sideDioWrapper = SideDioWrapper();
  static const String constToken = '';

  void init(DioWrapper dioService) {
    _dioWrapper = dioService;
  }

  Future<PhoneRegisterResponse> registerPhone(String phone) async {
    var response = await _dioWrapper.sendRequest(
      formData: FormData.fromMap({
        "phone": phone,
      }),
      path: "register",
      method: NetworkMethod.post,
    );
    return PhoneRegisterResponse.fromJson(response.data);
  }

  Future<PhoneCodeRegisterResponse> registerPhoneCode(
      String phone, String code) async {
    var response = await _dioWrapper.sendRequest(
      formData: FormData.fromMap({
        "phone": phone,
        "code": code,
      }),
      path: "register-password",
      method: NetworkMethod.post,
    );
    return PhoneCodeRegisterResponse.fromJson(response.data);
  }

  Future<PhoneCodeRegisterResponse> registerConfirm(
      String password, String registerToken) async {
    _dioWrapper.tokensRepository.save(registerToken);
    var response = await _dioWrapper.sendRequest(
      formData: FormData.fromMap({
        "password": password,
      }),
      path: "register-confirm",
      method: NetworkMethod.post,
    );
    return PhoneCodeRegisterResponse.fromJson(response.data);
  }

  Future<LoginResponse> login(String phone, String password) async {
    var response = await _dioWrapper.sendRequest(
      formData: FormData.fromMap({
        "phone": phone,
        "password": password,
      }),
      path: "login",
      method: NetworkMethod.post,
    );
    return LoginResponse.fromJson(response.data);
  }

  Future<ProfileResponse> getProfile() async {
    var response = await _dioWrapper.sendRequest(
      path: "profile",
      method: NetworkMethod.get,
    );
    return ProfileResponse.fromJson(response.data);
  }


  Future<ProfileResponse> verify(PersonalInfoVModel vModel) async {
    var response = await _dioWrapper.sendRequest(
        path: "verify",
        method: NetworkMethod.post,
        formData: FormData.fromMap(await vModel.toJson()));
    return ProfileResponse.fromJson(response.data);
  }

}
