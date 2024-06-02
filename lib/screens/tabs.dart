import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsStateState();
}

class _TabsStateState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    String activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      activePage = const MealsScreen(
        id: '',
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          ref.read(mealsTitleProvider.notifier).state = null;

          _selectPage(index);
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            key: TabKeys.categoryTabKey,
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            key: TabKeys.mealsTabKey,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
