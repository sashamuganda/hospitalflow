import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';

void main() {
  group('Security Hardening - Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ClinicalNoteEditor(patientId: '123'),
      ));

      final textFields = find.byType(TextField);
      // S, O, A, P sections + ICD-10
      expect(textFields, findsNWidgets(5));

      for (int i = 0; i < 4; i++) {
        final soapField = tester.widget<TextField>(textFields.at(i));
        expect(soapField.maxLength, 5000);
        expect(soapField.decoration?.counterText, '');
      }

      final diagField = tester.widget<TextField>(textFields.at(4));
      expect(diagField.maxLength, 200);
      expect(diagField.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TriageScreen(patientId: '123'),
      ));

      final complaintField = find.byType(TextField).first;
      final complaintWidget = tester.widget<TextField>(complaintField);
      expect(complaintWidget.maxLength, 500);
      expect(complaintWidget.decoration?.counterText, '');

      final vitalFields = find.descendant(
        of: find.byType(Row),
        matching: find.byType(TextField),
      );
      // Systolic, Diastolic, HR
      expect(vitalFields, findsNWidgets(3));

      for (int i = 0; i < 3; i++) {
        final vitalWidget = tester.widget<TextField>(vitalFields.at(i));
        expect(vitalWidget.maxLength, 8);
        expect(vitalWidget.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PrescriptionWriterScreen(patientId: '123'),
      ));

      // Initial drug item (name, dose) + instructions
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(3));

      final drugNameField = tester.widget<TextField>(textFields.at(0));
      expect(drugNameField.maxLength, 100);

      final doseField = tester.widget<TextField>(textFields.at(1));
      expect(doseField.maxLength, 50);

      final instructionField = tester.widget<TextField>(textFields.at(2));
      expect(instructionField.maxLength, 1000);
    });

    testWidgets('PatientCheckInScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PatientCheckInScreen(),
      ));

      // Name, ID, Age, Phone
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(4));

      final nameField = tester.widget<TextField>(textFields.at(0));
      expect(nameField.maxLength, 100);

      final idField = tester.widget<TextField>(textFields.at(1));
      expect(idField.maxLength, 20);

      final ageField = tester.widget<TextField>(textFields.at(2));
      expect(ageField.maxLength, 3);

      final phoneField = tester.widget<TextField>(textFields.at(3));
      expect(phoneField.maxLength, 20);
    });

    testWidgets('VitalsEntryStaff has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: VitalsEntryStaff(patientId: '123'),
      ));

      final vitalFields = find.byType(TextField);
      // 8 vitals: systolicBP, diastolicBP, heartRate, spO2, temp, rr, weight, height
      expect(vitalFields, findsNWidgets(8));

      for (int i = 0; i < 8; i++) {
        final vitalWidget = tester.widget<TextField>(vitalFields.at(i));
        expect(vitalWidget.maxLength, 8);
        expect(vitalWidget.decoration?.counterText, '');
      }
    });

    testWidgets('LabOrderScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LabOrderScreen(patientId: '123'),
      ));

      final notesField = find.byType(TextField).first;
      final notesWidget = tester.widget<TextField>(notesField);
      expect(notesWidget.maxLength, 500);
      expect(notesWidget.decoration?.counterText, '');
    });
  });
}
