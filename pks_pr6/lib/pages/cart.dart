import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pks_pr6/model/cart_item.dart';

class CartPage extends StatefulWidget {
  final Set<CartItem> cartItems;
  final Function(CartItem) removeCartItem;

  const CartPage({Key? key, required this.cartItems, required this.removeCartItem}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  double calculateTotal() {
    return widget.cartItems.fold(0, (sum, item) => sum + (item.price * item.count));
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();

    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итого: ${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 1)} ₽',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Корзина')),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('В корзине ничего нет'))
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = widget.cartItems.elementAt(index);
          final cartItemPrice = cartItem.price * cartItem.count;
          final cartItemFinalPrice = cartItemPrice.toStringAsFixed(cartItemPrice.truncateToDouble() == cartItemPrice ? 0 : 1);

          return Slidable(
            key: Key(cartItem.name),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.3,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      widget.removeCartItem(cartItem);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${cartItem.name} удален из корзины'),
                      ),
                    );
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Удалить',
                ),
              ],
            ),
            child: ListTile(
              leading: Image.network(cartItem.imageUrl),
              title: Text(cartItem.name),
              subtitle: Text(
                'Цена: $cartItemFinalPrice ₽',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (cartItem.count > 1) {
                          cartItem.count--;
                        } else {
                          widget.removeCartItem(cartItem);
                        }
                      });
                    },
                  ),
                  Text(
                    '${cartItem.count}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cartItem.count++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
