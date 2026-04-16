import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/main.dart';

void main() {
  testWidgets('MedFlow Staff smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MedFlowStaffApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    // Use pumpAndSettle to clear pending timers from SplashScreen
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
