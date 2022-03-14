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

  factory AcceptedOrdersResponse.fromJson(Map<String, dynamic> json) => AcceptedOrdersResponse(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : List<AcceptedOrdersData>.from(json["data"].map((x) => AcceptedOrdersData.fromJson(x))),
  );
}

class AcceptedOrdersData {
  AcceptedOrdersData({
    this.id,
    this.description,
    this.from,
    this.to,
    this.fromLat,
    this.fromLong,
    this.toLat,
    this.toLong,
    this.status,
    this.employee,
    this.startDate,
    this.endDate,
    this.payment,
    this.fromCityId,
    this.toCityId,
    this.createdAt,
    this.images,
    this.points,
    this.countPoints,
    this.transport,
  });

  final int? id;
  final String? description;
  final String? from;
  final String? to;
  final int? fromLat;
  final int? fromLong;
  final int? toLat;
  final int? toLong;
  final String? status;
  final Employee? employee;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? payment;
  final CityId? fromCityId;
  final CityId? toCityId;
  final DateTime? createdAt;
  final Images? images;
  final List<Point>? points;
  final int? countPoints;
  final dynamic transport;

  factory AcceptedOrdersData.fromJson(Map<String?, dynamic> json) => AcceptedOrdersData(
    id: json["id"],
    description: json["description"],
    from: json["from"],
    to: json["to"],
    fromLat: json["from_lat"],
    fromLong: json["from_long"],
    toLat: json["to_lat"],
    toLong: json["to_long"],
    status: json["status"],
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    startDate: json["start_date"] == null ? null : DateTime?.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime?.parse(json["end_date"]),
    payment: json["payment"],
    fromCityId: json["from_city_id"] == null ? null : CityId.fromJson(json["from_city_id"]),
    toCityId: json["to_city_id"] == null ? null : CityId.fromJson(json["to_city_id"]),
    createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    points: json["points"] == null ? null : List<Point>.from(json["points"].map((x) => Point.fromJson(x))),
    countPoints: json["count_points"],
    transport: json["transport"],
  );
}

class Employee {
  Employee({
    this.id,
    this.cityId,
    this.name,
    this.surname,
    this.token,
    this.phone,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? cityId;
  final String? name;
  final String? surname;
  final String? token;
  final String? phone;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Employee.fromJson(Map<String?, dynamic> json) => Employee(
    id: json["id"],
    cityId: json["city_id"],
    name: json["name"],
    surname: json["surname"],
    token: json["token"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
  );
}

class CityId {
  CityId({
    this.id,
    this.name,
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? countryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CityId.fromJson(Map<String?, dynamic> json) => CityId(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
  );
}

class Images {
  Images();

  factory Images.fromJson(Map<String?, dynamic> json) => Images(
  );

  Map<String?, dynamic> toJson() => {
  };
}

class Point {
  Point({
    this.id,
    this.name,
    this.address,
    this.status,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.countProducts,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? status;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Product>? products;
  final int? countProducts;

  factory Point.fromJson(Map<String?, dynamic> json) => Point(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime?.parse(json["date"]),
    createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    countProducts: json["count_products"],
  );
}

class Product {
  Product({
    this.id,
    this.point,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? point;
  final String? name;
  final String? code;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    point: json["point"],
    name: json["name"],
    code: json["code"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
  );
}
