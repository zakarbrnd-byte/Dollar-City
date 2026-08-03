import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dollar_city/app.dart';
import 'package:dollar_city/core/constants/app_constants.dart';

void main() {
  testWidgets('Dollar City shows home feed', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DollarCityApp()));
    await tester.pump();

    expect(find.text(AppConstants.appName), findsWidgets);
    expect(find.text('Sell'), findsWidgets);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Small desk'), findsOneWidget);
  });
}
