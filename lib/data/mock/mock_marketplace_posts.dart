import '../models/marketplace_post.dart';

/// Local mock posts for demonstrating [MarketplacePostTile].
class MockMarketplacePosts {
  MockMarketplacePosts._();

  static const List<MarketplacePost> all = [
    MarketplacePost(
      id: 'post_1',
      title: 'Doll House',
      imageUrl: 'https://picsum.photos/seed/dollhouse/400/400',
      createdAtLabel: '2 min ago',
      viewCount: 15,
      pickupArea: 'Koreatown',
      distanceMiles: 1.2,
    ),
    MarketplacePost(
      id: 'post_2',
      title: 'Coffee Maker',
      imageUrl: 'https://picsum.photos/seed/coffeemaker2/400/400',
      createdAtLabel: '12 min ago',
      viewCount: 28,
      pickupArea: 'Downtown LA',
      distanceMiles: 2.4,
    ),
    MarketplacePost(
      id: 'post_3',
      title: 'Floor Lamp',
      imageUrl: 'https://picsum.photos/seed/floorlamp2/400/400',
      createdAtLabel: '1 hr ago',
      viewCount: 41,
      pickupArea: 'Silver Lake',
      distanceMiles: 2.8,
    ),
    MarketplacePost(
      id: 'post_4',
      title: 'Baby Stroller',
      imageUrl: 'https://picsum.photos/seed/stroller2/400/400',
      createdAtLabel: '2 hr ago',
      viewCount: 33,
      pickupArea: 'Echo Park',
      distanceMiles: 1.9,
    ),
    MarketplacePost(
      id: 'post_5',
      title: 'Storage Bins',
      imageUrl: 'https://picsum.photos/seed/bins2/400/400',
      createdAtLabel: '3 hr ago',
      viewCount: 19,
      pickupArea: 'Culver City',
      distanceMiles: 4.1,
    ),
    MarketplacePost(
      id: 'post_6',
      title: 'Office Chair',
      imageUrl: 'https://picsum.photos/seed/chair2/400/400',
      createdAtLabel: '5 hr ago',
      viewCount: 52,
      pickupArea: 'West Hollywood',
      distanceMiles: 2.2,
    ),
  ];
}
