import 'item_category.dart';
import 'item_condition.dart';
import 'listing_status.dart';

class MarketItem {
  const MarketItem({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.condition,
    required this.status,
    required this.pickupArea,
    required this.distanceMiles,
    required this.createdAt,
    this.isSaved = false,
  });

  final String id;
  final String sellerId;
  final String title;
  final String description;
  final List<String> imageUrls;
  final ItemCategory category;
  final ItemCondition condition;
  final ListingStatus status;
  final String pickupArea;
  final double distanceMiles;
  final DateTime createdAt;
  final bool isSaved;

  /// Every listing on Dollar City is exactly $1.
  double get price => 1.00;

  String get formattedPrice => '\$1';

  MarketItem copyWith({
    String? id,
    String? sellerId,
    String? title,
    String? description,
    List<String>? imageUrls,
    ItemCategory? category,
    ItemCondition? condition,
    ListingStatus? status,
    String? pickupArea,
    double? distanceMiles,
    DateTime? createdAt,
    bool? isSaved,
  }) {
    return MarketItem(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      pickupArea: pickupArea ?? this.pickupArea,
      distanceMiles: distanceMiles ?? this.distanceMiles,
      createdAt: createdAt ?? this.createdAt,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
