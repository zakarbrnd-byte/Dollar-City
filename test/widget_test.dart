import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dollar_city/app.dart';
import 'package:dollar_city/core/widgets/marketplace_post_tile.dart';

void main() {
  testWidgets('Home shows marketplace post tiles', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DollarCityApp()));
    await tester.pump();

    expect(find.byType(MarketplacePostTile), findsWidgets);
    expect(find.text('Doll House'), findsOneWidget);
    expect(find.text('Coffee Maker'), findsOneWidget);
    expect(find.text('\$1'), findsWidgets);
    expect(find.text('15 views'), findsOneWidget);
    expect(find.text('2 min ago'), findsOneWidget);
  });

  testWidgets('MarketplacePostTile renders fixed price and views', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MarketplacePostTile(
            imageUrl: 'https://invalid.example/image.png',
            title: 'Demo Item',
            postedTime: '5 min ago',
            viewCount: 9,
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Demo Item'), findsOneWidget);
    expect(find.text('5 min ago'), findsOneWidget);
    expect(find.text('\$1'), findsOneWidget);
    expect(find.text('9 views'), findsOneWidget);
  });
}
