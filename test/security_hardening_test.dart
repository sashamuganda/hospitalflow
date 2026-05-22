import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        home: Scaffold(body: child),
      ),
    );
  }

  void verifyField(WidgetTester tester, String hint, int expectedLength) {
    final finder = find.byWidgetPredicate((w) =>
        w is TextField && (w.decoration?.hintText?.contains(hint) ?? false));
    expect(finder, findsAtLeastNWidgets(1), reason: 'Field with hint containing "$hint" not found');

    final tf = tester.widget<TextField>(finder.first);
    expect(tf.maxLength, expectedLength,
        reason: 'Field "$hint" should have maxLength $expectedLength');
    expect(tf.decoration?.counterText, '',
        reason: 'Field "$hint" should have counterText suppressed');
  }

  group('Security Hardening Tests', () {
    testWidgets('LoginScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));
      verifyField(tester, 'DOC-2024-001', 20);
      verifyField(tester, '••••••••', 64);
      verifyField(tester, 'MFH-001', 10);
    });

    testWidgets('ForgotPasswordScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));
      verifyField(tester, 'DOC-2024-001', 20);
      verifyField(tester, 'staff@medflow.hospital', 64);
    });

    testWidgets('ClinicalNoteEditor should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));
      verifyField(tester, 'Patient-reported', 5000);
      verifyField(tester, 'Examination findings', 5000);
      verifyField(tester, 'Clinical impression', 5000);
      verifyField(tester, 'Treatment plan', 5000);
      verifyField(tester, 'I10 - Essential', 200);
    });

    testWidgets('TriageScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q001')));
      verifyField(tester, 'Describe the patient', 500);
      verifyField(tester, '120', 8); // Systolic
      verifyField(tester, '80', 8);  // Diastolic
      verifyField(tester, '72', 8);  // HR
    });

    testWidgets('PrescriptionWriterScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));
      verifyField(tester, 'Drug name', 100);
      verifyField(tester, 'Dose', 50);
      verifyField(tester, 'Take with food', 1000);
    });

    testWidgets('LabOrderScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));
      verifyField(tester, 'Relevant clinical information', 500);
    });

    testWidgets('PatientCheckInScreen should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));
      verifyField(tester, 'full name', 100);
      verifyField(tester, 'ID number', 20);
      verifyField(tester, '0', 3); // Age
      verifyField(tester, '7XX', 20); // Phone
    });

    testWidgets('VitalsEntryStaff should have length limits', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));
      final fields = find.byType(TextField);
      expect(fields, findsAtLeastNWidgets(1));
      for (final field in tester.widgetList<TextField>(fields)) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });
  });
}
