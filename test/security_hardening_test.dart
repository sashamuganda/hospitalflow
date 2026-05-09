import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
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

  void verifyField(WidgetTester tester, String hint, int maxLength) {
    final finder = find.byWidgetPredicate((w) =>
        w is TextField &&
        (w.decoration?.hintText == hint || w.decoration?.labelText == hint));
    expect(finder, findsAtLeast(1), reason: 'Field with hint/label "$hint" not found');

    final textField = tester.widget<TextField>(finder.first);
    expect(textField.maxLength, maxLength,
        reason: 'Field "$hint" should have maxLength $maxLength');
    expect(textField.decoration?.counterText, '',
        reason: 'Field "$hint" should have empty counterText');
  }

  testWidgets('TriageScreen has input limits', (tester) async {
    await tester.pumpWidget(wrap(const TriageScreen(patientId: 'p001')));
    verifyField(tester, 'Describe the patient\'s main complaint...', 500);
    verifyField(tester, '120', 8);
    verifyField(tester, '80', 8);
    verifyField(tester, '72', 8);
  });

  testWidgets('ClinicalNoteEditor has input limits', (tester) async {
    await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));
    verifyField(tester, 'Patient-reported symptoms, history, and concerns...', 5000);
    verifyField(tester, 'Examination findings, observations, measurements...', 5000);
    verifyField(tester, 'Clinical impression, diagnoses, differential...', 5000);
    verifyField(tester, 'Treatment plan, medications, follow-up, referrals...', 5000);
    verifyField(tester, 'e.g. I10 - Essential Hypertension', 200);
  });

  testWidgets('LabOrderScreen has input limits', (tester) async {
    await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));
    verifyField(tester, 'Relevant clinical information for lab...', 500);
  });

  testWidgets('PrescriptionWriterScreen has input limits', (tester) async {
    await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));
    verifyField(tester, 'Drug name', 100);
    verifyField(tester, 'Dose (e.g. 500mg)', 50);
    verifyField(tester, 'e.g. Take with food. Avoid alcohol. Return if symptoms worsen...', 1000);
  });

  testWidgets('PatientCheckInScreen has input limits', (tester) async {
    await tester.pumpWidget(wrap(const PatientCheckInScreen()));
    verifyField(tester, 'Patient full name', 100);
    verifyField(tester, 'ID number (optional)', 20);
    verifyField(tester, '0', 3);
    verifyField(tester, '+254 7XX XXX XXX', 20);
  });

  testWidgets('VitalsEntryStaff has input limits', (tester) async {
    await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));
    // All vitals fields use '—' as hint. We need to check them all.
    final vitalsFields = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '—');
    expect(vitalsFields, findsNWidgets(8));
    for (int i = 0; i < 8; i++) {
      final textField = tester.widget<TextField>(vitalsFields.at(i));
      expect(textField.maxLength, 8, reason: 'Vital field $i should have maxLength 8');
      expect(textField.decoration?.counterText, '', reason: 'Vital field $i should have empty counterText');
    }
  });

  testWidgets('LoginScreen has input limits (verification)', (tester) async {
    await tester.pumpWidget(wrap(const LoginScreen()));
    verifyField(tester, 'e.g. DOC-2024-001', 20);
    verifyField(tester, '••••••••', 64);
    verifyField(tester, 'MFH-001', 10);
  });
}
