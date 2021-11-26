part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent extends Equatable{

  @override
  List<Object> get props => [];
}

/// load todos from repo
class TodosLoaded extends TodosEvent{}

/// addTodo(todo)
class TodoAdded extends TodosEvent{
  final Todo todo;

  TodoAdded(this.todo);

  @override
  List<Object> get props => [todo];
}

/// updateTodo(todo)
class TodoUpdated extends TodosEvent{
  final Todo todo;

  TodoUpdated(this.todo);

  @override
  List<Object> get props => [todo];
}

/// deleteTodo(todo)
class TodoDeleted extends TodosEvent{
  final Todo todo;

  TodoDeleted(this.todo);

  @override
  List<Object> get props => [todo];
}

/// removeCompleted()
class ClearCompleted extends TodosEvent{}

/// mark all completed or, if all completed, mark all uncompleted
class ToggleAllCompleted extends TodosEvent{}
