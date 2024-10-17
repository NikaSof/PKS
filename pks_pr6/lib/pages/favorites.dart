import 'package:flutter/material.dart';
import 'package:pks_pr6/model/cart_item.dart';
import 'package:pks_pr6/model/product.dart';
import 'package:pks_pr6/pages/product_card_page.dart';

class FavoritePage extends StatefulWidget {
  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final Function(CartItem) removeCartItem;


  const FavoritePage({
    Key? key,
    required this.favoriteProducts,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.removeCartItem,
  }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: widget.favoriteProducts.isEmpty
          ? const Center(child: Text('Нет избранных карточек'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = widget.favoriteProducts.elementAt(index);
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: product,
                  removeCartItem: widget.removeCartItem,
                  onAddToCart: (item) {
                    widget.onAddToCart(item);
                  },
                  favoriteProducts: widget.favoriteProducts,
                  onFavoriteToggle: (item) {
                    setState(() {
                      widget.onFavoriteToggle(item);
                    });
                  },
                  onDelete: () {
                    setState(() {
                      widget.onFavoriteToggle(product);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4.0),
                            product.discountPrice != null
                                ? Row(
                              children: [
                                Text(
                                  product.price.toStringAsFixed(product.price.truncateToDouble() == product.price ? 0 : 1) + " ₽",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    '${product.discountPrice} ₽',
                                    style: const TextStyle(fontSize: 14.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                                : Text(
                              product.price.toStringAsFixed(product.price.truncateToDouble() == product.price ? 0 : 1) + " ₽",
                              style: const TextStyle(fontSize: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.onFavoriteToggle(product);
                        });
                      },
                      icon: Icon(
                        widget.favoriteProducts.contains(product)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.favoriteProducts.contains(product)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}