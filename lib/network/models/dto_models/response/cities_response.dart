class CitiesResponse {
  CitiesResponse({
      this.success, 
      this.statusCode, 
      this.message, 
      this.data,});

  CitiesResponse.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CityData.fromJson(v));
      });
    }
  }
  bool? success;
  int? statusCode;
  String? message;
  List<CityData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CityData {
  CityData({
      this.id, 
      this.name, 
      this.countryId, 
      this.createdAt, 
      this.updatedAt,});

  CityData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? countryId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country_id'] = countryId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}