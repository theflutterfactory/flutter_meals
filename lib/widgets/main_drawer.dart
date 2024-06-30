import 'package:flutter/material.dart';
import 'package:flutter_meals/screens/filters.dart';
import 'package:flutter_meals/screens/tabs.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  theme.primaryColor,
                  theme.primaryColorDark.withOpacity(0.4),
                ],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.fastfood, size: 48),
                const SizedBox(width: 16),
                Text(
                  "Let's cook!",
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(
              'Meals',
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 18),
            ),
            onTap: () {
              _navigateTo(context, const TabsScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'Filters',
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 18),
            ),
            onTap: () {
              _navigateTo(context, const FiltersScreen());
            },
          ),
        ],
      ),
    );
  }
}
