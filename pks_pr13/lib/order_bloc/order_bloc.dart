import 'package:pks_pr11/api/order_api.dart';
import 'package:pks_pr11/api/product_api.dart';
import 'package:pks_pr11/models/order.dart';
import 'package:pks_pr11/models/product.dart';
import 'package:pks_pr11/order_bloc/order_event.dart';
import 'package:pks_pr11/order_bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderApi _orderApi;
  final ProductApi _productApi;

  OrderBloc(this._orderApi, this._productApi) : super(const OrderState()) {
    on<LoadOrders>(_onLoadOrders);
    on<CreateOrder>(_onCreateOrder);
    on<CancelOrder>(_onCancelOrder);
  }

  Future<void> _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final orders = await _orderApi.getOrders(event.userId);
      emit(state.copyWith(
        status: OrderStatus.success,
        orders: orders,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {

      double total = 0;
      List<Product> productsInTheCart = [];

      for (var cartItem in event.cartItems) {
        try {
          Product thisProduct = await _productApi.getProduct(cartItem.productId);
          total += thisProduct.price * cartItem.quantity;
          productsInTheCart.add(thisProduct);
        } catch (e) {
          emit(state.copyWith(
            status: OrderStatus.failure,
            errorMessage: 'Failed to fetch product: ${cartItem.productId}',
          ));
          return;
        }
      }

      final newOrder = Order(
        orderId: 0,
        userId: 0,
        total: total,
        status: 'В обработке',
        products: productsInTheCart,
      );

      final createdOrder = await _orderApi.createOrder(newOrder);

      final updatedOrders = List<Order>.from(state.orders)..add(createdOrder);

      emit(state.copyWith(
        status: OrderStatus.success,
        orders: updatedOrders,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: 'Failed to create order: ${e.toString()}',
      ));
    }
  }

  Future<void> _onCancelOrder(CancelOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      await _orderApi.cancelOrder(event.orderId);

      final updatedOrders = state.orders
          .where((order) => order.orderId != event.orderId)
          .toList();

      emit(state.copyWith(
        status: OrderStatus.success,
        orders: updatedOrders,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: 'Failed to cancel order: ${e.toString()}',
      ));
    }
  }

}
