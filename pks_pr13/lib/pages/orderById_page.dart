import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order.dart';
import 'package:pks_pr11/order_bloc/order_bloc.dart';
import '../order_bloc/order_event.dart';
import '../order_bloc/order_state.dart';
import 'package:pks_pr11/widgets/cart_product_card.dart';

class OrderbyidPage extends StatelessWidget {
  final int orderId;

  OrderbyidPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final order = state.orders.firstWhere(
              (o) => o.orderId == orderId,
          orElse: () => throw Exception('Order not found'),
        );
        return _buildScaffold(context, order);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, Order order) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заказ №${order.orderId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Сумма: ${order.total} ₽', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Статус: ${order.status}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Товары:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: order.products.length,
                itemBuilder: (context, index) {
                  final product = order.products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('${product.price} ₽'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<OrderBloc>().add(CancelOrder(order.orderId ?? 0));
                Navigator.pop(context); // Return to the list of orders
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Отменить заказ'),
            ),
          ],
        ),
      ),
    );
  }
}
