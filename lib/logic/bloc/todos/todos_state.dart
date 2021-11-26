part of 'todos_bloc.dart';

@immutable
abstract class TodosState extends Equatable{
  @override
  List<Object> get props => [];
}

/// application is fetching todos from the repository
class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  TodosLoadSuccess({this.todos = const []});

  @override
  List<Object> get props => [todos];
}

class TodosLoadFailure extends TodosState {}
