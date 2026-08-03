enum ItemCategory {
  all,
  furniture,
  clothing,
  electronics,
  kids,
  home,
  other;

  String get label {
    switch (this) {
      case ItemCategory.all:
        return 'All';
      case ItemCategory.furniture:
        return 'Furniture';
      case ItemCategory.clothing:
        return 'Clothing';
      case ItemCategory.electronics:
        return 'Electronics';
      case ItemCategory.kids:
        return 'Kids';
      case ItemCategory.home:
        return 'Home';
      case ItemCategory.other:
        return 'Other';
    }
  }

  /// Categories available when creating a listing (excludes "All").
  static List<ItemCategory> get listingValues =>
      ItemCategory.values.where((c) => c != ItemCategory.all).toList();
}
