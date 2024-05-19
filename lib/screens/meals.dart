import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';

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
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'List is Empty',
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Please select a different category',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(title: Text(title)),
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => Text(
                meals[index].title,
              ),
            ),
          );
  }
}
