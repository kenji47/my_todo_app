part of 'app_tab_bloc.dart';

@immutable
abstract class AppTabEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AppTabUpdated extends AppTabEvent{
  final AppTab tab;

  AppTabUpdated(this.tab);

  @override
  List<Object> get props => [tab];
}

