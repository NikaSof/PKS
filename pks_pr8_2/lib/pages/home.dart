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
  bool _isLoading = false;
  bool _showReloadButton = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _showReloadButton = false;
    });

    // Таймер для отображения кнопки перезагрузки
    Future.delayed(const Duration(seconds: 3), () {
      if (_isLoading) {
        setState(() {
          _showReloadButton = true;
        });
      }
    });

    try {
      final products = await _apiService.getProducts();
      setState(() {
        widget.card = products;
        _isLoading = false;
        _showReloadButton = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
        _showReloadButton = true;
      });
    }
  }

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardPage(
          items: widget.card,
          onNoteAdded: (Product newItem) {
            setState(() {
              widget.card.add(newItem);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _deleteNoteConfirmation(BuildContext context, int index) {
    if (widget.card[index].favorites) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Удалить из избранного?'),
            content: const Text('Вы уверены, что хотите удалить этот товар?'),
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
        title: Center(child: Text(
          'Vintage Click',
          style: TextStyle(
            color: Colors.teal.shade900,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        ),
      ),
      body: Stack(
        children: [
          // Основной контент (сетка продуктов)
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: widget.card.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          prodFuture: _apiService.getProduct(widget.card[index].id),
                        ),
                      ),
                    ).then((_) => _fetchProducts());
                  },
                  onLongPress: () {
                    _deleteNoteConfirmation(context, index);
                  },
                  child: Stack(
                    children: [
                      ProductCard(item: widget.card[index]),
                      Positioned(
                        bottom: 2,
                        right: 10,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: carts.any((cartItem) => cartItem.items.id == widget.card[index].id)
                                ? const Icon(Icons.check)
                                : IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  carts.add(CartItem(widget.card[index], 1));
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              widget.card[index].favorites = !widget.card[index].favorites;
                                       widget.card[index].favorites
                                           ? favorite.add(widget.card[index])
                                           : favorite.removeWhere((i) => i.id == widget.card[index].id);
                            });
                          },
                          icon: Icon(
                            widget.card[index].favorites
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.card[index].favorites
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
          if (_isLoading || _showReloadButton)
            Center(
              child: _showReloadButton
                  ? ElevatedButton(
                onPressed: _fetchProducts,
                child: const Text("Перезагрузить"),
              )
                  : const CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: const Icon(Icons.add),
        tooltip: 'Добавь',
      ),
    );
  }
}
