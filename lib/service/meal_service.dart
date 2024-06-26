import 'package:flutter_meals/data/mock_data.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealService {
  Future<List<Meal>> getMealsById(String id) async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => dummyMeals.where((meal) => meal.categories.contains(id)).toList(),
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
