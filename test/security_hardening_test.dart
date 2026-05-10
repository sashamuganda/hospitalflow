import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  testWidgets('ClinicalNoteEditor has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: '1')));

    final soapFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 5000);
    expect(soapFields, findsNWidgets(4));

    final diagField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 200);
    expect(diagField, findsOneWidget);

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('TriageScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const TriageScreen(patientId: '1')));

    final complaintField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500);
    expect(complaintField, findsOneWidget);

    final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 8);
    expect(vitalFields, findsNWidgets(3));

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('PrescriptionWriterScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: '1')));

    final instructionsField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 1000);
    expect(instructionsField, findsOneWidget);

    final drugNameField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100);
    expect(drugNameField, findsOneWidget);

    final doseField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 50);
    expect(doseField, findsOneWidget);

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('LabOrderScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const LabOrderScreen(patientId: '1')));

    final notesField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500);
    expect(notesField, findsOneWidget);

    final tf = tester.widget<TextField>(notesField);
    expect(tf.decoration?.counterText, '');
  });

  testWidgets('PatientCheckInScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const PatientCheckInScreen()));

    final nameField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100);
    expect(nameField, findsOneWidget);

    final idField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.hintText == 'ID number (optional)');
    expect(idField, findsOneWidget);

    final ageField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 3);
    expect(ageField, findsOneWidget);

    final phoneField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.hintText == '+254 7XX XXX XXX');
    expect(phoneField, findsOneWidget);

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('VitalsEntryStaff has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: '1')));

    final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 8);
    expect(vitalFields, findsNWidgets(8));

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('LoginScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const LoginScreen()));

    final staffIdField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.hintText == 'e.g. DOC-2024-001');
    expect(staffIdField, findsOneWidget);

    final passwordField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 64 && w.decoration?.hintText == '••••••••');
    expect(passwordField, findsOneWidget);

    final facilityField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 10 && w.decoration?.hintText == 'MFH-001');
    expect(facilityField, findsOneWidget);

    final fields = find.byType(TextField);
    for (var i = 0; i < tester.widgetList(fields).length; i++) {
      final tf = tester.widget<TextField>(fields.at(i));
      expect(tf.decoration?.counterText, '');
    }
  });
}
