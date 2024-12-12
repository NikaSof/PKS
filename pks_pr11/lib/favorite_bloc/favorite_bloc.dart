import 'package:pks_pr11/api/favorite_api.dart';
import 'package:pks_pr11/models/favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteApi favoriteApi;

  FavoriteBloc({required this.favoriteApi}) : super(FavoriteState(favorites: [])) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final loadedFavorites = await favoriteApi.getFavorites(event.userId);
      emit(state.copyWith(
          status: FavoriteStatus.success,
          favorites: loadedFavorites
      ));
    } catch (e) {
      emit(state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: e.toString()
      ));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final isFavorite = state.favorites.any((f) => f.productId == event.productId);
      if (isFavorite) {
        await favoriteApi.removeFromFavorites(event.userId, event.productId);
        final updatedFavorites = state.favorites.where((f) => f.productId != event.productId).toList();
        emit(state.copyWith(
            favorites: updatedFavorites,
            status: FavoriteStatus.success
        ));
      } else {
        final newFavorite = Favorite(
          userId: 0,
          productId: event.productId,
        );
        await favoriteApi.addToFavorites(event.userId, event.productId);
        emit(state.copyWith(
          favorites: [...state.favorites, newFavorite],
          status: FavoriteStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: e.toString()
      ));
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      await favoriteApi.removeFromFavorites(event.userId, event.productId);
      final updatedFavorites = state.favorites.where((f) => f.productId != event.productId).toList();
      emit(state.copyWith(
          favorites: updatedFavorites,
          status: FavoriteStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: e.toString()
      ));
    }
  }
}