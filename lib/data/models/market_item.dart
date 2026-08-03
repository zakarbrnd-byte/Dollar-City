class MarketItem {
  const MarketItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.pickupArea,
    required this.distanceMiles,
    required this.createdAt,
    required this.favoriteCount,
    required this.viewCount,
    required this.isAvailable,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String pickupArea;
  final double distanceMiles;
  final DateTime createdAt;
  final int favoriteCount;
  final int viewCount;
  final bool isAvailable;

  /// Every Dollar City listing is exactly $1.
  double get price => 1.00;

  String get formattedPrice => '\$1';
}
