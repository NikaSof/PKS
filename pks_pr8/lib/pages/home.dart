import 'package:flutter/material.dart';
import 'package:pks_pr8/models/product.dart';
import 'package:pks_pr8/pages/product_card_page.dart';
import '../services/api_service.dart';
import '../models/cart_item.dart';
import '../main.dart';
import '../components/products.dart';

class HomePage extends StatefulWidget {
  final List<Product> products;

  const HomePage({super.key, required this.products});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void toggleFavorite(Product item) {
    setState(() {
      item.favorites = !item.favorites;
      if (item.favorites) {
        favorite.add(item);
      } else {
        favorite.removeWhere((favItem) => favItem.id == item.id);
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      final existingItem =
      carts.indexWhere((cartItem) => cartItem.items.id == product.id);
      if (existingItem == -1) {
        carts.add(CartItem(product, 1));
      } else {
        carts[existingItem].count++;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} добавлен в корзину')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: widget.products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = widget.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    prodFuture: ApiService().getProduct(product.id),
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                ProductCard(item: product),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: carts.any((cartItem) =>
                        cartItem.items.id == widget.products[index].id)
                            ? const Icon(Icons.check)
                            : const Icon(Icons.add),
                        onPressed: () => addToCart(product),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: product.favorites ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => toggleFavorite(product),
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
