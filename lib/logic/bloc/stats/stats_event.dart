part of 'stats_bloc.dart';

@immutable
abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

/// This event will be added whenever the TodosBloc state changes
/// so that our StatsBloc can recalculate the new statistics.
class StatsUpdated extends StatsEvent {
  final List<Todo> todos;

  const StatsUpdated(this.todos);

  @override
  List<Object> get props => [todos];

}
