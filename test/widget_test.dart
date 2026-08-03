import 'package:flutter_test/flutter_test.dart';

import 'package:dollar_city/app.dart';

void main() {
  testWidgets('Dollar City shows home feed', (WidgetTester tester) async {
    await tester.pumpWidget(const DollarCityApp());
    await tester.pump();

    expect(find.text('Dollar City'), findsOneWidget);
    expect(find.text('Sell'), findsWidgets);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Small desk'), findsOneWidget);
  });
}
