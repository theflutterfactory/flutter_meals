import 'package:flutter_meals/data/mock_data.dart';
import 'package:flutter_meals/models/filter_options.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealService {
  Future<List<Meal>> getMealsById(String id, FilterOptions options) async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        return dummyMeals.where((meal) {
          if (meal.categories.contains(id)) {
            if (options.isGlutenFree && !meal.isGlutenFree) {
              return false;
            }
            if (options.isVegetarian && !meal.isVegetarian) {
              return false;
            }
            if (options.isVegan && !meal.isVegan) {
              return false;
            }
            if (options.isLactoseFree && !meal.isLactoseFree) {
              return false;
            }
            return true;
          }
          return false;
        }).toList();
      },
    );
  }

  Future<List<Meal>> getAllMeals() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => dummyMeals,
    );
  }
}

final mealServiceProvider = Provider<MealService>((ref) => MealService());
