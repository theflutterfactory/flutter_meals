import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return meals.isEmpty
        ? Scaffold(
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
          )
        : Scaffold(
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
}
