part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  List<CartItem> cartList;

  CartLoaded({required this.cartList});

  @override
  List<Object> get props => [cartList];
}

class CartFailureLoading extends CartState {}

class CartEmpty extends CartState {}
