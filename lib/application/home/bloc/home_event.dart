part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends HomeEvent {
  String filter;

  GetProductList({required this.filter});

  @override
  List<Object> get props => [filter];
}

class GetSearchList extends HomeEvent {
  String filter;

  GetSearchList({required this.filter});

  @override
  List<Object> get probs => [filter];
}

class LoadingMore extends HomeEvent {
  String filter;

  LoadingMore({required this.filter});

  @override
  List<Object> get probs => [filter];
}
