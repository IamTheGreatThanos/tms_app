class OrderPointsResponse {
  OrderPointsResponse({
      this.success, 
      this.statusCode, 
      this.message, 
      this.data,});

  OrderPointsResponse.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

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

class Data {
  Data({
      this.id, 
      this.name, 
      this.address, 
      this.status, 
      this.date, 
      this.createdAt, 
      this.updatedAt, 
      this.products, 
      this.countProducts, 
      this.from, 
      this.to, 
      this.fromLat, 
      this.fromLong, 
      this.toLat, 
      this.toLong,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    countProducts = json['count_products'];
    from = json['from'];
    to = json['to'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
  }
  int? id;
  String? name;
  String? address;
  String? status;
  String? date;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  int? countProducts;
  dynamic from;
  dynamic to;
  dynamic fromLat;
  dynamic fromLong;
  dynamic toLat;
  dynamic toLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['status'] = status;
    map['date'] = date;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['count_products'] = countProducts;
    map['from'] = from;
    map['to'] = to;
    map['from_lat'] = fromLat;
    map['from_long'] = fromLong;
    map['to_lat'] = toLat;
    map['to_long'] = toLong;
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.point, 
      this.name, 
      this.code, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    point = json['point'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? point;
  String? name;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['point'] = point;
    map['name'] = name;
    map['code'] = code;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}