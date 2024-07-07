import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/main.dart';
import 'package:flutter_meals/models/filter_options.dart';
import 'package:flutter_meals/notifiers/filter_notifier.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:flutter_meals/screens/meal_details.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_meals/service/meal_service.dart';
import 'package:flutter_meals/widgets/category_grid_item.dart';
import 'package:flutter_meals/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  testWidgets('Navigates to MealsScreen on category grid item tap',
      (tester) async {
    await mockNetworkImages(() async {
      await _navigateToMealsScreen(tester);
    });
  });

  testWidgets('Navigates to MealDetailsScreen on meal item tap',
      (tester) async {
    await mockNetworkImages(() async {
      await _navigateToMealsScreen(tester);

      await tester.tap(find.byType(MealItem).first);
      await tester.pumpAndSettle();

      expect(find.byType(MealDetailsSceen), findsOneWidget);
    });
  });

  testWidgets('Navigates to CategoriesScreen on back button tap',
      (tester) async {
    await mockNetworkImages(() async {
      await _navigateToMealsScreen(tester);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(CategoriesScreen), findsOneWidget);
    });
  });

  testWidgets('Navigates to MealsScreen on back button tap', (tester) async {
    await mockNetworkImages(() async {
      await _navigateToMealsScreen(tester);

      await tester.tap(find.byType(MealItem).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(MealsList), findsOneWidget);
    });
  });

  testWidgets('empty meal screen shows when meals are empty',
      (WidgetTester tester) async {
    const mealsScreen = MealsScreen(id: 'test');

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: mealsScreen),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(EmptyMealsScreen), findsOneWidget);
  });

  testWidgets('clicking on favorite tab should navigate to favorites screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.byType(CategoriesScreen), findsOneWidget);
    expect(find.byType(MealsScreen), findsNothing);

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(TabKeys.favoritesTabKey));
    await tester.pumpAndSettle();
    expect(find.byType(MealsScreen), findsOneWidget);
    expect(find.byType(CategoriesScreen), findsNothing);
  });

  testWidgets('Can favorite a meal and have it show in favorites',
      (tester) async {
    await mockNetworkImages(() async {
      await _navigateToMealsScreen(tester);

      await tester.tap(find.byType(MealItem).first);
      await tester.pumpAndSettle();

      expect(find.byType(MealDetailsSceen), findsOneWidget);

      final Finder favoriteButton = find.byKey(
        IconButtonKeys.favoriteIconButtonKey,
      );
      expect(favoriteButton, findsOneWidget);

      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();

      // navigate back to the home screen from the meal details screen
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(CategoriesScreen), findsOneWidget);

      await tester.tap(find.byKey(TabKeys.favoritesTabKey));
      await tester.pumpAndSettle();

      expect(find.byType(MealItem), findsOneWidget);
    });
  });

  testWidgets('mealsByIdProvider returns correct data with updated filter',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    const id = 'c2';

    var container = _createContainer(FilterOptions(
      isGlutenFree: false,
      isLactoseFree: false,
      isVegan: false,
      isVegetarian: false,
    ));

    var meals = await container.read(mealsByIdProvider(id).future);
    expect(meals.length, 4);

    container = _createContainer(FilterOptions(
      isGlutenFree: false,
      isLactoseFree: false,
      isVegan: true,
      isVegetarian: true,
    ));

    meals = await container.read(mealsByIdProvider(id).future);
    expect(meals.length, 2);

    container = _createContainer(FilterOptions(
      isGlutenFree: true,
      isLactoseFree: true,
      isVegan: true,
      isVegetarian: true,
    ));

    meals = await container.read(mealsByIdProvider(id).future);
    expect(meals.length, 1);
  });
}

ProviderContainer _createContainer(FilterOptions options) =>
    ProviderContainer(overrides: [
      filterProvider.overrideWith(
        (ref) => FilterNotifier(state: options),
      ),
    ]);

Future<void> _navigateToMealsScreen(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: App()));

  await tester.tap(find.byType(CategoryGridItem).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
