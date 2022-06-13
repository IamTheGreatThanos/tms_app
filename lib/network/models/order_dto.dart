// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

@freezed
class OrderDTO with _$OrderDTO {
  const factory OrderDTO({
    required int id,
    dynamic day, // FIXME
    String? description,
    @JsonKey(name: 'region_name') String? regionName,
    String? from,
    String? to,
    @JsonKey(name: 'from_lat') double? fromLat,
    @JsonKey(name: 'from_long') double? fromLong,
    @JsonKey(name: 'to_lat') double? toLat,
    @JsonKey(name: 'to_long') double? toLong,
    String? status,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? payment,
    // String? type,
    // dynamic avatar,
    // String? status,
  }) = _OrderDTO;

  factory OrderDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDTOFromJson(json);
}
