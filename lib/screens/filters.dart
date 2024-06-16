import 'package:flutter/material.dart';
import 'package:flutter_meals/notifiers/filter_notifier.dart';
import 'package:flutter_meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          SwitchListTile(
            value: ref.watch(filterProvider).isGlutenFree,
            onChanged: (bool value) {
              ref.read(filterProvider.notifier).updateGlutenFree(value);
            },
            title: Text(
              'Gluten-free',
              style: theme.textTheme.titleLarge,
            ),
            subtitle: const Text('Only include gluten-free meals'),
            activeColor: theme.colorScheme.tertiary,
            contentPadding: const EdgeInsets.all(32),
          ),
        ],
      ),
    );
  }
}
