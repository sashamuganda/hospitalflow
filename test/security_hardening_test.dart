import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';

void main() {
  group('Security Hardening Tests - Input Length Limits', () {
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

    testWidgets('TriageScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

      final complaintField = tester.widget<TextField>(find.byType(TextField).first);
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final vitalFields = tester.widgetList<TextField>(find.byType(TextField)).skip(1);
      for (final field in vitalFields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('VitalsEntryStaff has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: '1')));

      final vitalFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final field in vitalFields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('ClinicalNoteEditor has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: '1')));

      final fields = tester.widgetList<TextField>(find.byType(TextField));
      // 4 SOAP fields + 1 diagnosis field
      expect(fields.length, 5);

      for (int i = 0; i < 4; i++) {
        expect(fields.elementAt(i).maxLength, 5000);
        expect(fields.elementAt(i).decoration?.counterText, '');
      }

      expect(fields.last.maxLength, 200);
      expect(fields.last.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

      final drugNameField = tester.widget<TextField>(find.widgetWithText(TextField, 'Drug name'));
      expect(drugNameField.maxLength, 100);
      expect(drugNameField.decoration?.counterText, '');

      final doseField = tester.widget<TextField>(find.widgetWithText(TextField, 'Dose (e.g. 500mg)'));
      expect(doseField.maxLength, 50);
      expect(doseField.decoration?.counterText, '');

      final notesField = tester.widget<TextField>(find.byType(TextField).last);
      expect(notesField.maxLength, 1000);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has length limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: '1')));

      final notesField = tester.widget<TextField>(find.byType(TextField));
      expect(notesField.maxLength, 500);
      expect(notesField.decoration?.counterText, '');
    });
  });
}
