import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/service/meal_service.dart';
import 'package:flutter_meals/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mealService = ref.watch(mealServiceProvider);

    return FutureBuilder<List<Meal>>(
      future: mealService.getMeals(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Scaffold(
            key: ScreenKeys.emptyMealScreenKey,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'List is Empty',
                    style: theme.textTheme.headlineLarge!
                        .copyWith(color: theme.primaryColorLight),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please select a different category',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.primaryColorLight),
                  ),
                ],
              ),
            ),
          );
        } else {
          final meals = snapshot.data!;
          return Scaffold(
            key: ScreenKeys.mealsScreenKey,
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => MealItem(
                meal: meals[index],
                onMealTap: (Meal meal) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MealDetailsSceen(meal: meal),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
