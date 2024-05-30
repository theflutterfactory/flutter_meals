import 'package:flutter/material.dart';
import 'package:flutter_meals/models/meal.dart';

class MealDetailsSceen extends StatelessWidget {
  const MealDetailsSceen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: Center(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Text(meal.title),
            Text(meal.complexity.toString()),
            Text(meal.affordability.toString()),
          ],
        ),
      ),
    );
  }
}
