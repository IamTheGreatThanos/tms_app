import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/read.dart';

class BlocDocumentsScreen extends Bloc<EventBlocDocumentsScreen, StateBlocDocumentsScreen> {
  BlocDocumentsScreen() : super(StateLoadingDocumentsScreen()) {
    on<EventInitialDocumentsScreen>(_read);
  }
}
