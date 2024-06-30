import 'package:flutter/material.dart';
import 'package:flutter_meals/notifiers/filter_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
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
          SwitchListTile(
            value: ref.watch(filterProvider).isLactoseFree,
            onChanged: (bool value) {
              ref.read(filterProvider.notifier).updateLactoseFree(value);
            },
            title: Text(
              'Lactose-free',
              style: theme.textTheme.titleLarge,
            ),
            subtitle: const Text('Only include lactose-free meals'),
            activeColor: theme.colorScheme.tertiary,
            contentPadding: const EdgeInsets.all(32),
          ),
          SwitchListTile(
            value: ref.watch(filterProvider).isVegetarian,
            onChanged: (bool value) {
              ref.read(filterProvider.notifier).updateVegetarian(value);
            },
            title: Text(
              'Vegetarian',
              style: theme.textTheme.titleLarge,
            ),
            subtitle: const Text('Only include vegetarian meals'),
            activeColor: theme.colorScheme.tertiary,
            contentPadding: const EdgeInsets.all(32),
          ),
          SwitchListTile(
            value: ref.watch(filterProvider).isVegan,
            onChanged: (bool value) {
              ref.read(filterProvider.notifier).updateVegan(value);
            },
            title: Text(
              'Vegan',
              style: theme.textTheme.titleLarge,
            ),
            subtitle: const Text('Only include vegan meals'),
            activeColor: theme.colorScheme.tertiary,
            contentPadding: const EdgeInsets.all(32),
          ),
        ],
      ),
    );
  }
}
