/// Simple marketplace post model for list-tile demos.
///
/// Price is never editable — Dollar City listings are always $1.
class MarketplacePost {
  const MarketplacePost({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.createdAtLabel,
    required this.viewCount,
    required this.pickupArea,
    required this.distanceMiles,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String createdAtLabel;
  final int viewCount;
  final String pickupArea;
  final double distanceMiles;

  /// Every listing on Dollar City is exactly $1.
  double get price => 1.00;
}
