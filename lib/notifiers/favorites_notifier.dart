import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Meal currentMeal) {
    state = isFavorite(currentMeal)
        ? state.where((meal) => meal.id != currentMeal.id).toList()
        : state = [...state, currentMeal];
  }

  bool isFavorite(Meal meal) => state.any((m) => m.id == meal.id);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>(
  (ref) => FavoritesNotifier(),
);
