import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_app/logic/bloc/todos/todos_bloc.dart';
import 'package:my_todo_app/logic/models/todo.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  late StreamSubscription todosSubscription;

  StatsBloc(this.todosBloc) : super(StatsLoadInProgress()) {

    on<StatsUpdated>(_mapStatsUpdatedToState);

    _onTodosStateChanged(todosBloc.state);
    /// whenever the TodosBloc state changes recalculate the new statistics.
    todosSubscription = todosBloc.stream.listen(_onTodosStateChanged);
  }

  void _onTodosStateChanged(state) {
    if (state is TodosLoadSuccess) {
      add(StatsUpdated(state.todos));
    }
  }
  /// take todos list from event, calculate statistic and emit it StatsLoadSuccess()
  FutureOr<void> _mapStatsUpdatedToState(StatsUpdated event, Emitter<StatsState> emit) {
    if (event is StatsUpdated) {
      final numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      final numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      emit(StatsLoadSuccess(numActive, numCompleted));
    }
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
