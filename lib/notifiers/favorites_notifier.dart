import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Meal newMeal) {
    state = state.contains(newMeal)
        ? state.where((meal) => meal != newMeal).toList()
        : [...state, newMeal];
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>(
  (ref) => FavoritesNotifier(),
);
