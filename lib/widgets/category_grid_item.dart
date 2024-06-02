import 'package:flutter/material.dart';
import 'package:flutter_meals/models/category.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () {
            ref.read(mealsTitleProvider.notifier).state = category.title;
            onSelectCategory();
          },
          splashColor: theme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                colors: [
                  category.color.withOpacity(0.55),
                  category.color.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              category.title,
              style: theme.textTheme.titleLarge!,
            ),
          ),
        );
      },
    );
  }
}
