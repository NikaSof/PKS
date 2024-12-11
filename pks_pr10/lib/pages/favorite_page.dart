import 'package:pks_pr10/api/product_api.dart';
import 'package:pks_pr10/models/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../favorite_bloc/favorite_bloc.dart';
import '../favorite_bloc/favorite_state.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class FavoritePage extends StatelessWidget {
  final ProductApi productApi;

  const FavoritePage({
    Key? key,
    required this.productApi
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return _buildScaffold(context, state.favorites);
      },
    );
  }

  Future<Product?> getProduct(int productId) async {
    try {
      // Fetch the product from your repository or API
      return await productApi.getProduct(productId);
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }


  Widget _buildScaffold(BuildContext context, List<Favorite> favorites) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Избранное"),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("Избранных товаров нет"))
          : BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final favoriteList = state.favorites;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: favoriteList.length,
            itemBuilder: (BuildContext context, int index) {
              return FutureBuilder<Product?>(
                future: getProduct(state.favorites[index].productId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading product'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ProductCard(product: snapshot.data!);
                  } else {
                    return const Center(child: Text('Product not found'));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}