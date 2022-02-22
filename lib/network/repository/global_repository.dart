import 'dart:io';

import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:europharm_flutter/network/repository/hive_repository.dart';
import 'package:europharm_flutter/network/services/network_service.dart';

import '../../screens/user_confirmation/ui/_vmodel.dart';

class GlobalRepository {
  late final NetworkService _networkService;
  late FirebaseAnalytics analytics;

  void init(NetworkService networkService, HiveRepository hiveRepository) {
    _networkService = networkService;
    analytics = FirebaseAnalytics();
    // if(hiveRepository.getUserId().isNotEmpty) {
    //   try {
    //     analytics.setUserId(hiveRepository.getUserId());
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  }

  @deprecated
  void sendAnalytics(String screenName, {Map<String, dynamic>? data}) {
    try {
      analytics.logEvent(name: screenName, parameters: data ?? {});
    } catch (e) {
      print(e);
    }
  }

  Future refreshAuthToken() async => print('asdf');

  Future<PhoneRegisterResponse> registerPhone(String phone) async =>
      await _networkService.registerPhone(phone);

  Future<PhoneCodeRegisterResponse> registerPhoneCode(
          String phone, String code) async =>
      await _networkService.registerPhoneCode(phone, code);

  Future<PhoneCodeRegisterResponse> registerConfirm(
          String password, String registerToken) async =>
      await _networkService.registerConfirm(password, registerToken);

  Future<LoginResponse> login(String phone, String password) async =>
      await _networkService.login(phone, password);

  Future<ProfileResponse> getProfile() async =>
      await _networkService.getProfile();

  Future<ProfileResponse> verify(PersonalInfoVModel vModel) async =>
      await _networkService.verify(vModel);
}
