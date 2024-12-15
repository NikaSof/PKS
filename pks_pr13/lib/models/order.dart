import 'package:equatable/equatable.dart';
import 'package:pks_pr11/models/product.dart';

class Order extends Equatable {
  final int? orderId;
  final int userId;
  late final double total;
  final String status;
  final List<Product> products;

  Order({
    required this.orderId,
    required this.userId,
    required this.total,
    required this.status,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      userId: json['user_id'],
      total: json['total'].toDouble(),
      status: json['status'],
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total': total,
      'status': status,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [userId, total, status, products];
}

class OrderProduct {
  final int productId;
  final String name;
  final double price;
  final int quantity;

  OrderProduct({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json['productId'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

// class Order {
//   final int orderId;
//   final int userId;
//   final double total;
//   final String status; // Например, "В обработке", "Отменен"
//   final List<OrderProduct> products;
//
//   Order({
//     required this.orderId,
//     required this.userId,
//     required this.total,
//     required this.status,
//     required this.products,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       orderId: json['orderId'],
//       userId: json['userId'],
//       total: json['total'].toDouble(),
//       status: json['status'],
//       products: (json['products'] as List)
//           .map((productJson) => OrderProduct.fromJson(productJson))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'orderId': orderId,
//       'userId': userId,
//       'total': total,
//       'status': status,
//       'products': products.map((product) => product.toJson()).toList(),
//     };
//   }
// }
//
// class OrderProduct {
//   final int productId;
//   final String name;
//   final double price;
//   final int quantity;
//
//   OrderProduct({
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });
//
//   factory OrderProduct.fromJson(Map<String, dynamic> json) {
//     return OrderProduct(
//       productId: json['productId'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//       quantity: json['quantity'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'productId': productId,
//       'name': name,
//       'price': price,
//       'quantity': quantity,
//     };
//   }
// }
