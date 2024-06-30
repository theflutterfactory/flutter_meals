class FilterOptions {
  final bool isGlutenFree;
  final bool isVegetarian;
  final bool isVegan;
  final bool isLactoseFree;

  FilterOptions({
    this.isGlutenFree = false,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isLactoseFree = false,
  });

  FilterOptions copyWith({
    bool? isGlutenFree,
    bool? isVegetarian,
    bool? isVegan,
    bool? isLactoseFree,
  }) {
    return FilterOptions(
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
    );
  }
}
