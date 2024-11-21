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
  void _deleteFromCart(int index) {
    setState(() {
      carts.removeAt(index);
    });
  }

  void _updateItemCount(int index, int change) {
    setState(() {
      carts[index].count += change;
      if (carts[index].count <= 0) {
        carts.removeAt(index);
      }
    });
  }

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
          : ListView.builder(
        itemCount: carts.length,
        itemBuilder: (BuildContext context, int index) {
          final cartItem = carts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => _deleteFromCart(index),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Удалить',
                  ),
                ],
              ),
              child: Card(
                elevation: 3,
                child: ListTile(
                  leading: Image.network(
                    cartItem.items.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(cartItem.items.name),
                  subtitle: Text(
                    '${cartItem.items.price} ₽ x ${cartItem.count}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _updateItemCount(index, -1),
                      ),
                      Text('${cartItem.count}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _updateItemCount(index, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: carts.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итого: ${carts.fold(0, (total, item) => total + (item.items.price * item.count).toInt())} ₽',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Заказ оформлен'),
                  ),
                );

              },
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
