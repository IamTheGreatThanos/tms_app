// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PointDTO _$$_PointDTOFromJson(Map<String, dynamic> json) => _$_PointDTO(
      id: json['id'] as int,
      name: json['name'] as String?,
      address: json['address'] as String?,
      status: json['status'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      from: json['from'] as String?,
      to: json['to'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      type: json['type'],
      avatar: json['avatar'],
      countProducts: json['count_products'] as int?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$_PointDTOToJson(_$_PointDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
      'from': instance.from,
      'to': instance.to,
      'lat': instance.lat,
      'long': instance.long,
      'type': instance.type,
      'avatar': instance.avatar,
      'count_products': instance.countProducts,
      'created_at': instance.createdAt,
    };
