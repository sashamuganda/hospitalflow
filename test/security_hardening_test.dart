import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';

void main() {
  group('Security Hardening: Input Constraints', () {
    testWidgets('ClinicalNoteEditor has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ClinicalNoteEditor(patientId: 'p001'),
      ));

      final soapHints = [
        'Patient-reported',
        'Examination findings',
        'Clinical impression',
        'Treatment plan',
      ];

      for (var hint in soapHints) {
        final finder = find.byWidgetPredicate((w) =>
          w is TextField && (w.decoration?.hintText?.contains(hint) ?? false));
        expect(finder, findsOneWidget, reason: 'Could not find field with hint $hint');
        final TextField textField = tester.widget(finder);
        expect(textField.maxLength, 5000, reason: 'Field $hint should have maxLength 5000');
        expect(textField.decoration?.counterText, '', reason: 'Field $hint counter should be suppressed');
      }

      final diagFinder = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('I10') ?? false));
      expect(diagFinder, findsOneWidget);
      final TextField diagField = tester.widget(diagFinder);
      expect(diagField.maxLength, 200);
      expect(diagField.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PrescriptionWriterScreen(patientId: 'p001'),
      ));

      final drugFinder = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('Drug name') ?? false));
      expect(drugFinder, findsOneWidget);
      expect((tester.widget(drugFinder) as TextField).maxLength, 100);

      final doseFinder = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('Dose') ?? false));
      expect(doseFinder, findsOneWidget);
      expect((tester.widget(doseFinder) as TextField).maxLength, 50);

      final notesFinder = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('food') ?? false));
      expect(notesFinder, findsOneWidget);
      expect((tester.widget(notesFinder) as TextField).maxLength, 1000);
    });

    testWidgets('PatientCheckInScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PatientCheckInScreen(),
      ));

      final nameField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == 'Patient full name'));
      final idField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == 'ID number (optional)'));
      final phoneField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == '+254 7XX XXX XXX'));
      final ageField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == '0'));

      expect(nameField, findsOneWidget);
      expect(idField, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(ageField, findsOneWidget);

      expect((tester.widget(nameField) as TextField).maxLength, 100);
      expect((tester.widget(idField) as TextField).maxLength, 20);
      expect((tester.widget(phoneField) as TextField).maxLength, 20);
      expect((tester.widget(ageField) as TextField).maxLength, 3);
    });

    testWidgets('TriageScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TriageScreen(patientId: 'q001'),
      ));

      final complaintField = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('complaint') ?? false));
      expect(complaintField, findsOneWidget);
      expect((tester.widget(complaintField) as TextField).maxLength, 500);

      final vitalFields = find.byType(TextField).evaluate().where((e) => (e.widget as TextField).decoration?.suffix != null);
      expect(vitalFields.length, greaterThan(0));
      for (var element in vitalFields) {
        expect((element.widget as TextField).maxLength, 8);
      }
    });

    testWidgets('LabOrderScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LabOrderScreen(patientId: 'p001'),
      ));

      final notesField = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains('Relevant clinical') ?? false));
      expect(notesField, findsOneWidget);
      expect((tester.widget(notesField) as TextField).maxLength, 500);
    });

    testWidgets('VitalsEntryStaff has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: VitalsEntryStaff(patientId: 'p001'),
      ));

      final fields = find.byType(TextField).evaluate();
      expect(fields.length, greaterThan(0));
      for (var element in fields) {
        expect((element.widget as TextField).maxLength, 8);
      }
    });
  });
}
