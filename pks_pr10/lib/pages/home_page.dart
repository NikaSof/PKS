import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../pages/product_related/add_product_page.dart';
import '../product_bloc/product_bloc.dart';
import '../product_bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return _buildScaffold(context, state.products);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, List<Product> products) {
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
      body: products.isEmpty
          ? Stack(
        children: [
          const Center(child: Text("Товаров нет, добавьте новый")),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                width: 60,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      )
          : Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductPage()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                width: 60,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}