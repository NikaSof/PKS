import 'package:flutter/material.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import '../services/api_service.dart';
import '../components/products.dart';
import '../main.dart';
import 'product_card_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Корзина"),
        ),
      ),
      body: carts.isEmpty
          ? const Center(
        child: Text(
          "Корзина пуста",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      )
          : Center(
        child: ListView.builder(
          itemCount: carts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        _deleteFromBasketConfirmation(context, index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Удалить',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage(prodFuture: ApiService().getProduct(carts[index].items.id)),
                        ));
                  },
                  child: Stack(
                    children: [
                      ProductCard(item: carts[index].items),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (carts[index].count > 0) {
                                    carts[index].count--;
                                  }
                                  if (carts[index].count == 0) {
                                    _deleteFromBasketConfirmation(context, index);
                                  }
                                });
                              },
                            ),
                            Text('${carts[index].count}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  carts[index].count++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _deleteFromBasketConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить из корзины?'),
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
                  carts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}