import 'package:pks_pr11/models/order.dart';
import 'package:flutter/material.dart';

import '../pages/orderById_page.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 150,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  OrderbyidPage(orderId: order.orderId ?? 0)
              ),
            );
          },
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Заказ №${order.orderId}',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Стоимость: ${order.total}',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Статус:  ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text(order.status, style: TextStyle(color: Colors.white, fontSize: 20),))
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}