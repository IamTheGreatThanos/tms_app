import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class PushNotificationManager {
  late GlobalRepository _repository;
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _firebaseMessagingToken = '';
  StreamSubscription<RemoteMessage>? messageSub;
  StreamSubscription<RemoteMessage>? messageOpenedAppSub;
  StreamSubscription<String>? tokenRefreshSub;
  late final S _lang;

  PushNotificationManager();

  Future initialize(
      NavigatorState navigator, GlobalRepository repository, S lang) async {
    _lang = lang;
    this._repository = repository;
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
          sound: true, alert: true, badge: true);
    }

    messageSub = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(_lang.push_foreground);
      print('${_lang.message_data}: ${message.data}');

      if (message.notification != null) {
        print(
            '${_lang.message_contained_notification}: ${message.notification}');
      }
    });

    messageOpenedAppSub =
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(_lang.push_foreground);
      print('${_lang.message_data}: ${message.data}');

      // navigator.push(MaterialPageRoute(builder: (context) {
      //   return NotificationsScreen();
      // }));
      if (message.notification != null) {
        print(
            '${_lang.message_contained_notification}: ${message.notification}');
      }
    });

    try {
      _firebaseMessagingToken = (await _firebaseMessaging.getToken()) ?? '';
      String deviceId = '';
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.androidId;
      }
      if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      print('🟢 ${_lang.firebase_messaging_token}: $_firebaseMessagingToken');
    } catch (e) {
      print(e);
    }
  }


  Future close() async {
    await messageSub?.cancel();
    await messageOpenedAppSub?.cancel();
    await tokenRefreshSub?.cancel();
    await _firebaseMessaging.deleteToken();
  }
}
