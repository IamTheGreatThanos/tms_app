import 'package:europharm_flutter/network/models/dto_models/response/orders_response.dart';

import '../map_model.dart';

abstract class MapState {}

class MapInitState extends MapState{}


class MapLoadingState extends MapState {}


class MapLoadedState extends MapState{
  List<OrderPoint> loadedMap;
  MapLoadedState({required this.loadedMap}) : assert(loadedMap != null);
}

class MapErrorState extends MapState{
  String messsage;
  MapErrorState({required this.messsage}) : assert(messsage != null);
}

class MapLostConnectState extends MapState{}
