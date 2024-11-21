import 'package:flutter/material.dart';
import 'package:pks_pr8/models/product.dart';
import '../main.dart';
import '../components/products.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _removeFavorite(Product item) {
    setState(() {
      item.favorites = false;
      favorite.removeWhere((favItem) => favItem.id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favorite.isEmpty
          ? const Center(
        child: Text(
          'Нет избранных товаров',
          style: TextStyle(fontSize: 20),
        ),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: favorite.length,
        itemBuilder: (BuildContext context, int index) {
          final item = favorite[index];
          return GestureDetector(
            child: Stack(
              children: [
                ProductCard(item: item),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _removeFavorite(item),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
