import 'package:pks_pr11/api/product_api.dart';
import 'package:pks_pr11/models/cart.dart';
import 'package:pks_pr11/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart_bloc/cart_bloc.dart';
import '../cart_bloc/cart_state.dart';
import '../models/product.dart';
import '../order_bloc/order_bloc.dart';
import '../order_bloc/order_state.dart';
import '../order_bloc/order_event.dart';
import '../widgets/cart_product_card.dart';


class CartPage extends StatelessWidget {
  final ProductApi productApi;

  const CartPage({
    Key? key,
    required this.productApi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, orderState) {
        if (orderState.status == OrderStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Заказ оформлен!')),
          );
        } else if (orderState == OrderStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating order: ${orderState.errorMessage}')),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, orderState) {
              return _buildScaffold(context, cartState.carts, orderState);
            },
          );
        },
      ),
    );
  }

  Future<Product?> getProduct(int productId) async {
    try {
      return await productApi.getProduct(productId);
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  Future<int> calculateTotal(List<Cart> carts) async {
    int total = 0;
    for (var cart in carts) {
      Product? product = await getProduct(cart.productId);
      if (product != null) {
        total += product.price * cart.quantity;
      }
    }
    return total;
  }

  Widget _buildScaffold(BuildContext context, List<Cart> carts, OrderState orderState) {
    return Scaffold(
          bottomSheet: Container(
            // padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<int>(
              future: calculateTotal(carts),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(); // Показать индикатор загрузки
                }
                else {
                  int total = snapshot.data ?? 0;
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Итого: ${total.toStringAsFixed(2)} ₽',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        ElevatedButton(
                          onPressed: orderState.status == OrderStatus.loading
                              ? null
                              : () {
                            context.read<OrderBloc>().add(CreateOrder(carts));
                          },
                          child: orderState.status == OrderStatus.loading
                              ? CircularProgressIndicator()
                              : Text("Оформить заказ", style: TextStyle(color: Colors.teal.shade900),
                        ),
                        ),
                      ],
                    )
                  );
              }
            },

          ),
        ),
        appBar: AppBar(
          title: const Text("Корзина"),
        ),
      body: carts.isEmpty
          ? const Center(child: Text("Корзина пуста"))
          : ListView.builder(
        itemCount: carts.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<Product?>(
            future: getProduct(carts[index].productId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return CartProductCard(
                  product: snapshot.data!,
                  quantity: carts[index].quantity,
                );
              } else {
                return const CircularProgressIndicator(); // Индикатор загрузки
              }
            },
          );
        },
      ),
    );
  }
}