import 'package:bloc/bloc.dart';
import 'package:brandpoint/application/cart/service/cart_service.dart';
import 'package:brandpoint/models/cart_item.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService;
  CartBloc(CartService cartService)
      : _cartService = cartService,
        super(CartInitial()) {
    on<CartLoadingEvent>(_cartLoading);
    on<CartLoadingMoreEvent>(_loadingMore);
  }

  Future<void> _cartLoading(
      CartLoadingEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    var response = await _cartService.getCart();
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        cart.addAll(response.body);

        emit(CartLoaded(cartList: cart));
      } else {
        emit(CartEmpty());
      }
    } else {
      emit(CartFailureLoading());
    }
  }

  Future<void> _loadingMore(
      CartLoadingMoreEvent event, Emitter<CartState> emit) async {
    var response = await _cartService.getCart();
    if (response.statusCode == 200) {
      cart.addAll(response.body);
      emit(CartLoaded(cartList: cart));
    } else {
      emit(CartFailureLoading());
    }
  }
}
