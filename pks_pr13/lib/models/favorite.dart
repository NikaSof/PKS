import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final int userId;
  final int productId;

  Favorite({required this.userId, required this.productId});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['user_id'],
      productId: json['product_id'],
    );
  }

  @override
  List<Object> get props => [userId, productId];
}