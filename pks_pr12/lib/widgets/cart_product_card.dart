import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart_bloc/cart_bloc.dart';
import '../cart_bloc/cart_event.dart';
import '../models/product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // print('Removing product with id: ${product.productId}');
                context.read<CartBloc>().add(RemoveCartEvent(0, product.productId));
              },
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
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${product.price} ₽ x $quantity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      context.read<CartBloc>().add(AddCartEvent(0, product.productId, -1));
                    }
                  },
                ),
                Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.read<CartBloc>().add(AddCartEvent(0, product.productId, 1));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
