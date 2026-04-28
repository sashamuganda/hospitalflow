import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PatientCheckInScreen has length limits', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MaterialApp(home: PatientCheckInScreen()),
      ),
    );

    final nameField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Patient full name'
    ));
    expect(nameField.maxLength, 100);
    expect(nameField.decoration?.counterText, '');

    final idField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'ID number (optional)'
    ));
    expect(idField.maxLength, 20);
    expect(idField.decoration?.counterText, '');

    final ageField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == '0'
    ));
    expect(ageField.maxLength, 3);
    expect(ageField.decoration?.counterText, '');

    final phoneField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == '+254 7XX XXX XXX'
    ));
    expect(phoneField.maxLength, 20);
    expect(phoneField.decoration?.counterText, '');
  });
}
