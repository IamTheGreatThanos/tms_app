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
  }) = _PointDTO;

  factory PointDTO.fromJson(Map<String, dynamic> json) =>
      _$PointDTOFromJson(json);
}
