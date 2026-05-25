import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  testWidgets('ClinicalNoteEditor has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));

    final textFields = find.byType(TextField);
    expect(textFields, findsAtLeastNWidgets(5)); // S, O, A, P, Diagnosis

    for (final element in tester.widgetList<TextField>(textFields)) {
      if (element.maxLines == 4) { // SOAP fields
        expect(element.maxLength, 5000);
        expect(element.decoration?.counterText, '');
      } else { // Diagnosis field
        expect(element.maxLength, 200);
        expect(element.decoration?.counterText, '');
      }
    }
  });

  testWidgets('PrescriptionWriterScreen has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));

    final drugNameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name');
    final doseField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Dose (e.g. 500mg)');
    final instructionsField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('food') == true);

    expect(tester.widget<TextField>(drugNameField).maxLength, 100);
    expect(tester.widget<TextField>(drugNameField).decoration?.counterText, '');

    expect(tester.widget<TextField>(doseField).maxLength, 50);
    expect(tester.widget<TextField>(doseField).decoration?.counterText, '');

    expect(tester.widget<TextField>(instructionsField).maxLength, 1000);
    expect(tester.widget<TextField>(instructionsField).decoration?.counterText, '');
  });

  testWidgets('LabOrderScreen has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));

    final notesField = find.byType(TextField);
    expect(tester.widget<TextField>(notesField).maxLength, 500);
    expect(tester.widget<TextField>(notesField).decoration?.counterText, '');
  });

  testWidgets('TriageScreen has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q001')));

    final complaintField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('complaint') == true);
    expect(tester.widget<TextField>(complaintField).maxLength, 500);
    expect(tester.widget<TextField>(complaintField).decoration?.counterText, '');

    final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.keyboardType == TextInputType.number);
    expect(vitalFields, findsAtLeastNWidgets(3));
    for (final element in tester.widgetList<TextField>(vitalFields)) {
      expect(element.maxLength, 8);
      expect(element.decoration?.counterText, '');
    }
  });

  testWidgets('PatientCheckInScreen has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const PatientCheckInScreen()));

    final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('name') == true);
    final idField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('ID') == true);
    final ageField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0');
    final phoneField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('254') == true);

    expect(tester.widget<TextField>(nameField).maxLength, 100);
    expect(tester.widget<TextField>(nameField).decoration?.counterText, '');

    expect(tester.widget<TextField>(idField).maxLength, 20);
    expect(tester.widget<TextField>(idField).decoration?.counterText, '');

    expect(tester.widget<TextField>(ageField).maxLength, 3);
    expect(tester.widget<TextField>(ageField).decoration?.counterText, '');

    expect(tester.widget<TextField>(phoneField).maxLength, 20);
    expect(tester.widget<TextField>(phoneField).decoration?.counterText, '');
  });

  testWidgets('VitalsEntryStaff has maxLength and no counter', (tester) async {
    await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));

    final vitalFields = find.byType(TextField);
    expect(vitalFields, findsAtLeastNWidgets(8));
    for (final element in tester.widgetList<TextField>(vitalFields)) {
      expect(element.maxLength, 8);
      expect(element.decoration?.counterText, '');
    }
  });

  testWidgets('ForgotPasswordScreen has maxLength 20 for Staff ID', (tester) async {
    await tester.pumpWidget(wrap(const ForgotPasswordScreen()));

    final staffIdField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('DOC') == true);
    expect(tester.widget<TextField>(staffIdField).maxLength, 20);
    expect(tester.widget<TextField>(staffIdField).decoration?.counterText, '');
  });
}
