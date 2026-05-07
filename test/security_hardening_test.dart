import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';

void main() {
  group('Security Hardening Tests - Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: '1')));

      final soapHints = [
        'Patient-reported symptoms, history, and concerns...',
        'Examination findings, observations, measurements...',
        'Clinical impression, diagnoses, differential...',
        'Treatment plan, medications, follow-up, referrals...',
      ];

      for (final hint in soapHints) {
        final field = tester.widget<TextField>(find.widgetWithText(TextField, hint));
        expect(field.maxLength, 5000, reason: 'SOAP section with hint "$hint" should have 5000 char limit');
        expect(field.decoration?.counterText, '', reason: 'SOAP section with hint "$hint" should hide counter');
      }

      final diagField = tester.widget<TextField>(find.widgetWithText(TextField, 'e.g. I10 - Essential Hypertension'));
      expect(diagField.maxLength, 200, reason: 'Diagnosis field should have 200 char limit');
      expect(diagField.decoration?.counterText, '', reason: 'Diagnosis field should hide counter');
    });

    testWidgets('TriageScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

      final complaintField = tester.widget<TextField>(find.widgetWithText(TextField, 'Describe the patient\'s main complaint...'));
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final systolicField = tester.widget<TextField>(find.widgetWithText(TextField, '120'));
      expect(systolicField.maxLength, 8);
      expect(systolicField.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

      final drugNameField = tester.widget<TextField>(find.widgetWithText(TextField, 'Drug name'));
      expect(drugNameField.maxLength, 100);
      expect(drugNameField.decoration?.counterText, '');

      final doseField = tester.widget<TextField>(find.widgetWithText(TextField, 'Dose (e.g. 500mg)'));
      expect(drugNameField.maxLength, 100);
      expect(doseField.decoration?.counterText, '');

      final instructionsField = tester.widget<TextField>(find.widgetWithText(TextField, 'e.g. Take with food. Avoid alcohol. Return if symptoms worsen...'));
      expect(instructionsField.maxLength, 1000);
      expect(instructionsField.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: '1')));

      final notesField = tester.widget<TextField>(find.widgetWithText(TextField, 'Relevant clinical information for lab...'));
      expect(notesField.maxLength, 500);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final nameField = tester.widget<TextField>(find.widgetWithText(TextField, 'Patient full name'));
      expect(nameField.maxLength, 100);
      expect(nameField.decoration?.counterText, '');

      final idField = tester.widget<TextField>(find.widgetWithText(TextField, 'ID number (optional)'));
      expect(idField.maxLength, 20);
      expect(idField.decoration?.counterText, '');

      final ageField = tester.widget<TextField>(find.widgetWithText(TextField, '0'));
      expect(ageField.maxLength, 3);
      expect(ageField.decoration?.counterText, '');

      final phoneField = tester.widget<TextField>(find.widgetWithText(TextField, '+254 7XX XXX XXX'));
      expect(phoneField.maxLength, 20);
      expect(phoneField.decoration?.counterText, '');
    });
  });
}
