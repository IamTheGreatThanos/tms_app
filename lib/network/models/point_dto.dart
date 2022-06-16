// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_dto.freezed.dart';
part 'point_dto.g.dart';

@freezed
class PointDTO with _$PointDTO {
  const factory PointDTO({
    required int id,
    String? name,
    String? address,
    String? status,
    DateTime? date,
    String? from,
    String? to,
    String? lat,
    String? long,
    dynamic type,
    dynamic avatar,
    @JsonKey(name: 'count_products') int? countProducts,
    @JsonKey(name: 'created_at') String? createdAt,
    List<ProductDTO>? products,
  }) = _PointDTO;

  factory PointDTO.fromJson(Map<String, dynamic> json) =>
      _$PointDTOFromJson(json);
}

@freezed
class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required int id,
    int? point,
    String? name,
    String? code,
    String? status,

    // @JsonKey(name: 'created_at') String? createdAt,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);
}


/*
  final int? id;
  final int? point;
  final String? name;
  final String? code;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        point: json["point"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
*/
