import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_wrapper.dart';
import 'package:europharm_flutter/network/models/dto_models/response/login_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/order_points_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_code_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/phone_register_response.dart';
import 'package:europharm_flutter/network/models/dto_models/response/profile_response.dart';
import 'package:europharm_flutter/screens/personal_data_screen/ui/widgets/_vmodel.dart';

import '../../screens/user_confirmation/ui/_vmodel.dart';
import '../models/dto_models/response/cars_response.dart';
import '../models/dto_models/response/cities_response.dart';
import '../models/dto_models/response/marks_response.dart';
import '../models/dto_models/response/order_history_response.dart';
import '../models/dto_models/response/positions_response.dart';

const _networkService = 'NetworkService';

class NetworkService {
  late final DioWrapper _dioWrapper;
  // final SideDioWrapper _sideDioWrapper = SideDioWrapper();
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

  Future<PhoneCodeRegisterResponse> registerConfirm(String password,
      String registerToken, String deviceOs, String deviceToken) async {
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

  Future<void> sendDeviceToken({
    required String deviceToken,
  }) async {
    String? deviceOS;
    if (Platform.isIOS) {
      deviceOS = 'ios';
    } else {
      deviceOS = 'android';
    }
    var response = await _dioWrapper.sendRequest(
      formData: FormData.fromMap({
        "device_token": deviceToken,
        "device_os": deviceOS,
      }),
      path: "device",
      method: NetworkMethod.post,
    );

    log('$response', name: _networkService);
  }

  Future<ProfileResponse> getProfile() async {
    var response = await _dioWrapper.sendRequest(
      path: "profile",
      method: NetworkMethod.get,
    );
    return ProfileResponse.fromJson(response.data);
  }

  Future<PositionsResponse> getPositions() async {
    var response = await _dioWrapper.sendRequest(
      path: "positions",
      method: NetworkMethod.get,
    );
    return PositionsResponse.fromJson(response.data);
  }

  Future<CarsResponse> getCars() async {
    var response = await _dioWrapper.sendRequest(
      path: "cars",
      method: NetworkMethod.get,
    );
    return CarsResponse.fromJson(response.data);
  }

  Future<MarksResponse> getMarks() async {
    var response = await _dioWrapper.sendRequest(
      path: "marks",
      method: NetworkMethod.get,
    );
    return MarksResponse.fromJson(response.data);
  }

  Future<CitiesResponse> getCities() async {
    var response = await _dioWrapper.sendRequest(
      path: "cities",
      method: NetworkMethod.get,
    );
    return CitiesResponse.fromJson(response.data);
  }

  Future<OrdersResponse> getOrdersByCities({
    String? cityId,
  }) async {
    var response = await _dioWrapper.sendRequest(
      path: "orders",
      formData: FormData.fromMap({
        if (cityId != null) "city_id": cityId,
      }),
      method: NetworkMethod.post,
    );
    return OrdersResponse.fromJson(response.data);
  }

  Future<void> verify(PersonalInfoVModel vModel) async {
    await _dioWrapper.sendRequest(
        path: "verify",
        method: NetworkMethod.post,
        formData: FormData.fromMap(await vModel.toJson()));
  }

  Future<OrderData> acceptOrder(int orderId) async {
    final response = await _dioWrapper.sendRequest(
        path: "/order/accept",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "order_id": orderId,
        }));
    print(response);
    return OrderData.fromJson(response.data["data"]);
  }

  // Future<void> sendDeviceToken(String deviceOs, String deviceToken) async { /// FIXME
  //   final response = await _dioWrapper.sendRequest(
  //       path: "/device",
  //       method: NetworkMethod.post,
  //       formData: FormData.fromMap({
  //         "device_token": deviceToken,
  //         "device_os": deviceOs,
  //       }));
  //   print(response);
  // }

  Future<OrderData> stopOrder(int orderId, String cause) async {
    final response = await _dioWrapper.sendRequest(
        path: "/order/stop",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "order_id": orderId,
          "stop_reason": cause,
        }));
    print(response);
    return OrderData.fromJson(response.data["data"]);
  }

  Future<OrderData> resumeOrder(
    int orderId,
  ) async {
    var response = await _dioWrapper.sendRequest(
        path: "order/resume",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "order_id": orderId,
        }));
    print(response);
    return OrderData.fromJson(response.data["data"]);
  }

  Future<OrderPointsResponse> orderPoints(int orderId) async {
    final response = await _dioWrapper.sendRequest(
      path: "/order/points",
      method: NetworkMethod.post,
      formData: FormData.fromMap(
        {
          "order_id": orderId,
        },
      ),
    );
    
    return OrderPointsResponse.fromJson(response.data);
  }

  Future<OrderPoint> orderPointProducts(int pointId) async {
    final response = await _dioWrapper.sendRequest(
        path: "/order/point/products",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "point_id": pointId,
        }));
    return OrderPoint.fromJson(response.data["data"]);
  }

  Future<OrderPoint> orderProductFinish(int productId, String code) async {
    final response = await _dioWrapper.sendRequest(
        path: "/order/point/product/finish",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "product_id": productId,
          "code": code,
        }));
    return OrderPoint.fromJson(response.data["data"]);
  }

  Future<OrdersResponse> acceptedOrders() async {
    final response = await _dioWrapper.sendRequest(
      path: "/orders/accepted",
      method: NetworkMethod.get,
    );
    return OrdersResponse.fromJson(response.data);
  }

  Future<OrderHistoryResponse> orderHistory(
      String startDate, String endDate) async {
    var response = await _dioWrapper.sendRequest(
        path: "order/history",
        method: NetworkMethod.post,
        formData: FormData.fromMap({
          "start_date": startDate,
          "end_date": endDate,
        }));
    return OrderHistoryResponse.fromJson(response.data);
  }

  Future<void> editProfile(
    PersonalDataVModel vModel,
  ) async {
    var response = await _dioWrapper.sendRequest(
        path: "profile-edit",
        method: NetworkMethod.post,
        formData: FormData.fromMap(await vModel.toJson()));
    print(response);
  }

  Future<void> logout() async {
    await _dioWrapper.sendRequest(
      path: "logout",
      method: NetworkMethod.post,
    );
  }
}
