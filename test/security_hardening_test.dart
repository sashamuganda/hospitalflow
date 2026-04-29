import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';

void main() {
  group('Security Hardening: Input Limits (DoS Mitigation)', () {
    testWidgets('ClinicalNoteEditor has length limits on SOAP sections', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ClinicalNoteEditor(patientId: 'P001'),
      ));

      final textFields = find.byType(TextField);
      // S, O, A, P sections (4) + ICD-10 (1) = 5 fields
      expect(textFields, findsNWidgets(5));

      for (int i = 0; i < 4; i++) {
        final textField = tester.widget<TextField>(textFields.at(i));
        expect(textField.maxLength, 5000, reason: 'SOAP section $i should have 5000 char limit');
        expect(textField.decoration?.counterText, '', reason: 'Counter should be hidden');
      }

      final diagField = tester.widget<TextField>(textFields.at(4));
      expect(diagField.maxLength, 200, reason: 'Diagnosis field should have 200 char limit');
      expect(diagField.decoration?.counterText, '', reason: 'Counter should be hidden');
    });

    testWidgets('PrescriptionWriterScreen has length limits', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PrescriptionWriterScreen(patientId: 'P001'),
      ));

      // Initial state has 1 Rx item (Drug Name, Dose) + Instructions = 3 fields
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(3));

      final nameField = tester.widget<TextField>(textFields.at(0));
      expect(nameField.maxLength, 100, reason: 'Drug name should have 100 char limit');

      final doseField = tester.widget<TextField>(textFields.at(1));
      expect(doseField.maxLength, 50, reason: 'Dose should have 50 char limit');

      final notesField = tester.widget<TextField>(textFields.at(2));
      expect(notesField.maxLength, 1000, reason: 'Instructions should have 1000 char limit');
    });

    testWidgets('EmrHomeScreen has search length limit', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EmrHomeScreen(),
      ));

      final searchField = tester.widget<TextField>(find.byType(TextField));
      expect(searchField.maxLength, 100);
      expect(searchField.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has length limits', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TriageScreen(patientId: 'Q-001'),
      ));

      // Chief Complaint + 3 Vitals in grid = 4 fields
      final textFields = find.byType(TextField);

      final complaintField = tester.widget<TextField>(textFields.at(0));
      expect(complaintField.maxLength, 500);

      for (int i = 1; i <= 3; i++) {
        final vitalField = tester.widget<TextField>(textFields.at(i));
        expect(vitalField.maxLength, 8, reason: 'Vitals should have 8 char limit');
        expect(vitalField.decoration?.counterText, '');
      }
    });

    testWidgets('VitalsEntryStaff has length limits', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: VitalsEntryStaff(patientId: 'P001'),
      ));

      final textFields = find.byType(TextField);
      final count = textFields.evaluate().length;
      for (int i = 0; i < count; i++) {
        final textField = tester.widget<TextField>(textFields.at(i));
        expect(textField.maxLength, 8);
        expect(textField.decoration?.counterText, '');
      }
    });

    testWidgets('PatientCheckInScreen has registration limits', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PatientCheckInScreen(),
      ));

      // Name, ID, Age, Phone = 4 fields
      final textFields = find.byType(TextField);

      final nameField = tester.widget<TextField>(textFields.at(0));
      expect(nameField.maxLength, 100);

      final idField = tester.widget<TextField>(textFields.at(1));
      expect(idField.maxLength, 20);

      final ageField = tester.widget<TextField>(textFields.at(2));
      expect(ageField.maxLength, 3);

      final phoneField = tester.widget<TextField>(textFields.at(3));
      expect(phoneField.maxLength, 20);
    });
  });
}
