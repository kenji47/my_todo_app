import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_app/logic/bloc/todos/todos_bloc.dart';
import 'package:my_todo_app/logic/models/todo.dart';
import 'package:my_todo_app/logic/models/visibility_filter.dart';

part 'filtered_todos_event.dart';

part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  late StreamSubscription todosSubscription;

  FilteredTodosBloc(this.todosBloc)
      : super(todosBloc is TodosLoadSuccess
            ? FilteredTodosLoadSuccess(
                (todosBloc.state as TodosLoadSuccess).todos,
                VisibilityFilter.all,
              )
            : FilteredTodosLoadInProgress()) {
    on<FilterUpdated>(_mapFilterUpdatedToState);
    on<TodosUpdated>(_mapTodosUpdatedToState);

    todosSubscription = todosBloc.stream.listen((todoState) {
      if (todoState is TodosLoadSuccess) {
        add(TodosUpdated(todoState.todos));
      }
    });
  }

  /// Take todos from TodoBloc and filter them
  FutureOr<void> _mapFilterUpdatedToState(
      FilterUpdated event, Emitter<FilteredTodosState> emit) {
    if (todosBloc.state is TodosLoadSuccess) {
      final todos = (todosBloc.state as TodosLoadSuccess).todos;
      final filteredTodos =
          _mapTodosToFilteredTodos(todos, event.visibilityFilter);
      emit(FilteredTodosLoadSuccess(filteredTodos, event.visibilityFilter));
    }
  }

  /// Filter todos when list of todos changed.
  FutureOr<void> _mapTodosUpdatedToState(
      TodosUpdated event, Emitter<FilteredTodosState> emit) {
    // if init state was FilteredTodosLoadInProgress set visibilty to all
    // else takse visibility from Status
    final visibility = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.all;
    final todos = (todosBloc.state as TodosLoadSuccess).todos;
    final filteredTodos = _mapTodosToFilteredTodos(todos, visibility);
    emit(FilteredTodosLoadSuccess(filteredTodos, visibility));
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
