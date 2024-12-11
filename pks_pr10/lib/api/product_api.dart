import '../models/product.dart';
import 'api_service.dart';

class ProductApi {
  final ApiService _apiService;

  ProductApi(this._apiService);

  // Get all products
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiService.dio.get('${_apiService.baseUrl}/products');
      if (response.statusCode == 200) {
        final List<dynamic> productData = response.data;
        return productData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Get a single product_bloc by ID
  Future<Product> getProduct(int id) async {
    try {
      final response = await _apiService.dio.get('${_apiService.baseUrl}/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception('Product not found');
      } else {
        throw Exception('Failed to load product_bloc');
      }
    } catch (e) {
      throw Exception('Error fetching product_bloc: $e');
    }
  }

  // Create a new product_bloc
  Future<Product> createProduct(Product product) async {
    try {
      final response = await _apiService.dio.post(
        '${_apiService.baseUrl}/products',
        data: product.toJson(),
      );
      if (response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to create product_bloc');
      }
    } catch (e) {
      throw Exception('Error creating product_bloc: $e');
    }
  }

  // Update an existing product_bloc
  Future<Product> updateProduct(Product product) async {
    try {
      final response = await _apiService.dio.put(
        '${_apiService.baseUrl}/products/${product.productId}',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to update product_bloc');
      }
    } catch (e) {
      throw Exception('Error updating product_bloc: $e');
    }
  }

  // Delete a product_bloc
  Future<void> deleteProduct(int id) async {
    try {
      final response = await _apiService.dio.delete('${_apiService.baseUrl}/products/$id');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product_bloc');
      }
    } catch (e) {
      throw Exception('Error deleting product_bloc: $e');
    }
  }
}