import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/notifiers/favorites_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsSceen extends StatelessWidget {
  const MealDetailsSceen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                key: IconButtonKeys.favoriteIconButtonKey,
                onPressed: () =>
                    ref.read(favoritesProvider.notifier).toggleFavorite(meal),
                icon: ref.watch(favoritesProvider).contains(meal)
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(ingredient),
              ),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
