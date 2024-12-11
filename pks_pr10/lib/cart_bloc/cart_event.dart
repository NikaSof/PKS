import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {
  final int userId;

  const LoadCartEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddCartEvent extends CartEvent {
  final int userId;
  final int productId;
  final int quantity;

  const AddCartEvent(this.userId, this.productId, this.quantity);

  @override
  List<Object> get props => [userId, productId, quantity];
}

class RemoveCartEvent extends CartEvent {
  final int userId;
  final int productId;

  const RemoveCartEvent(this.userId, this.productId,);

  @override
  List<Object> get props => [userId, productId,];
}