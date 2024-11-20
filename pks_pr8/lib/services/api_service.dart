import 'package:dio/dio.dart';
import 'package:pks_pr8/models/product.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://172.16.0.2:8080/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Product> products = data.map((product) => Product.fromJson(product)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e'); // Логирование ошибки
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> getProduct(int ID) async {
    try {
      final response = await _dio.get('http://172.16.0.2:8080/products/$ID');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Failed to load data: $e'); // Логирование ошибки
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> addProductToServer(Product newProduct) async {
    try {
      final response = await _dio.post('http://172.16.0.2:8080/products/create', data: {
        'id': newProduct.id,
        'name': newProduct.name,
        'description': newProduct.description,
        'image_url': newProduct.imageUrl,
      });
      if (response.statusCode == 200) {
        print('Product added successfully');
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(int id) async{
    try{
      final response = await _dio.delete('http://172.16.0.2:8080/products/delete/$id');
      if (response.statusCode == 200){
        print('kaif!');
      }else{
        throw Exception('Failed to delete');
      }
    }catch(e){
      print('Error delete $e');
      throw Exception('Error delete $e');
    }
  }

  Future<void> updateProduct(Product item) async {
    try {
      final response = await _dio.put('http://172.16.0.2:8080/products/update/${item.id}', data: {
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'image_url': item.imageUrl,
      });
      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Error updating product: $e');
    }
  }
}
