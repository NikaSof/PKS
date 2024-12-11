import 'package:pks_pr10/api/cart_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cart_event.dart';
import './cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartApi cartApi;

  CartBloc({required this.cartApi}) : super(CartState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddCartEvent>(_onAddCart);
    on<RemoveCartEvent>(_onRemoveCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final carts = await cartApi.getCart(event.userId);
      emit(state.copyWith(
        carts: carts,
        status: CartStatus.success,
        quantity: carts.fold(0, (sum, cart) => sum! + cart.quantity),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddCart(AddCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await cartApi.addToCart(event.userId, event.productId, event.quantity);
      final carts = await cartApi.getCart(event.userId);
      emit(state.copyWith(
        carts: carts,
        status: CartStatus.success,
        quantity: carts.fold(0, (sum, cart) => sum! + cart.quantity),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveCart(RemoveCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await cartApi.removeFromCart(event.userId, event.productId);
      final carts = await cartApi.getCart(event.userId);
      emit(state.copyWith(
        carts: carts,
        status: CartStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
