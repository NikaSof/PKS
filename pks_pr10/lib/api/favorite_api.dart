import 'package:pks_pr10/api/api_service.dart';
import 'package:pks_pr10/models/favorite.dart';

class FavoriteApi {
  final ApiService _apiService;

  FavoriteApi(this._apiService);

  Future<List<Favorite>> getFavorites(int userId) async {
    try {
      final response = await _apiService.dio.get(
          '${_apiService.baseUrl}/favorites/$userId');
      if (response.statusCode == 200) {
        final List<dynamic> favoriteData = response.data;
        return favoriteData.map((json) => Favorite.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      throw Exception('Error getting favorites: $e');
    }
  }

  Future<void> addToFavorites(int userId, int productId) async {
    try {
      final response = await _apiService.dio.post(
        '${_apiService.baseUrl}/favorites/$userId',
        data: {'product_id': productId},
      );
      if (response.statusCode != 200) {
        print('Response data: ${response.data}');
        throw Exception('Failed to add to favorites: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      throw Exception('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(int userId, int productId) async {
    try {
      final response = await _apiService.dio.delete(
        '${_apiService.baseUrl}/favorites/$userId/$productId',
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }

  Future<bool> isFavorite(int userId, int productId) async {
    try {
      final favorites = await getFavorites(userId);
      return favorites.any((f) => f.productId == productId);
    } catch (e) {
      // Handle error or return false if there's an issue
      return false;
    }
  }
}