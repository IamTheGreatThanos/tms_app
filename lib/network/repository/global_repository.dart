import 'dart:io';

import 'package:europharm_flutter/network/models/dto_models/response/accepted_orders_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cars_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/marks_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_history_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_points_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/positions_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:europharm_flutter/network/repository/hive_repository.dart';
import 'package:europharm_flutter/network/services/network_service.dart';

import '../../screens/user_confirmation/ui/_vmodel.dart';
import '../models/dto_models/response/cities_response.dart';

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

  Future<LoginResponse> login(String phone, String password) async =>
      await _networkService.login(phone, password);

  Future<PhoneRegisterResponse> registerPhone(String phone) async =>
      await _networkService.registerPhone(phone);

  Future<PhoneCodeRegisterResponse> registerPhoneCode(
          String phone, String code) async =>
      await _networkService.registerPhoneCode(phone, code);

  Future<PhoneCodeRegisterResponse> registerConfirm(
          String password, String registerToken) async =>
      await _networkService.registerConfirm(password, registerToken);

  Future<ProfileResponse> getProfile() async =>
      await _networkService.getProfile();

  Future<CarsResponse> getCars() async => await _networkService.getCars();

  Future<MarksResponse> getMarks() async => await _networkService.getMarks();

  Future<CitiesResponse> getCities() async => await _networkService.getCities();

  Future<AcceptedOrdersResponse> acceptedOrders() async =>
      await _networkService.acceptedOrders();

  Future<OrdersResponse> getOrdersByCities(String cityId) async =>
      await _networkService.getOrdersByCities(cityId);

  Future<void> verify(PersonalInfoVModel vModel) async =>
      await _networkService.verify(vModel);

  Future<void> acceptOrder(int orderId) async =>
      await _networkService.acceptOrder(orderId);

  Future<OrderPointsResponse> orderPoints(int orderId) async =>
      await _networkService.orderPoints(orderId);

  Future<void> stopOrder(int orderId, String cause) async =>
      await _networkService.stopOrder(orderId, cause);

  Future<OrderHistoryResponse> orderHistory(
          String startDate, String endDate) async =>
      await _networkService.orderHistory(startDate, endDate);

  Future<PositionsResponse> getPositions() async =>
      await _networkService.getPositions();

  Future<void> logout() async => await _networkService.logout();
}
