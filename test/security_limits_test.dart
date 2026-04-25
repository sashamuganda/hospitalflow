import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';

void main() {
  testWidgets('PatientCheckInScreen has input length limits', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PatientCheckInScreen(),
    ));

    // Name field
    final nameField = find.widgetWithText(TextField, 'Patient full name');
    expect(nameField, findsOneWidget);
    TextField nameTextField = tester.widget(nameField);
    expect(nameTextField.maxLength, 100);
    expect(nameTextField.decoration?.counterText, '');

    // ID field
    final idField = find.widgetWithText(TextField, 'ID number (optional)');
    expect(idField, findsOneWidget);
    TextField idTextField = tester.widget(idField);
    expect(idTextField.maxLength, 20);
    expect(idTextField.decoration?.counterText, '');

    // Phone field
    final phoneField = find.widgetWithText(TextField, '+254 7XX XXX XXX');
    expect(phoneField, findsOneWidget);
    TextField phoneTextField = tester.widget(phoneField);
    expect(phoneTextField.maxLength, 20);
    expect(phoneTextField.decoration?.counterText, '');
  });
}
