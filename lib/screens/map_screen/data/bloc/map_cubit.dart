import 'dart:developer';

import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo_map.dart';
import 'map_state.dart';

const _tag = 'MapCubit';

class MapCubit extends Cubit<MapState> {
  final MapRepository mapRepository;
  final GlobalRepository _repository;

  MapCubit({
    required this.mapRepository,
    required GlobalRepository repository,
  })  : _repository = repository,
        super(MapInitState());

  Future<void> getMap({
    required int orderId,
    required List<PointDTO> orderPoints,
  }) async {
    try {
      emit(MapLoadingState());

      if (orderPoints.isEmpty) {
        final List<PointDTO> result = await _repository.orderPoints(orderId);
        log('wasvdbbsdbsb');
        emit(MapLoadedState(loadedMap: result));
      } else {
        emit(MapLoadedState(loadedMap: orderPoints));
      }
    } catch (e) {
      log(e.toString(), name: _tag);
      emit(MapErrorState(messsage: e.toString()));
    }
  }

  Future<void> changeToMapInitState() async {
    emit(MapInitState());
  }

  @override
  void onChange(Change<MapState> change) {
    log('$change', name: _tag);
    super.onChange(change);
  }
}
