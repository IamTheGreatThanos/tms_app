import 'package:europharm_flutter/network/models/dto_models/response/cars_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/cities_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/marks_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_history_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_points_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/positions_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:europharm_flutter/network/repository/hive_repository.dart';
import 'package:europharm_flutter/network/services/network_service.dart';
import 'package:europharm_flutter/screens/personal_data_screen/ui/widgets/_vmodel.dart';
import 'package:europharm_flutter/screens/user_confirmation/ui/_vmodel.dart';

class GlobalRepository {
  late final NetworkService _networkService;

  void init(NetworkService networkService, HiveRepository hiveRepository) {
    _networkService = networkService;
    // if(hiveRepository.getUserId().isNotEmpty) {
    //   try {
    //     analytics.setUserId(hiveRepository.getUserId());
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  }

  Future<LoginResponse> login(String phone, String password) async =>
      await _networkService.login(phone, password);

  Future<PhoneRegisterResponse> registerPhone(String phone) async =>
      await _networkService.registerPhone(phone);

  Future<PhoneCodeRegisterResponse> registerPhoneCode(
          String phone, String code) async =>
      await _networkService.registerPhoneCode(phone, code);

  Future<PhoneCodeRegisterResponse> registerConfirm(String password,
          String registerToken, String deviceOs, String deviceToken) async =>
      await _networkService.registerConfirm(
          password, registerToken, deviceOs, deviceToken);

  Future<ProfileResponse> getProfile() async =>
      await _networkService.getProfile();

  Future<CarsResponse> getCars() async => await _networkService.getCars();

  Future<MarksResponse> getMarks() async => await _networkService.getMarks();

  Future<CitiesResponse> getCities() async => _networkService.getCities();

  Future<OrdersResponse> acceptedOrders() async =>
      await _networkService.acceptedOrders();

  Future<OrdersResponse> getOrdersByCities({
    String? cityId,
  }) async =>
      _networkService.getOrdersByCities(cityId: cityId);

  Future<void> verify(PersonalInfoVModel vModel) async =>
      await _networkService.verify(vModel);

  Future<OrderData> acceptOrder(int orderId) async =>
      await _networkService.acceptOrder(orderId);

  Future<OrderPointsResponse> orderPoints(int orderId) async =>
      await _networkService.orderPoints(orderId);

  Future<OrderPoint> orderPointProducts(int pointId) async =>
      await _networkService.orderPointProducts(pointId);

  Future<OrderPoint> orderProductFinish(int productId, String code) async =>
      await _networkService.orderProductFinish(productId, code);

  Future<OrderData> stopOrder(int orderId, String cause) async =>
      await _networkService.stopOrder(orderId, cause);

  Future<OrderData> resumeOrder(int orderId) async =>
      await _networkService.resumeOrder(orderId);

  Future<OrderHistoryResponse> orderHistory(
          String startDate, String endDate) async =>
      await _networkService.orderHistory(startDate, endDate);

  Future<PositionsResponse> getPositions() async =>
      await _networkService.getPositions();

  Future<void> editProfile(
    PersonalDataVModel vModel,
  ) async =>
      await _networkService.editProfile(vModel);

  // Future<void> sendDeviceToken(String deviceOs, String deviceToken) async =>
  //     await _networkService.sendDeviceToken(deviceOs, deviceToken);

  Future<void> sendDeviceToken(String deviceToken) async =>
      _networkService.sendDeviceToken(deviceToken: deviceToken);

  Future<void> logout() async => _networkService.logout();
}
