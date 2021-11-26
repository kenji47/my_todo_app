import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_app/data/repository/todos_repository.dart';
import 'package:my_todo_app/logic/models/todo.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository repository;

  TodosBloc(this.repository) : super(TodosLoadInProgress()) {
    on<TodosLoaded>(_mapTodosLoadedToState);
    on<TodoAdded>(_mapTodoAddedToState);
    on<TodoUpdated>(_mapTodoUpdatedToState);
    on<TodoDeleted>(_mapTodoDeletedToState);
    on<ToggleAllCompleted>(_mapToggleAllToState);
    on<ClearCompleted>(_mapClearCompletedToState);
  }

  /// load all todos
  FutureOr<void> _mapTodosLoadedToState(
      TodosLoaded event, Emitter<TodosState> emit) async {
    try {
      final todos = await repository.loadTodos();
      emit(TodosLoadSuccess(todos: todos));
    } catch (_) {
      emit(TodosLoadFailure());
    }
  }

  /// add todo
  FutureOr<void> _mapTodoAddedToState(
      TodoAdded event, Emitter<TodosState> emit) {
    //todo
    if (state is TodosLoadSuccess) {
      final List<Todo> updatedTodos =
      List.from((state as TodosLoadSuccess).todos)..add(event.todo);
      emit(TodosLoadSuccess(todos: updatedTodos));
      _saveTodos(updatedTodos);
    }
  }

  /// update todo
  FutureOr<void> _mapTodoUpdatedToState(
      TodoUpdated event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final List<Todo> updatedTodos =
      (state as TodosLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(TodosLoadSuccess(todos: updatedTodos));
      _saveTodos(updatedTodos);
    }
  }

  /// delete todo
  FutureOr<void> _mapTodoDeletedToState(
      TodoDeleted event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final updatedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      print('_mapTodoDeletedToState id:${event.todo.id}');
      emit(TodosLoadSuccess(todos: updatedTodos));
      _saveTodos(updatedTodos);
    }
  }

  /// Mark all todo completed. Or if all completed, mark all uncompleted
  FutureOr<void> _mapToggleAllToState(
      ToggleAllCompleted event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      //check if all todos complete
      final allComplete =
      (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      emit(TodosLoadSuccess(todos: updatedTodos));
      _saveTodos(updatedTodos);
    }

  }

  /// Delete completed todo
  FutureOr<void> _mapClearCompletedToState(
      ClearCompleted event, Emitter<TodosState> emit) {
    if (state is TodosLoadSuccess) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      emit(TodosLoadSuccess(todos: updatedTodos));
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return repository.saveTodos(todos);
  }
}
