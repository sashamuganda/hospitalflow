import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  group('Security Hardening: Input Length Constraints', () {
    testWidgets('ClinicalNoteEditor has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      // 4 SOAP fields + 1 Diagnosis field = 5
      expect(textFields, findsNWidgets(5));

      final List<int> expectedLimits = [5000, 5000, 5000, 5000, 200];

      for (int i = 0; i < 5; i++) {
        final textField = tester.widget<TextField>(textFields.at(i));
        expect(textField.maxLength, expectedLimits[i], reason: 'Field $i has wrong maxLength');
        expect(textField.decoration?.counterText, '', reason: 'Field $i has counterText shown');
      }
    });

    testWidgets('PrescriptionWriterScreen has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));
      await tester.pumpAndSettle();

      // Note: Prescription writer starts with 1 medication item (Drug, Dose) + 1 Instructions = 3 fields
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(3));

      // Drug name (100), Dose (50), Instructions (1000)
      expect(tester.widget<TextField>(textFields.at(0)).maxLength, 100);
      expect(tester.widget<TextField>(textFields.at(1)).maxLength, 50);
      expect(tester.widget<TextField>(textFields.at(2)).maxLength, 1000);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('TriageScreen has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q001')));
      await tester.pumpAndSettle();

      // Chief complaint (1) + Vitals (3) = 4 TextFields
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(4));

      // Complaint is first
      expect(tester.widget<TextField>(textFields.at(0)).maxLength, 500);
      expect(tester.widget<TextField>(textFields.at(0)).decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));
      await tester.pumpAndSettle();

      // Name, ID, Age, Phone = 4 fields
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(4));

      final expectedLimits = [100, 20, 3, 20];
      for (int i = 0; i < 4; i++) {
        expect(tester.widget<TextField>(textFields.at(i)).maxLength, expectedLimits[i]);
        expect(tester.widget<TextField>(textFields.at(i)).decoration?.counterText, '');
      }
    });

    testWidgets('LabOrderScreen has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));
      await tester.pumpAndSettle();

      // Only 1 notes field visible initially
      final notesFinder = find.byType(TextField);
      expect(notesFinder, findsOneWidget);
      expect(tester.widget<TextField>(notesFinder).maxLength, 500);
      expect(tester.widget<TextField>(notesFinder).decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));
      await tester.pumpAndSettle();

      final vitalsFields = find.byType(TextField);
      expect(vitalsFields, findsNWidgets(8));

      for (final widget in tester.widgetList<TextField>(vitalsFields)) {
        expect(widget.maxLength, 8);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('Auth Screens have correct maxLength and counter suppression', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));
      await tester.pumpAndSettle();

      // Staff ID, Password, Facility = 3 fields
      final loginFields = find.byType(TextField);
      expect(loginFields, findsNWidgets(3));
      expect(tester.widget<TextField>(loginFields.at(0)).maxLength, 20);
      expect(tester.widget<TextField>(loginFields.at(1)).maxLength, 64);
      expect(tester.widget<TextField>(loginFields.at(2)).maxLength, 10);

      // Forgot Password Screen
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));
      await tester.pumpAndSettle();

      // Staff ID, Email = 2 fields
      final forgotFields = find.byType(TextField);
      expect(forgotFields, findsNWidgets(2));
      expect(tester.widget<TextField>(forgotFields.at(0)).maxLength, 20);
      expect(tester.widget<TextField>(forgotFields.at(1)).maxLength, 64);
      expect(tester.widget<TextField>(forgotFields.at(0)).decoration?.counterText, '');
      expect(tester.widget<TextField>(forgotFields.at(1)).decoration?.counterText, '');
    });
  });
}
