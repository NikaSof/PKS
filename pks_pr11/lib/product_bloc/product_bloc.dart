import 'package:pks_pr11/api/product_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../product_bloc/product_event.dart';
import '../product_bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApi productApi;

  ProductBloc({required this.productApi}) : super(const ProductState()) {
    on<AddProductEvent>(_onAddProduct);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<EditProductEvent>(_onEditProduct);
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await productApi.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final product = Product(
        productId: DateTime.now().millisecondsSinceEpoch,
        name: event.name,
        imageUrl: event.imageUrl,
        description: event.description,
        price: event.price,
        stock: event.stock,
      );
      await productApi.createProduct(product);
      final updatedProducts = await productApi.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: updatedProducts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onEditProduct(EditProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final product = Product(
        productId: event.productId,
        name: event.name,
        imageUrl: event.imageUrl,
        description: event.description,
        price: event.price,
        stock: event.stock,
      );
      await productApi.updateProduct(product);
      final updatedProducts = await productApi.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: updatedProducts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveProduct(RemoveProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      await productApi.deleteProduct(event.productId);
      final updatedProducts = await productApi.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: updatedProducts,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}