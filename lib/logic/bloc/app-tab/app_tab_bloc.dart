import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_app/logic/models/app_tab.dart';

part 'app_tab_event.dart';

class AppTabBloc extends Bloc<AppTabEvent, AppTab> {
  AppTabBloc() : super(AppTab.todos) {

    on<AppTabUpdated>((event, emit) {
      emit(event.tab);
    });
  }
}
