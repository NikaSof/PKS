import 'package:equatable/equatable.dart';
import 'package:pks_pr11/models/order.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final List<Order> orders;
  final OrderStatus status;
  final String? errorMessage;

  const OrderState({
    this.orders = const [],
    this.status = OrderStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [orders, status, errorMessage];

  OrderState copyWith({
    List<Order>? orders,
    OrderStatus? status,
    String? errorMessage,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}