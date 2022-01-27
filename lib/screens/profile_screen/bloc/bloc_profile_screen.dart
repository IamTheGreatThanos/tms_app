import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ProfileScreenBloc() : super(ProfileScreenInitial()) {
    on<ProfileScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
