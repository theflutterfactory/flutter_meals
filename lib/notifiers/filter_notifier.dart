import 'package:flutter_meals/models/filter_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<FilterOptions> {
  FilterNotifier({FilterOptions? state}) : super(state ?? FilterOptions());

  void updateGlutenFree(bool isGlutenFree) {
    state = state.copyWith(isGlutenFree: isGlutenFree);
  }

  void updateVegetarian(bool isVegetarian) {
    state = state.copyWith(isVegetarian: isVegetarian);
  }

  void updateVegan(bool isVegan) {
    state = state.copyWith(isVegan: isVegan);
  }

  void updateLactoseFree(bool isLactoseFree) {
    state = state.copyWith(isLactoseFree: isLactoseFree);
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, FilterOptions>(
  (ref) => FilterNotifier(),
);
