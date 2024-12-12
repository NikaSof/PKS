import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart_bloc/cart_bloc.dart';
import '../../cart_bloc/cart_event.dart';
import '../../cart_bloc/cart_state.dart';
import '../../pages/product_related/edit_product_page.dart';
import '../../pages/product_related/product_deletion_dialog.dart';
import '../../product_bloc/product_bloc.dart';
import '../../product_bloc/product_deletion_bloc.dart';
import '../../product_bloc/product_state.dart';
import '../../favorite_bloc/favorite_bloc.dart';
import '../../favorite_bloc/favorite_event.dart';
import '../../favorite_bloc/favorite_state.dart';
import '../../models/product.dart';

class ProductPage extends StatelessWidget {
  final int productId;

  ProductPage({
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final Product currentProduct = state.products.firstWhere((p) => p.productId == productId);
        return _buildScaffold(context, currentProduct);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, Product product) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => EditProductPage(productId: product.productId))),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                )
            ),
            BlocBuilder<ProductDeletionBloc, ProductDeletionState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ProductDeletionDialog(
                          onConfirm: () {
                            context.read<ProductDeletionBloc>().add(DeleteProductEvent(productId: product.productId));
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context).pop(); // Close the product page
                          },
                        ),
                      );
                    },
                  );
                }
            )
          ],
        ),
        body: Stack(
          children: [
            Center(
                child: ListView(
                  children: [
                    Image.network(product.imageUrl),
                    /*
                  Text(
                    product.imageUrl,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),

                   */
                    const SizedBox(height: 20),
                    Text(
                      product.description,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${product.price.toString()} ₽',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<CartBloc, CartState> (
                        builder: (context, state) {
                          final isAdded = state.carts.any((c) => c.productId == product.productId);
                          return ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(AddCartEvent(0, product.productId, 1));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdded ? Colors.white : Colors.blue,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              isAdded ? 'Товар добавлен' : 'Добавить в корзину',
                              style: TextStyle(
                                color: isAdded ? Colors.blue : Colors.white,
                              ),
                            ),
                          );
                        }
                    ),
                    const SizedBox(height: 20),
                  ],
                )
            ),
            Positioned(
              top: 10,
              right: 10,
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFavorite = state.favorites.any((f) => f.productId == product.productId);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(ToggleFavoriteEvent(userId: 0, productId: productId));
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