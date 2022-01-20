import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:europharm_flutter/network/repository/hive_repository.dart';
import 'package:europharm_flutter/network/services/network_service.dart';

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
}
