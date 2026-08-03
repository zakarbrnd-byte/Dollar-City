import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dollar_city/app.dart';
import 'package:dollar_city/core/widgets/marketplace_post_tile.dart';
import 'package:dollar_city/core/widgets/status_badge.dart';
import 'package:dollar_city/data/models/item_category.dart';
import 'package:dollar_city/data/models/item_condition.dart';
import 'package:dollar_city/data/models/listing_status.dart';
import 'package:dollar_city/data/models/market_item.dart';
import 'package:dollar_city/features/home/providers.dart';
import 'package:dollar_city/features/item_details/item_details_screen.dart';
import 'package:dollar_city/features/messages/chat_screen.dart';

MarketItem _sampleItem({
  String id = 'test_item',
  String sellerId = 'user_1',
  bool isSaved = false,
  int viewCount = 10,
  ListingStatus status = ListingStatus.available,
}) {
  return MarketItem(
    id: id,
    sellerId: sellerId,
    title: 'Wooden Side Table',
    description: 'A sturdy side table for local pickup.',
    imageUrls: const [],
    category: ItemCategory.furniture,
    condition: ItemCondition.good,
    status: status,
    pickupArea: 'Koreatown',
    distanceMiles: 1.2,
    createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
    isSaved: isSaved,
    viewCount: viewCount,
  );
}

Future<void> _pumpNav(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  // Network images fail under the test binding; drain those exceptions.
  Object? exception;
  do {
    exception = tester.takeException();
  } while (exception != null);
}

void main() {
  testWidgets('Home listing opens product details', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DollarCityApp()));
    await _pumpNav(tester);

    expect(find.byType(MarketplacePostTile), findsWidgets);
    await tester.tap(find.text('Wooden Side Table'));
    await _pumpNav(tester);

    expect(find.byType(ItemDetailsScreen), findsOneWidget);
    expect(find.text('Wooden Side Table'), findsWidgets);
    expect(find.text('\$1'), findsWidgets);
  });

  testWidgets('MarketplacePostTile renders fixed price and views', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MarketplacePostTile(item: _sampleItem(viewCount: 9)),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Wooden Side Table'), findsOneWidget);
    expect(find.text('\$1'), findsOneWidget);
    expect(find.text('9 views'), findsOneWidget);
  });

  testWidgets('Save button toggles saved state', (tester) async {
    final container = ProviderContainer(
      overrides: [
        marketplaceItemsProvider.overrideWith(_TestItemsNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ItemDetailsScreen(itemId: 'test_item')),
      ),
    );
    await _pumpNav(tester);

    expect(
      container
          .read(marketplaceItemsProvider.notifier)
          .byId('test_item')!
          .isSaved,
      isFalse,
    );

    await tester.tap(find.text('Save').first);
    await tester.pump();

    expect(
      container
          .read(marketplaceItemsProvider.notifier)
          .byId('test_item')!
          .isSaved,
      isTrue,
    );
  });

  testWidgets('View count increments once when details opens', (tester) async {
    final container = ProviderContainer(
      overrides: [
        marketplaceItemsProvider.overrideWith(_TestItemsNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    final before = container
        .read(marketplaceItemsProvider.notifier)
        .byId('test_item')!
        .viewCount;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ItemDetailsScreen(itemId: 'test_item')),
      ),
    );
    await _pumpNav(tester);

    expect(
      container
          .read(marketplaceItemsProvider.notifier)
          .byId('test_item')!
          .viewCount,
      before + 1,
    );

    container.read(marketplaceItemsProvider.notifier).toggleSaved('test_item');
    await tester.pump();

    expect(
      container
          .read(marketplaceItemsProvider.notifier)
          .byId('test_item')!
          .viewCount,
      before + 1,
    );
  });

  testWidgets('Message seller opens chat conversation', (tester) async {
    final container = ProviderContainer(
      overrides: [
        marketplaceItemsProvider.overrideWith(_TestItemsNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ItemDetailsScreen(itemId: 'test_item')),
      ),
    );
    await _pumpNav(tester);

    await tester.tap(find.text('Message seller'));
    await _pumpNav(tester);

    expect(find.byType(ChatScreen), findsOneWidget);
  });

  testWidgets('Owner sees status controls instead of Message seller', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        marketplaceItemsProvider.overrideWith(_OwnerItemsNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ItemDetailsScreen(itemId: 'owner_item')),
      ),
    );
    await _pumpNav(tester);

    expect(find.text('Message seller'), findsNothing);
    expect(find.text('Change status'), findsOneWidget);
    expect(find.text('Edit listing'), findsOneWidget);
  });

  testWidgets('Changing status updates the visible badge', (tester) async {
    final container = ProviderContainer(
      overrides: [
        marketplaceItemsProvider.overrideWith(_OwnerItemsNotifier.new),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ItemDetailsScreen(itemId: 'owner_item')),
      ),
    );
    await _pumpNav(tester);

    expect(find.widgetWithText(StatusBadge, 'Available'), findsOneWidget);

    await tester.tap(find.text('Change status'));
    await _pumpNav(tester);
    await tester.tap(find.text('Reserved').last);
    await _pumpNav(tester);

    expect(find.widgetWithText(StatusBadge, 'Reserved'), findsOneWidget);
    expect(
      container
          .read(marketplaceItemsProvider.notifier)
          .byId('owner_item')!
          .status,
      ListingStatus.reserved,
    );
  });

  testWidgets('Missing item ID shows Item not found', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ItemDetailsScreen(itemId: 'missing_item')),
      ),
    );
    await tester.pump();

    expect(find.text('Item not found'), findsOneWidget);
    expect(find.text('This listing may have been removed.'), findsOneWidget);
    expect(find.text('Back to marketplace'), findsOneWidget);
  });
}

class _TestItemsNotifier extends MarketplaceItemsNotifier {
  @override
  List<MarketItem> build() => [_sampleItem()];
}

class _OwnerItemsNotifier extends MarketplaceItemsNotifier {
  @override
  List<MarketItem> build() => [
    _sampleItem(id: 'owner_item', sellerId: 'user_me'),
  ];
}
