import 'package:flutter/material.dart';
import 'package:pks_pr8_2/models/product.dart';
import 'package:pks_pr8_2/pages/product_card_page.dart';
import '../services/api_service.dart';
import '../components/products.dart';
import '../main.dart';
import '../models/cart_item.dart';
import 'add_product.dart';

class HomePage extends StatefulWidget {
  List<Product> card;

  HomePage({
    super.key,
    required this.card,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _apiService.getProducts();
      setState(() {
        widget.card = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardPage(items: widget.card, onNoteAdded: (Product newItem) {
        setState(() {
          widget.card.add(newItem);
        });
        Navigator.pop(context);
      })),
    );
  }

  void _deleteNoteConfirmation(BuildContext context, int index) {
    if(widget.card[index].favorites){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Удалить из избранного?'),
            content: const Text('Вы уверены, что хотите удалить этот квас?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.card[index].favorites = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Удалить'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        widget.card[index].favorites = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Страница всех квасов"),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Adjust as needed
        ),
        itemCount: widget.card.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage(prodFuture: _apiService.getProduct(widget.card[index].id))),
                ).then((_) => _fetchProducts()); // Перезапрашиваем данные после возврата
              },
              onLongPress: () {
                _deleteNoteConfirmation(context, index);
              },
              child: Stack(
                children: [
                  ProductCard(item: widget.card[index]),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: carts.any((basketItem) => basketItem.items.id == widget.card[index].id)
                        ? const Icon(Icons.check)
                        : IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Добавление элемента в корзину
                        setState(() {
                          carts.add(CartItem(widget.card[index], 1));
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: widget.card[index].favorites ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.card[index].favorites = !widget.card[index].favorites;
                          widget.card[index].favorites
                              ? favorite.add(widget.card[index])
                              : favorite.removeWhere((i) => i.id == widget.card[index].id);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: const Icon(Icons.add),
        tooltip: 'Добавь квас',
      ),
    );
  }
}