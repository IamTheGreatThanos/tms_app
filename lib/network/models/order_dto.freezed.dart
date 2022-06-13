// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderDTO _$OrderDTOFromJson(Map<String, dynamic> json) {
  return _OrderDTO.fromJson(json);
}

/// @nodoc
mixin _$OrderDTO {
  int get id => throw _privateConstructorUsedError;
  dynamic get day => throw _privateConstructorUsedError; // FIXME
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'region_name')
  String? get regionName => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_lat')
  double? get fromLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_long')
  double? get fromLong => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_lat')
  double? get toLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_long')
  double? get toLong => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  String? get payment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDTOCopyWith<OrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDTOCopyWith<$Res> {
  factory $OrderDTOCopyWith(OrderDTO value, $Res Function(OrderDTO) then) =
      _$OrderDTOCopyWithImpl<$Res>;
  $Res call(
      {int id,
      dynamic day,
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
      String? payment});
}

/// @nodoc
class _$OrderDTOCopyWithImpl<$Res> implements $OrderDTOCopyWith<$Res> {
  _$OrderDTOCopyWithImpl(this._value, this._then);

  final OrderDTO _value;
  // ignore: unused_field
  final $Res Function(OrderDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? description = freezed,
    Object? regionName = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? fromLat = freezed,
    Object? fromLong = freezed,
    Object? toLat = freezed,
    Object? toLong = freezed,
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? payment = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: regionName == freezed
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLat: fromLat == freezed
          ? _value.fromLat
          : fromLat // ignore: cast_nullable_to_non_nullable
              as double?,
      fromLong: fromLong == freezed
          ? _value.fromLong
          : fromLong // ignore: cast_nullable_to_non_nullable
              as double?,
      toLat: toLat == freezed
          ? _value.toLat
          : toLat // ignore: cast_nullable_to_non_nullable
              as double?,
      toLong: toLong == freezed
          ? _value.toLong
          : toLong // ignore: cast_nullable_to_non_nullable
              as double?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      payment: payment == freezed
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_OrderDTOCopyWith<$Res> implements $OrderDTOCopyWith<$Res> {
  factory _$$_OrderDTOCopyWith(
          _$_OrderDTO value, $Res Function(_$_OrderDTO) then) =
      __$$_OrderDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      dynamic day,
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
      String? payment});
}

/// @nodoc
class __$$_OrderDTOCopyWithImpl<$Res> extends _$OrderDTOCopyWithImpl<$Res>
    implements _$$_OrderDTOCopyWith<$Res> {
  __$$_OrderDTOCopyWithImpl(
      _$_OrderDTO _value, $Res Function(_$_OrderDTO) _then)
      : super(_value, (v) => _then(v as _$_OrderDTO));

  @override
  _$_OrderDTO get _value => super._value as _$_OrderDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? description = freezed,
    Object? regionName = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? fromLat = freezed,
    Object? fromLong = freezed,
    Object? toLat = freezed,
    Object? toLong = freezed,
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? payment = freezed,
  }) {
    return _then(_$_OrderDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      regionName: regionName == freezed
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLat: fromLat == freezed
          ? _value.fromLat
          : fromLat // ignore: cast_nullable_to_non_nullable
              as double?,
      fromLong: fromLong == freezed
          ? _value.fromLong
          : fromLong // ignore: cast_nullable_to_non_nullable
              as double?,
      toLat: toLat == freezed
          ? _value.toLat
          : toLat // ignore: cast_nullable_to_non_nullable
              as double?,
      toLong: toLong == freezed
          ? _value.toLong
          : toLong // ignore: cast_nullable_to_non_nullable
              as double?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      payment: payment == freezed
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderDTO implements _OrderDTO {
  const _$_OrderDTO(
      {required this.id,
      this.day,
      this.description,
      @JsonKey(name: 'region_name') this.regionName,
      this.from,
      this.to,
      @JsonKey(name: 'from_lat') this.fromLat,
      @JsonKey(name: 'from_long') this.fromLong,
      @JsonKey(name: 'to_lat') this.toLat,
      @JsonKey(name: 'to_long') this.toLong,
      this.status,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'end_date') this.endDate,
      this.payment});

  factory _$_OrderDTO.fromJson(Map<String, dynamic> json) =>
      _$$_OrderDTOFromJson(json);

  @override
  final int id;
  @override
  final dynamic day;
// FIXME
  @override
  final String? description;
  @override
  @JsonKey(name: 'region_name')
  final String? regionName;
  @override
  final String? from;
  @override
  final String? to;
  @override
  @JsonKey(name: 'from_lat')
  final double? fromLat;
  @override
  @JsonKey(name: 'from_long')
  final double? fromLong;
  @override
  @JsonKey(name: 'to_lat')
  final double? toLat;
  @override
  @JsonKey(name: 'to_long')
  final double? toLong;
  @override
  final String? status;
  @override
  @JsonKey(name: 'start_date')
  final String? startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  final String? payment;

  @override
  String toString() {
    return 'OrderDTO(id: $id, day: $day, description: $description, regionName: $regionName, from: $from, to: $to, fromLat: $fromLat, fromLong: $fromLong, toLat: $toLat, toLong: $toLong, status: $status, startDate: $startDate, endDate: $endDate, payment: $payment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.day, day) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.regionName, regionName) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality().equals(other.fromLat, fromLat) &&
            const DeepCollectionEquality().equals(other.fromLong, fromLong) &&
            const DeepCollectionEquality().equals(other.toLat, toLat) &&
            const DeepCollectionEquality().equals(other.toLong, toLong) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.endDate, endDate) &&
            const DeepCollectionEquality().equals(other.payment, payment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(day),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(regionName),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(fromLat),
      const DeepCollectionEquality().hash(fromLong),
      const DeepCollectionEquality().hash(toLat),
      const DeepCollectionEquality().hash(toLong),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(endDate),
      const DeepCollectionEquality().hash(payment));

  @JsonKey(ignore: true)
  @override
  _$$_OrderDTOCopyWith<_$_OrderDTO> get copyWith =>
      __$$_OrderDTOCopyWithImpl<_$_OrderDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderDTOToJson(this);
  }
}

abstract class _OrderDTO implements OrderDTO {
  const factory _OrderDTO(
      {required final int id,
      final dynamic day,
      final String? description,
      @JsonKey(name: 'region_name') final String? regionName,
      final String? from,
      final String? to,
      @JsonKey(name: 'from_lat') final double? fromLat,
      @JsonKey(name: 'from_long') final double? fromLong,
      @JsonKey(name: 'to_lat') final double? toLat,
      @JsonKey(name: 'to_long') final double? toLong,
      final String? status,
      @JsonKey(name: 'start_date') final String? startDate,
      @JsonKey(name: 'end_date') final String? endDate,
      final String? payment}) = _$_OrderDTO;

  factory _OrderDTO.fromJson(Map<String, dynamic> json) = _$_OrderDTO.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  dynamic get day => throw _privateConstructorUsedError;
  @override // FIXME
  String? get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'region_name')
  String? get regionName => throw _privateConstructorUsedError;
  @override
  String? get from => throw _privateConstructorUsedError;
  @override
  String? get to => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'from_lat')
  double? get fromLat => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'from_long')
  double? get fromLong => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'to_lat')
  double? get toLat => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'to_long')
  double? get toLong => throw _privateConstructorUsedError;
  @override
  String? get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'start_date')
  String? get startDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  @override
  String? get payment => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OrderDTOCopyWith<_$_OrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
