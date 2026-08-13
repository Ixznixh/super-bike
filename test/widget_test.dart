import 'package:flutter_test/flutter_test.dart';
import 'package:super_bike/main.dart';

void main() {
  testWidgets('Superbike app loads home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const ApexSuperbikeApp());
    expect(find.text('APEX VELOCITY'), findsOneWidget);
  });
}
