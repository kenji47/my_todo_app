part of 'filtered_todos_bloc.dart';

@immutable
abstract class FilteredTodosEvent extends Equatable{
  @override
  List<Object> get props => [];
}

/// updateVisibilityFilter(filter). Visibility filter has changed
class FilterUpdated extends FilteredTodosEvent {
  final VisibilityFilter visibilityFilter;

  FilterUpdated(this.visibilityFilter);

  @override
  List<Object> get props => [visibilityFilter];
}

/// todosUpdated(todos). List of todos has changed
class TodosUpdated extends FilteredTodosEvent{
  final List<Todo> todos; //todo

  TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

}
