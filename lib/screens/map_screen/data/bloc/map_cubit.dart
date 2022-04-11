import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../map_model.dart';
import '../repo_map.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository mapRepository;

  MapCubit({required this.mapRepository}) : super(MapInitState());

  Future<void> getMap(int orderId) async {
    try {
      emit(MapLoadingState());
      final MapModel _getmap = await mapRepository.getMap(orderId);
      print(_getmap.toString());
      emit(MapLoadedState(loadedMap: _getmap));
    } catch (e) {
      log(e.toString());
      emit(MapErrorState(messsage: e.toString()));
    }
  }
}
