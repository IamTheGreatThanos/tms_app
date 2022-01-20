import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_wrapper.dart';
import 'package:europharm_flutter/network/dio_wrapper/side_dio_wrapper.dart';
import 'package:path_provider/path_provider.dart';

class NetworkService {
  late final DioWrapper _dioWrapper;
  final SideDioWrapper _sideDioWrapper = SideDioWrapper();
  static const String constToken =
      '';

  void init(DioWrapper dioService) {
    _dioWrapper = dioService;
  }


}
