enum ItemCondition {
  likeNew,
  good,
  fair,
  used;

  String get label {
    switch (this) {
      case ItemCondition.likeNew:
        return 'Like New';
      case ItemCondition.good:
        return 'Good';
      case ItemCondition.fair:
        return 'Fair';
      case ItemCondition.used:
        return 'Used';
    }
  }
}
