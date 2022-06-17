part of 'point_page_bloc.dart';

@immutable
abstract class PointPageEvent {}

class PointPageEventLoadProducts extends PointPageEvent {
  final int pointId;

  PointPageEventLoadProducts({
    required this.pointId,
  });
}

class PointPageEventProductFinish extends PointPageEvent {
  final int productId;
  final String code;

  PointPageEventProductFinish({
    required this.productId,
    required this.code,
  });
}

class PointPageEventFinishingPoint extends PointPageEvent {
  final int pointId;

  PointPageEventFinishingPoint({
    required this.pointId,
  });
}
