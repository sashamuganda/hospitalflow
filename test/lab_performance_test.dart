import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/lab/lab_home_screen.dart';

void main() {
  testWidgets('LabHomeScreen shows sorted orders by priority', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LabHomeScreen()));

    // In mock_data.dart:
    // lo001: Samuel Ouma (routine)
    // lo002: Mary Njeri (urgent)
    // 'urgent' priority should be displayed above 'routine' priority.

    final maryFinder = find.text('Mary Njeri');
    final samuelFinder = find.text('Samuel Ouma');

    expect(maryFinder, findsOneWidget);
    expect(samuelFinder, findsOneWidget);

    final maryPos = tester.getCenter(maryFinder).dy;
    final samuelPos = tester.getCenter(samuelFinder).dy;

    expect(maryPos < samuelPos, isTrue, reason: 'Mary (urgent) should be above Samuel (routine)');
  });
}
