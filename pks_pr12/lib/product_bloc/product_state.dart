import 'package:equatable/equatable.dart';
import '../models/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final List<Product> products;
  final List<Product> filteredProducts;
  final ProductStatus status;
  final String? errorMessage;
  final String searchQuery;

  const ProductState({
    this.products = const [],
    this.filteredProducts = const [],
    this.status = ProductStatus.initial,
    this.errorMessage,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [products, filteredProducts, status, errorMessage, searchQuery];

  ProductState copyWith({
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    ProductStatus? status,
    String? errorMessage,
    String? searchQuery,
  }) {
    return ProductState(
      products: allProducts ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}