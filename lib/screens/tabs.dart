import 'package:flutter/material.dart';
import 'package:flutter_meals/constants.dart';
import 'package:flutter_meals/screens/categories.dart';
import 'package:flutter_meals/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String yourFavoritesTitle = 'Your Favorites';
const String categoriesTitle = 'Categories';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsStateState();
}

class _TabsStateState extends ConsumerState<TabsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    ref.read(mealsTitleProvider.notifier).state =
        _tabController.index == Tabs.values.indexOf(Tabs.favorites)
            ? yourFavoritesTitle
            : categoriesTitle;

    ref.read(selectedTabProvider.notifier).state =
        Tabs.values[_tabController.index];
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(mealsTitleProvider.notifier).state),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [CategoriesScreen(), MealsScreen(id: '')],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _tabController.index = index,
        currentIndex: Tabs.values.indexOf(selectedTab),
        items: const [
          BottomNavigationBarItem(
            key: TabKeys.categoryTabKey,
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            key: TabKeys.favoritesTabKey,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }
}

enum Tabs { categories, favorites }

final selectedTabProvider = StateProvider<Tabs>((ref) => Tabs.categories);
