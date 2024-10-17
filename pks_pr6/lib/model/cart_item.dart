import 'package:pks_pr6/model/product.dart';

class CartItem extends Product {
  int count;

  CartItem(this.count, {
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.discountPrice,
    required super.imageUrl,
  });
}