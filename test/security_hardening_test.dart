import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';

void main() {
  group('Security Hardening Tests - Input Length Limits', () {
    testWidgets('ForgotPasswordScreen has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(2));

      final staffIdField = tester.widget<TextField>(textFields.at(0));
      expect(staffIdField.maxLength, 20);
      expect(staffIdField.decoration?.counterText, '');

      final emailField = tester.widget<TextField>(textFields.at(1));
      expect(emailField.maxLength, 64);
      expect(emailField.decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final nameField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Patient full name'));
      expect(nameField.maxLength, 100);
      expect(nameField.decoration?.counterText, '');

      final idField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'ID number (optional)'));
      expect(idField.maxLength, 20);
      expect(idField.decoration?.counterText, '');

      final ageField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0'));
      expect(ageField.maxLength, 3);
      expect(ageField.decoration?.counterText, '');

      final phoneField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '+254 7XX XXX XXX'));
      expect(phoneField.maxLength, 20);
      expect(phoneField.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'P1')));

      final complaintField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.maxLines == 2));
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.keyboardType == TextInputType.number);
      expect(vitalFields, findsAtLeastNWidgets(3));
      for (int i = 0; i < 3; i++) {
        final field = tester.widget<TextField>(vitalFields.at(i));
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('ClinicalNoteEditor has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: 'P1')));

      final soapFields = find.byWidgetPredicate((w) => w is TextField && w.maxLines == 4);
      expect(soapFields, findsNWidgets(4));
      for (int i = 0; i < 4; i++) {
        final field = tester.widget<TextField>(soapFields.at(i));
        expect(field.maxLength, 5000);
        expect(field.decoration?.counterText, '');
      }

      final diagField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('ICD-10') == true || w.decoration?.hintText?.contains('I10') == true)));
      expect(diagField.maxLength, 200);
      expect(diagField.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: 'P1')));

      final drugField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name'));
      expect(drugField.maxLength, 100);
      expect(drugField.decoration?.counterText, '');

      final doseField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('Dose') == true));
      expect(doseField.maxLength, 50);
      expect(doseField.decoration?.counterText, '');

      final notesField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.maxLines == 3));
      expect(notesField.maxLength, 1000);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: 'P1')));

      final notesField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.maxLines == 2));
      expect(notesField.maxLength, 500);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has correct maxLength and counterText', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: 'P1')));

      final vitalFields = find.byType(TextField);
      expect(vitalFields, findsAtLeastNWidgets(5));
      for (int i = 0; i < 5; i++) {
        final field = tester.widget<TextField>(vitalFields.at(i));
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });
  });
}
