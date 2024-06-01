import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/service/meal_service.dart';
import 'package:flutter_meals/widgets/meal_item.dart';
import 'package:flutter_meals/widgets/progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealService = ref.watch(mealServiceProvider);

    return FutureBuilder<List<Meal>>(
      future: mealService.getMeals(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MealsProgressIndicator();
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const EmptyMealsScreen();
        } else {
          return MealsList(snapshot.data!, title);
        }
      },
    );
  }
}

class MealsList extends StatelessWidget {
  const MealsList(this.meals, this.title, {super.key});

  final List<Meal> meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class EmptyMealsScreen extends StatelessWidget {
  const EmptyMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
  }
}
