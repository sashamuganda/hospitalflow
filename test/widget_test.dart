import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/main.dart';

void main() {
  testWidgets('MedFlow Staff smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MedFlowStaffApp());
    // Use pumpAndSettle to wait for any animations and pending timers (like in SplashScreen)
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
