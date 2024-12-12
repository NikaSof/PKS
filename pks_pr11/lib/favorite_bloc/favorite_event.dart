import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoriteEvent {
  final int userId;

  const LoadFavoritesEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final int userId;
  final int productId;

  const ToggleFavoriteEvent({required this.userId, required this.productId});

  @override
  List<Object> get props => [userId, productId];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final int userId;
  final int productId;

  const RemoveFavoriteEvent({required this.userId, required this.productId});

  @override
  List<Object> get props => [userId, productId];
}