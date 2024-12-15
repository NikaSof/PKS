import 'package:pks_pr11/api/api_service.dart';
import 'package:pks_pr11/models/cart.dart';

class CartApi {
  final ApiService _apiService;

  CartApi(this._apiService);

  Future<List<Cart>> getCart(int userId) async {
    try {
      final response = await _apiService.dio.get('${_apiService.baseUrl}/carts/$userId');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Cart.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addToCart(int userId, int productId, int quantity) async {
    try {
      final response = await _apiService.dio.post(
        '${_apiService.baseUrl}/carts/$userId',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> removeFromCart(int userId, int productId) async {
    try {
      final response = await _apiService.dio.delete(
        '${_apiService.baseUrl}/carts/$userId/$productId',
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove item from cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}