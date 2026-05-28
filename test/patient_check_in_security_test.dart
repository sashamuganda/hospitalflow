import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';

void main() {
  testWidgets('PatientCheckInScreen has security hardening for input fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PatientCheckInScreen(),
    ));

    // Helper to verify TextField security properties
    void verifyField(String hintText, int maxLength) {
      final textFieldFinder = find.byWidgetPredicate(
        (widget) => widget is TextField && (widget.decoration?.hintText?.contains(hintText) ?? false)
      );
      expect(textFieldFinder, findsOneWidget, reason: 'Field with hint "$hintText" not found');

      final textField = tester.widget<TextField>(textFieldFinder);
      expect(textField.maxLength, maxLength, reason: 'Field "$hintText" missing maxLength $maxLength');
      expect(textField.decoration?.counterText, '', reason: 'Field "$hintText" should suppress counter text');
    }

    verifyField('Patient full name', 100);
    verifyField('ID number (optional)', 20);
    verifyField('0', 3); // Age field
    verifyField('+254 7XX XXX XXX', 20); // Phone field
  });
}
