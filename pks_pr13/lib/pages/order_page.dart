import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order.dart';
import '../order_bloc/order_bloc.dart';
import '../order_bloc/order_state.dart';
import '../widgets/order_card.dart';

class OrdersPage extends StatelessWidget {

  const OrdersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return _buildScaffold(context, state.orders);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, List<Order> orders) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваши заказы"),
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Заказов нет"))
          : Stack(
        children: [
          ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(order: orders[index]);
            },
          ),
        ],
      ),
    );
  }
}