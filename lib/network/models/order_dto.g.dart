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
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      payment: json['payment'] as String?,
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
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'payment': instance.payment,
    };
