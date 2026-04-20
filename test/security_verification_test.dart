import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PatientCheckInScreen has maxLength constraints', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MaterialApp(
          home: PatientCheckInScreen(),
        ),
      ),
    );

    final nameField = find.byType(TextField).first;
    final TextField nameWidget = tester.widget(nameField);
    expect(nameWidget.maxLength, 100);
    expect(nameWidget.decoration?.counterText, '');

    final idField = find.byType(TextField).at(1);
    final TextField idWidget = tester.widget(idField);
    expect(idWidget.maxLength, 20);

    final phoneField = find.byType(TextField).at(3); // Age is at 2
    final TextField phoneWidget = tester.widget(phoneField);
    expect(phoneWidget.maxLength, 20);
  });
}
