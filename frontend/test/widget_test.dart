import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Churn Analytics dashboard loads successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ChurnAnalyticsApp());

    await tester.pumpAndSettle();

    // Verify dashboard heading.
    expect(
      find.text('Customer Churn Dashboard'),
      findsOneWidget,
    );

    // Verify sidebar navigation.
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Churn Analytics'), findsOneWidget);
    expect(find.text('Predict Churn'), findsOneWidget);
    expect(find.text('Retention Insights'), findsOneWidget);
    expect(find.text('About Model'), findsOneWidget);

    // Verify dashboard KPI.
    expect(find.text('Total Customers'), findsOneWidget);
    expect(find.text('7,043'), findsOneWidget);
  });
}