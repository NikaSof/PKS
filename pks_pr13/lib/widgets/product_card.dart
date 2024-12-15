import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pks_pr11/cart_bloc/cart_bloc.dart';
import 'package:pks_pr11/cart_bloc/cart_state.dart';
import '../cart_bloc/cart_event.dart';
import '../favorite_bloc/favorite_bloc.dart';
import '../favorite_bloc/favorite_event.dart';
import '../pages/product_related/product_page.dart';
import '../favorite_bloc/favorite_state.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductPage(productId: product.productId)
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            product.price.toStringAsFixed(product.price.truncateToDouble() == product.price ? 0 : 1) + ' ₽',
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<CartBloc, CartState> (
                builder: (context, state) {
                  final isAdded = state.carts.any((c) => c.productId == product.productId);
                  return Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        if (!isAdded) {
                          context.read<CartBloc>().add(AddCartEvent(0, product.productId, 1));
                        }
                      },
                      icon: Icon(
                        isAdded ? Icons.check : Icons.add,
                        color: isAdded ? Colors.green : Colors.grey.shade900,
                      ),
                    ),
                  );
                }
            ),
            Positioned(
              top: 2,
              right: 2,
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFavorite = state.favorites.any((f) => f.productId == product.productId);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(ToggleFavoriteEvent(userId: 0, productId: product.productId));
                    },
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}
