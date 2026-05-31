import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';

void main() {
  testWidgets('ClinicalNoteEditor has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: '1')));

    final textFields = find.byType(TextField);
    expect(textFields, findsAtLeastNWidgets(5));

    for (final widget in tester.widgetList<TextField>(textFields)) {
      expect(widget.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(widget.decoration?.counterText, '', reason: 'TextField missing counterText: ""');
    }

    final diagnosesField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && (w.decoration?.hintText?.contains('ICD-10') == true || w.decoration?.hintText?.contains('Hypertension') == true)
    ));
    expect(diagnosesField.maxLength, 200);

    final soapFields = tester.widgetList<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.maxLines == 4
    ));
    for (final field in soapFields) {
      expect(field.maxLength, 2000);
    }
  });

  testWidgets('PrescriptionWriterScreen has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

    final nameField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Drug name'
    ));
    expect(nameField.maxLength, 100);
    expect(nameField.decoration?.counterText, '');

    final doseField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText?.contains('Dose') == true
    ));
    expect(doseField.maxLength, 50);
    expect(doseField.decoration?.counterText, '');

    final notesField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.maxLines == 3
    ));
    expect(notesField.maxLength, 500);
    expect(notesField.decoration?.counterText, '');
  });

  testWidgets('TriageScreen has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

    final complaintField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText?.contains('main complaint') == true
    ));
    expect(complaintField.maxLength, 500);
    expect(complaintField.decoration?.counterText, '');

    final vitalFields = find.byWidgetPredicate(
      (w) => w is TextField && w.keyboardType == TextInputType.number
    );
    expect(vitalFields, findsAtLeastNWidgets(3));
    for (final widget in tester.widgetList<TextField>(vitalFields)) {
      expect(widget.maxLength, 10);
      expect(widget.decoration?.counterText, '');
    }
  });

  testWidgets('PatientCheckInScreen has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

    final nameField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Patient full name'
    ));
    expect(nameField.maxLength, 100);
    expect(nameField.decoration?.counterText, '');

    final idField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText?.contains('ID number') == true
    ));
    expect(idField.maxLength, 50);
    expect(idField.decoration?.counterText, '');

    final ageField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == '0'
    ));
    expect(ageField.maxLength, 3);
    expect(ageField.decoration?.counterText, '');

    final phoneField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText?.contains('7XX') == true
    ));
    expect(phoneField.maxLength, 20);
    expect(phoneField.decoration?.counterText, '');
  });

  testWidgets('LabOrderScreen has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: '1')));

    final notesField = tester.widget<TextField>(find.byWidgetPredicate(
      (w) => w is TextField && w.maxLines == 2
    ));
    expect(notesField.maxLength, 500);
    expect(notesField.decoration?.counterText, '');
  });
}
