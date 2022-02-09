/// success : true
/// statusCode : 200
/// message : "Success!"
/// data : {"id":101,"city":null,"phone":"77089146990","name":null,"surname":null,"date":null,"iin":null,"avatar":null,"token":"E95NWRL2ALOC9JFRUDBYZYV2JUWW8MLZFCZQYVYP","promocode":null,"actived":false,"phone_verified":"2022-02-08T10:12:44.512780Z","created_at":"2022-02-08T10:12:44.000000Z","updated_at":"2022-02-08T10:12:44.000000Z","car":null,"documents":null}

class PhoneCodeRegisterResponse {
  PhoneCodeRegisterResponse({
      bool? success, 
      int? statusCode, 
      String? message, 
      Data? data,}){
    _success = success;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  PhoneCodeRegisterResponse.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  int? _statusCode;
  String? _message;
  Data? _data;

  bool? get success => _success;
  int? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 101
/// city : null
/// phone : "77089146990"
/// name : null
/// surname : null
/// date : null
/// iin : null
/// avatar : null
/// token : "E95NWRL2ALOC9JFRUDBYZYV2JUWW8MLZFCZQYVYP"
/// promocode : null
/// actived : false
/// phone_verified : "2022-02-08T10:12:44.512780Z"
/// created_at : "2022-02-08T10:12:44.000000Z"
/// updated_at : "2022-02-08T10:12:44.000000Z"
/// car : null
/// documents : null

class Data {
  Data({
      int? id, 
      dynamic city, 
      String? phone, 
      String? password,
      dynamic name,
      dynamic surname, 
      dynamic date, 
      dynamic iin, 
      dynamic avatar, 
      String? token, 
      dynamic promocode, 
      bool? actived, 
      String? phoneVerified, 
      String? createdAt, 
      String? updatedAt, 
      dynamic car, 
      dynamic documents,}){
    _id = id;
    _city = city;
    _phone = phone;
    _name = name;
    _password = password;
    _surname = surname;
    _date = date;
    _iin = iin;
    _avatar = avatar;
    _token = token;
    _promocode = promocode;
    _actived = actived;
    _phoneVerified = phoneVerified;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _car = car;
    _documents = documents;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _city = json['city'];
    _phone = json['phone'];
    _name = json['name'];
    _password = json['password'];
    _surname = json['surname'];
    _date = json['date'];
    _iin = json['iin'];
    _avatar = json['avatar'];
    _token = json['token'];
    _promocode = json['promocode'];
    _actived = json['actived'] is bool ? json['actived'] : json['actived'] == 0 ? true : false;
    _phoneVerified = json['phone_verified'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _car = json['car'];
    _documents = json['documents'];
  }
  int? _id;
  dynamic _city;
  String? _phone;
  dynamic _name;
  dynamic _surname;
  dynamic _date;
  dynamic _iin;
  dynamic _avatar;
  String? _token;
  String? _password;
  dynamic _promocode;
  bool? _actived;
  String? _phoneVerified;
  String? _createdAt;
  String? _updatedAt;
  dynamic _car;
  dynamic _documents;

  int? get id => _id;
  dynamic get city => _city;
  String? get phone => _phone;
  String? get password => _password;
  dynamic get name => _name;
  dynamic get surname => _surname;
  dynamic get date => _date;
  dynamic get iin => _iin;
  dynamic get avatar => _avatar;
  String? get token => _token;
  dynamic get promocode => _promocode;
  bool? get actived => _actived;
  String? get phoneVerified => _phoneVerified;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get car => _car;
  dynamic get documents => _documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city'] = _city;
    map['phone'] = _phone;
    map['name'] = _name;
    map['surname'] = _surname;
    map['date'] = _date;
    map['iin'] = _iin;
    map['avatar'] = _avatar;
    map['token'] = _token;
    map['promocode'] = _promocode;
    map['actived'] = _actived;
    map['phone_verified'] = _phoneVerified;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['car'] = _car;
    map['documents'] = _documents;
    return map;
  }

}