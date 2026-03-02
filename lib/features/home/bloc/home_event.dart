import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends HomeEvent {}

class HomeCategorySelected extends HomeEvent {
  final int index;

  const HomeCategorySelected(this.index);

  @override
  List<Object> get props => [index];
}

class HomeSearchQueryChanged extends HomeEvent {
  final String query;

  const HomeSearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class HomeBottomNavIndexChanged extends HomeEvent {
  final int index;

  const HomeBottomNavIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}
