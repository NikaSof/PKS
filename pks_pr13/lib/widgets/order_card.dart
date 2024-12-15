import 'package:flutter/material.dart';
import 'package:pks_pr11/models/order.dart';

import '../pages/orderById_page.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderbyidPage(orderId: order.orderId ?? 0),
          ),
        );
      },
      child: Card(
        elevation: 5, // Добавляем тень
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Отступы
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Скругленные углы
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Тень
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16), // Внутренние отступы
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Заказ №${order.orderId}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Выделяем жирным
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Стоимость: ${order.total} ₽',
                  style: const TextStyle(
                    color: Colors.black54, // Серый цвет для деталей
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Статус: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10), // Отступы внутри контейнера
                      decoration: BoxDecoration(
                        color: _getStatusColor(order.status), // Динамический цвет статуса
                        borderRadius: BorderRadius.circular(20), // Скругленные края
                      ),
                      child: Text(
                        order.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Возвращает цвет статуса в зависимости от его значения
  Color _getStatusColor(String status) {
    switch (status) {
      case 'В обработке':
        return Colors.orange;
      case 'Отменён':
        return Colors.red;
      case 'Завершён':
        return Colors.green;
      default:
        return Colors.blueAccent;
    }
  }
}
