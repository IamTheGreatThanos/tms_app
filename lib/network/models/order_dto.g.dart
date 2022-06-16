// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderDTO _$$_OrderDTOFromJson(Map<String, dynamic> json) => _$_OrderDTO(
      id: json['id'] as int,
      day: json['day'],
      description: json['description'] as String?,
      regionName: json['region_name'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      fromLat: (json['from_lat'] as num?)?.toDouble(),
      fromLong: (json['from_long'] as num?)?.toDouble(),
      toLat: (json['to_lat'] as num?)?.toDouble(),
      toLong: (json['to_long'] as num?)?.toDouble(),
      status: json['status'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      payment: json['payment'] as String?,
      fromCity: json['from_city_id'] == null
          ? null
          : CityDTO.fromJson(json['from_city_id'] as Map<String, dynamic>),
      toCity: json['to_city_id'] == null
          ? null
          : CityDTO.fromJson(json['to_city_id'] as Map<String, dynamic>),
      points: (json['points'] as List<dynamic>?)
          ?.map((e) => PointDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      countPoints: json['count_points'] as int?,
      orderStatus: json['order_status'] == null
          ? null
          : OrderStatusDTO.fromJson(
              json['order_status'] as Map<String, dynamic>),
      isCurrent: json['isCurrent'] as bool? ?? false,
    );

Map<String, dynamic> _$$_OrderDTOToJson(_$_OrderDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'description': instance.description,
      'region_name': instance.regionName,
      'from': instance.from,
      'to': instance.to,
      'from_lat': instance.fromLat,
      'from_long': instance.fromLong,
      'to_lat': instance.toLat,
      'to_long': instance.toLong,
      'status': instance.status,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'payment': instance.payment,
      'from_city_id': instance.fromCity,
      'to_city_id': instance.toCity,
      'points': instance.points,
      'count_points': instance.countPoints,
      'order_status': instance.orderStatus,
      'isCurrent': instance.isCurrent,
    };

_$_OrderStatusDTO _$$_OrderStatusDTOFromJson(Map<String, dynamic> json) =>
    _$_OrderStatusDTO(
      id: json['id'] as int,
      orderId: json['order_id'] as int,
      status: json['status'] as String?,
      stopReason: json['stop_reason'] as String?,
      stopTimer: json['stop_timer'] == null
          ? null
          : DateTime.parse(json['stop_timer'] as String),
      order: json['order'] as String?,
      orderStatus: json['order_status'] as String?,
    );

Map<String, dynamic> _$$_OrderStatusDTOToJson(_$_OrderStatusDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'stop_reason': instance.stopReason,
      'stop_timer': instance.stopTimer?.toIso8601String(),
      'order': instance.order,
      'order_status': instance.orderStatus,
    };
