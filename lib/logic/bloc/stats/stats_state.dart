part of 'stats_bloc.dart';

@immutable
abstract class StatsState extends Equatable {
  StatsState();

  @override
  List<Object> get props => [];
}

/// the state when the statistics have not yet been calculated
class StatsLoadInProgress extends StatsState {}

/// the state when the statistics have been calculated
class StatsLoadSuccess extends StatsState {
  final int numActive;
  final int numCompleted;

  StatsLoadSuccess(this.numActive, this.numCompleted);

  @override
  List<Object> get props => [numActive, numCompleted];
  }

