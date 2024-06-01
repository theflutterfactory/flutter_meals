import 'package:flutter/material.dart';
import 'package:flutter_meals/data/mock_data.dart';
import 'package:flutter_meals/models/category.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_meals/widgets/category_grid_item.dart';

const gridSpacing = 16.0;

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MealsScreen(
          title: category.title,
          id: category.id,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a category'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: gridSpacing,
          mainAxisSpacing: gridSpacing,
        ),
        itemCount: availableCategories.length,
        itemBuilder: (context, index) {
          final category = availableCategories[index];
          return CategoryGridItem(
            onSelectCategory: () => _selectCategory(context, category),
            category: category,
          );
        },
      ),
    );
  }
}
