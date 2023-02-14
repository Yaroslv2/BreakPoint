part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadingEvent extends CartEvent {}

class CartLoadingMoreEvent extends CartEvent {}

class CartBuyEvent extends CartEvent {}

class CartDeleteElementEvent extends CartEvent {}
