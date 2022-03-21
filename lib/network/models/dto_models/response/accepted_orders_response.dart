import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';

class AcceptedOrdersResponse {
  AcceptedOrdersResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final List<AcceptedOrdersData>? data;

  factory AcceptedOrdersResponse.fromJson(Map<String, dynamic> json) =>
      AcceptedOrdersResponse(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<AcceptedOrdersData>.from(json["data"].map((x) => AcceptedOrdersData.fromJson(x))),
      );
}

class AcceptedOrdersData {
  AcceptedOrdersData({
    this.id,
    this.order,
    this.user,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final OrdersData? order;
  final User? user;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AcceptedOrdersData.fromJson(Map<String, dynamic> json) => AcceptedOrdersData(
        id: json["id"],
        order: json["order"] == null ? null : OrdersData.fromJson(json["order"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class User {
  User({
    this.id,
    this.city,
    this.phone,
    this.name,
    this.surname,
    this.date,
    this.iin,
    this.role,
    this.type,
    this.avatar,
    this.token,
    this.promocode,
    this.actived,
    this.phoneVerified,
    this.createdAt,
    this.updatedAt,
    this.documents,
    this.transport,
  });

  final int? id;
  final dynamic city;
  final String? phone;
  final dynamic name;
  final dynamic surname;
  final dynamic date;
  final dynamic iin;
  final String? role;
  final String? type;
  final dynamic avatar;
  final dynamic token;
  final dynamic promocode;
  final bool? actived;
  final DateTime? phoneVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic documents;
  final dynamic transport;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        city: json["city"],
        phone: json["phone"],
        name: json["name"],
        surname: json["surname"],
        date: json["date"],
        iin: json["iin"],
        role: json["role"],
        type: json["type"],
        avatar: json["avatar"],
        token: json["token"],
        promocode: json["promocode"],
        actived: json["actived"],
        phoneVerified: json["phone_verified"] == null
            ? null
            : DateTime.parse(json["phone_verified"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        documents: json["documents"],
        transport: json["transport"],
      );
}
