import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  group('Security Hardening: Input Length Constraints', () {
    testWidgets('ClinicalNoteEditor enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p1')));

      final fields = tester.widgetList<TextField>(find.byType(TextField));
      // S, O, A, P fields (4 fields) + Diagnosis (1 field) = 5
      expect(fields.length, 5);

      for (final field in fields) {
        expect(field.maxLength, isNotNull, reason: 'Field missing maxLength');
        expect(field.decoration?.counterText, '', reason: 'Field should hide counter');
      }

      expect(fields.first.maxLength, 5000);
      expect(fields.last.maxLength, 200);
    });

    testWidgets('TriageScreen enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q1')));

      // Chief Complaint
      final complaintField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('main complaint') == true)
      );
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      // Vitals (Systolic, Diastolic, HR)
      final vitalFields = tester.widgetList<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.keyboardType == TextInputType.number)
      );
      for (final field in vitalFields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p1')));

      // Drug name
      final nameField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name')
      );
      expect(nameField.maxLength, 100);
      expect(nameField.decoration?.counterText, '');

      // Dose
      final doseField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('Dose') == true)
      );
      expect(doseField.maxLength, 50);
      expect(doseField.decoration?.counterText, '');

      // Instructions
      final notesField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('Take with food') == true)
      );
      expect(notesField.maxLength, 1000);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p1')));

      final notesField = tester.widget<TextField>(find.byType(TextField));
      expect(notesField.maxLength, 500);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));

      // Name
      final nameField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('name') == true)
      );
      expect(nameField.maxLength, 100);
      expect(nameField.decoration?.counterText, '');

      // ID
      final idField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('ID') == true)
      );
      expect(idField.maxLength, 20);
      expect(idField.decoration?.counterText, '');

      // Age
      final ageField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0')
      );
      expect(ageField.maxLength, 3);
      expect(ageField.decoration?.counterText, '');

      // Phone
      final phoneField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.keyboardType == TextInputType.phone)
      );
      expect(phoneField.maxLength, 20);
      expect(phoneField.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff enforces length limits', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p1')));

      final fields = tester.widgetList<TextField>(find.byType(TextField));
      for (final field in fields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('Auth screens enforce length limits', (tester) async {
      // Login (already has them, but verifying)
      await tester.pumpWidget(wrap(const LoginScreen()));
      final staffIdLogin = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('DOC-') == true)
      );
      expect(staffIdLogin.maxLength, 20);

      // Forgot Password
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));
      final staffIdForgot = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('DOC-') == true)
      );
      expect(staffIdForgot.maxLength, 20);
      expect(staffIdForgot.decoration?.counterText, '');

      final emailField = tester.widget<TextField>(
        find.byWidgetPredicate((w) => w is TextField && w.keyboardType == TextInputType.emailAddress)
      );
      expect(emailField.maxLength, 64);
      expect(emailField.decoration?.counterText, '');
    });
  });
}
