import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';

void main() {
  testWidgets('EMR Home Search has maxLength 100', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmrHomeScreen()));
    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.maxLength, 100);
    expect(textField.decoration?.counterText, '');
  });

  testWidgets('Clinical Note Editor has correct maxLengths', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: 'p001')));

    // SOAP sections (4 fields)
    final soapFields = find.byType(TextField).evaluate().map((e) => e.widget as TextField).where((w) => w.maxLines == 4);
    expect(soapFields.length, 4);
    for (final field in soapFields) {
      expect(field.maxLength, 5000);
      expect(field.decoration?.counterText, '');
    }

    // ICD-10 field
    final allFields = find.byType(TextField).evaluate().map((e) => e.widget as TextField);
    final icdFields = allFields.where((w) {
      final hint = w.decoration?.hintText;
      return hint != null && hint.contains('I10');
    });
    expect(icdFields.length, 1);
    expect(icdFields.first.maxLength, 200);
    expect(icdFields.first.decoration?.counterText, '');
  });

  testWidgets('Triage Screen has correct maxLengths', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'p001')));

    final complaintField = find.byWidgetPredicate((w) => w is TextField && w.maxLines == 2).evaluate().map((e) => e.widget as TextField);
    expect(complaintField.length, 1);
    expect(complaintField.first.maxLength, 500);
    expect(complaintField.first.decoration?.counterText, '');

    final vitalsFields = find.byType(TextField).evaluate().map((e) => e.widget as TextField).where((w) => w.keyboardType == TextInputType.number);
    for (final field in vitalsFields) {
      expect(field.maxLength, 8);
      expect(field.decoration?.counterText, '');
    }
  });

  testWidgets('Vitals Entry Staff has maxLength 8', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: 'p001')));
    final fields = find.byType(TextField).evaluate().map((e) => e.widget as TextField);
    for (final field in fields) {
      expect(field.maxLength, 8);
      expect(field.decoration?.counterText, '');
    }
  });

  testWidgets('Prescription Writer has correct maxLengths', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: 'p001')));

    final drugNameField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == 'Drug name')).evaluate().map((e) => e.widget as TextField);
    expect(drugNameField.length, 1);
    expect(drugNameField.first.maxLength, 100);
    expect(drugNameField.first.decoration?.counterText, '');

    final doseField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == 'Dose (e.g. 500mg)')).evaluate().map((e) => e.widget as TextField);
    expect(doseField.length, 1);
    expect(doseField.first.maxLength, 50);
    expect(doseField.first.decoration?.counterText, '');

    final notesField = find.byWidgetPredicate((w) => w is TextField && w.maxLines == 3).evaluate().map((e) => e.widget as TextField);
    expect(notesField.length, 1);
    expect(notesField.first.maxLength, 1000);
    expect(notesField.first.decoration?.counterText, '');
  });
}
