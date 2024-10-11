import 'package:flutter/material.dart';
import 'package:pks_pr5/model/product.dart';
import 'package:pks_pr5/widgets/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onProductDelete;

  FavoriteScreen({
    required this.favoriteProducts,
    required this.onFavoriteToggle,
    required this.onProductDelete
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: favoriteProducts[index],
            onFavoriteToggle: onFavoriteToggle,
            onProductDelete: onProductDelete,
          );
        },
      ),
    );
  }
}