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
