import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/main.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_meals/widgets/category_grid_item.dart';
import 'package:flutter_meals/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  testWidgets('Navigates to MealsScreen on category grid item tap',
      (tester) async {
    await mockNetworkImages(() async {
      await navigateToMealsScreen(tester);
    });
  });

  testWidgets('Navigates to MealDetailsScreen on meal item tap',
      (tester) async {
    await mockNetworkImages(() async {
      await navigateToMealsScreen(tester);

      await tester.tap(find.byType(MealItem).first);
      await tester.pumpAndSettle();

      expect(find.byType(MealDetailsSceen), findsOneWidget);
    });
  });

  testWidgets('Navigates to CategoriesScreen on back button tap',
      (tester) async {
    await mockNetworkImages(() async {
      await navigateToMealsScreen(tester);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(CategoriesScreen), findsOneWidget);
    });
  });

  testWidgets('Navigates to MealsScreen on back button tap', (tester) async {
    await mockNetworkImages(() async {
      await navigateToMealsScreen(tester);

      await tester.tap(find.byType(MealItem).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(MealsList), findsOneWidget);
    });
  });

  testWidgets('empty meal screen shows when meals are empty',
      (WidgetTester tester) async {
    const mealsScreen = MealsScreen(title: 'Test Meals', id: 'test');

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: mealsScreen),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(EmptyMealsScreen), findsOneWidget);
  });

  // Can show correct screen when switching tabs
  testWidgets('clicking on favorite tab should navigate to favorites screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(TabKeys.mealsTabKey));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(MealsScreen), findsOneWidget);
    expect(find.byType(CategoriesScreen), findsNothing);

    await tester.tap(find.byKey(TabKeys.categoryTabKey));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CategoriesScreen), findsOneWidget);
    expect(find.byType(MealsScreen), findsNothing);
  });
}

Future<void> navigateToMealsScreen(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: App()));

  await tester.tap(find.byType(CategoryGridItem).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
