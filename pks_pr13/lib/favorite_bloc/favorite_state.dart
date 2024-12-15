import 'package:equatable/equatable.dart';
import '../models/favorite.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  final List<Favorite> favorites;
  final FavoriteStatus status;
  final String? errorMessage;

  const FavoriteState({
    this.favorites = const [],
    this.status = FavoriteStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [favorites, status, errorMessage];

  FavoriteState copyWith({
    List<Favorite>? favorites,
    FavoriteStatus? status,
    String? errorMessage,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}