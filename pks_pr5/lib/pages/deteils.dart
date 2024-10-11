import 'package:flutter/material.dart';
import 'package:pks_pr5/model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final Function(Product) onProductDelete;

  ProductDetailScreen({required this.product, required this.onProductDelete});

  void _deleteProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Удаление'),
        content: Text('Вы уверены, что хотите удалить этот товар?'),
        actions: <Widget>[
          TextButton(
            child: Text('Нет'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Да'),
            onPressed: () {
              onProductDelete(product);  // Удаление продукта из общего списка
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();  // Возвращение на предыдущий экран
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.price,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            if (product.discountPrice.isNotEmpty)
              Text(
                product.discountPrice,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: product.description.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(product.description[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _deleteProduct(context),
              child: Text('Удалить'),
            ),
          ],
        ),
      ),
    );
  }
}