import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int userId;
  final int productId;
  late final int quantity;

  Cart({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        userId: json['user_id'],
        productId: json['product_id'],
        quantity: json['quantity']
    );
  }

  @override
  List<Object> get props => [userId, productId, quantity];
}