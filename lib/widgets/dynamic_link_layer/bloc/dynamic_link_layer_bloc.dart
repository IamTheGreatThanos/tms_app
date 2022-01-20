import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:europharm_flutter/managers/dynamic_link_manager.dart';
import 'package:europharm_flutter/network/repository/hive_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

part 'dynamic_link_layer_event.dart';

part 'dynamic_link_layer_state.dart';

class DynamicLinkLayerBloc
    extends Bloc<DynamicLinkLayerEvent, DynamicLinkLayerState> {
  Uri? _link;
  bool isAuthorized;
  final HiveRepository _hiveRepository;
  final DynamicLinkManager _firebaseDynamicLinks;

  DynamicLinkLayerBloc(
      this._hiveRepository, this._firebaseDynamicLinks, this.isAuthorized)
      : super(DynamicLinkLayerInitial()) {
    on<InitialDynamicLinkLayerEvent>(
        (event, emit) => _buildInitialEvent(event, emit));
  }

  _buildInitialEvent(InitialDynamicLinkLayerEvent event,
      Emitter<DynamicLinkLayerState> emit) async {
    if (isAuthorized) {
      emit(AuthorizedState());
    } else {
      emit(NotAuthorizedState());
    }
  }
}
