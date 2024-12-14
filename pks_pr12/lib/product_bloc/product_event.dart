import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final int productId;
  final String name;
  final String imageUrl;
  final String description;
  final int price;
  final int stock;

  const AddProductEvent({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.stock,
  });

  @override
  List<Object> get props => [
    productId,
    name,
    imageUrl,
    description,
    price,
    stock
  ];
}

class EditProductEvent extends ProductEvent {
  final int productId;
  final String name;
  final String imageUrl;
  final String description;
  final int price;
  final int stock;

  const EditProductEvent({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.stock,
  });

  @override
  List<Object> get props => [
    productId,
    name,
    imageUrl,
    description,
    price,
    stock
  ];
}

class RemoveProductEvent extends ProductEvent {
  final int productId;

  const RemoveProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object> get props => [query];
}