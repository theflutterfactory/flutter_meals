import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/notifiers/favorites_notifier.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/screens/tabs.dart';
import 'package:flutter_meals/service/meal_service.dart';
import 'package:flutter_meals/widgets/meal_item.dart';
import 'package:flutter_meals/widgets/progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key, required this.id});

  // Id of the category to display. If not set, display the list of favorites
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Meal>>(
      future: id.isEmpty
          ? Future.value(ref.watch(favoritesProvider))
          : ref.read(mealServiceProvider).getMeals(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MealsProgressIndicator();
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const EmptyMealsScreen();
        } else {
          return MealsList(snapshot.data!);
        }
      },
    );
  }
}

class MealsList extends ConsumerWidget {
  const MealsList(this.meals, {super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.read(mealsTitleProvider);

    if (title == yourFavoritesTitle) {
      return _mealsListView(meals);
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _mealsListView(meals),
    );
  }

  ListView _mealsListView(List<Meal> meals) => ListView.builder(
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
      );
}

class EmptyMealsScreen extends ConsumerWidget {
  const EmptyMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.read(mealsTitleProvider);

    if (title == yourFavoritesTitle) {
      return _emptyMealsView(Theme.of(context));
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _emptyMealsView(Theme.of(context)),
    );
  }

  Widget _emptyMealsView(ThemeData theme) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'List is Empty',
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 36),
            ),
            const SizedBox(height: 16),
            Text(
              'Please select a different category',
              style: theme.textTheme.bodyLarge!,
            ),
          ],
        ),
      );
}

final mealsTitleProvider = StateProvider<String>((ref) => categoriesTitle);
