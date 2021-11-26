part of 'filtered_todos_bloc.dart';

@immutable
abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

/// the state while we are fetching todos
class FilteredTodosLoadInProgress extends FilteredTodosState {}

/// the state when we are no longer fetching todos
class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(
      this.filteredTodos,
      this.activeFilter,
      );

  @override
  List<Object> get props => [filteredTodos, activeFilter];
}
