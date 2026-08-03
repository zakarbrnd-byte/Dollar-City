import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dollar_city/app.dart';
import 'package:dollar_city/core/constants/app_constants.dart';

void main() {
  testWidgets('Dollar City marketplace home UI loads', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: DollarCityApp()));
    await tester.pump();

    expect(find.textContaining('Dollar'), findsWidgets);
    expect(find.text(AppConstants.defaultLocation), findsOneWidget);
    expect(find.text(AppConstants.searchPlaceholder), findsOneWidget);
    expect(find.text('How Dollar City Works'), findsOneWidget);
    expect(find.text('Wooden Side Table'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Sell'), findsOneWidget);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
