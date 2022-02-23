/// success : true
/// statusCode : 200
/// message : "good"
/// data : []

class OrderHistoryResponse {
  OrderHistoryResponse({
      bool? success, 
      int? statusCode, 
      String? message, 
      List<dynamic>? data,}){
    _success = success;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  OrderHistoryResponse.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    // if (json['data'] != null) {
    //   _data = [];
    //   json['data'].forEach((v) {
    //     _data?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  bool? _success;
  int? _statusCode;
  String? _message;
  List<dynamic>? _data;

  bool? get success => _success;
  int? get statusCode => _statusCode;
  String? get message => _message;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}