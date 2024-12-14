import 'package:equatable/equatable.dart';
import '../models/cart.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final List<Cart> carts;
  final int quantity;
  final CartStatus status;
  final String? errorMessage;

  const CartState({
    this.carts = const [],
    this.quantity = 0,
    this.status = CartStatus.initial,
    this.errorMessage
  });

  @override
  List<Object?> get props => [carts, quantity, status, errorMessage];

  CartState copyWith({
    final List<Cart>? carts,
    final int? quantity,
    final CartStatus? status,
    final String? errorMessage,
  }) {
    return CartState(
        carts: carts ?? this.carts,
        quantity: quantity ?? this.quantity,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }
}