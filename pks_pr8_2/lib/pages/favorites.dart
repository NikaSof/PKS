import 'package:flutter/material.dart';
import 'package:pks_pr8_2/components/products.dart';
import 'package:pks_pr8_2/models/product.dart';
import 'package:pks_pr8_2/pages/product_card_page.dart';
import '../services/api_service.dart';
import '../main.dart';

class FavoritesPage extends StatefulWidget {

  const FavoritesPage({
    super.key,
  });

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Product> _favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoriteItems = favorite.where((item) => item.favorites).toList();
    });
  }

  void _toggleFavorite(Product item) {
    setState(() {
      item.favorites = !item.favorites;
      if (!item.favorites) {
        favorite.removeWhere((favItem) => favItem.id == item.id);
      } else {
        favorite.add(item);
      }
      _loadFavorites();
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
          "Нет Избранных квасов",
          style: TextStyle(fontSize: 20),
        ),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75, // Adjust as needed
        ),
        itemCount: favorite.length,
        itemBuilder: (BuildContext context, int index) {
          final kvas = favorite[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      prodFuture: ApiService().getProduct(favorite[index].id,
                      ),
                    ),
                  ));
            },
            child: Stack(
              children: [
                ProductCard(
                  item: kvas,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _toggleFavorite(kvas);
                    },
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