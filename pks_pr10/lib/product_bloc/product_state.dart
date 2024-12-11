import 'package:equatable/equatable.dart';
import '../models/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final List<Product> products;
  final ProductStatus status;
  final String? errorMessage;

  const ProductState({
    this.products = const [],
    this.status = ProductStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [products, status, errorMessage];

  ProductState copyWith({
    List<Product>? products,
    ProductStatus? status,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}