class FilterOptions {
  final bool isGlutenFree;
  final bool isVegetarian;
  final bool isVegan;

  FilterOptions({
    this.isGlutenFree = false,
    this.isVegetarian = false,
    this.isVegan = false,
  });

  FilterOptions copyWith({
    bool? isGlutenFree,
    bool? isVegetarian,
    bool? isVegan,
  }) {
    return FilterOptions(
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
    );
  }
}
