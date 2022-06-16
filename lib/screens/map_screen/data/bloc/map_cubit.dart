import 'dart:developer';

import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo_map.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository mapRepository;
  final GlobalRepository _repository;

  MapCubit({
    required this.mapRepository,
    required GlobalRepository repository,
  })  : _repository = repository,
        super(MapInitState());

  Future<void> getMap(int orderId) async {
    try {
      emit(MapLoadingState());
      final List<PointDTO> result = await _repository.orderPoints(orderId);
      emit(MapLoadedState(loadedMap: result));
    } catch (e) {
      log(e.toString());
      emit(MapErrorState(messsage: e.toString()));
    }
  }

  Future<void> changeToMapInitState() async {
    emit(MapInitState());
  }
}
