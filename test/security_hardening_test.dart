import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  group('Security Hardening: Input Constraints', () {
    testWidgets('LoginScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));

      final staffIdField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'e.g. DOC-2024-001');
      expect((tester.widget(staffIdField) as TextField).maxLength, 20);
      expect((tester.widget(staffIdField) as TextField).decoration?.counterText, '');

      final passwordField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '••••••••');
      expect((tester.widget(passwordField) as TextField).maxLength, 64);
      expect((tester.widget(passwordField) as TextField).decoration?.counterText, '');

      final facilityField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'MFH-001');
      expect((tester.widget(facilityField) as TextField).maxLength, 10);
      expect((tester.widget(facilityField) as TextField).decoration?.counterText, '');
    });

    testWidgets('ForgotPasswordScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));

      final staffIdField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'e.g. DOC-2024-001');
      expect((tester.widget(staffIdField) as TextField).maxLength, 20);
      expect((tester.widget(staffIdField) as TextField).decoration?.counterText, '');
    });

    testWidgets('ClinicalNoteEditor enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p005')));

      // ClinicalNoteEditor uses _buildSoapSection which returns a TextField with hintText from hint parameter.
      // S: 'Patient-reported symptoms, history, and concerns...'
      final subjectiveField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('Patient-reported') ?? false));
      expect(subjectiveField, findsOneWidget);
      expect((tester.widget(subjectiveField) as TextField).maxLength, 5000);
      expect((tester.widget(subjectiveField) as TextField).decoration?.counterText, '');

      final diagnosisField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('Essential Hypertension') ?? false));
      expect(diagnosisField, findsOneWidget);
      expect((tester.widget(diagnosisField) as TextField).maxLength, 200);
      expect((tester.widget(diagnosisField) as TextField).decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p005')));

      final drugNameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name');
      expect(drugNameField, findsOneWidget);
      expect((tester.widget(drugNameField) as TextField).maxLength, 100);
      expect((tester.widget(drugNameField) as TextField).decoration?.counterText, '');

      final doseField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('500mg') ?? false));
      expect(doseField, findsAtLeastNWidgets(1));
      expect((tester.widget(doseField.first) as TextField).maxLength, 50);
      expect((tester.widget(doseField.first) as TextField).decoration?.counterText, '');

      final instructionsField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('food') ?? false));
      expect(instructionsField, findsOneWidget);
      expect((tester.widget(instructionsField) as TextField).maxLength, 1000);
      expect((tester.widget(instructionsField) as TextField).decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p005')));

      final notesField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('clinical information') ?? false));
      expect(notesField, findsOneWidget);
      expect((tester.widget(notesField) as TextField).maxLength, 500);
      expect((tester.widget(notesField) as TextField).decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));

      final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Patient full name');
      expect(nameField, findsOneWidget);
      expect((tester.widget(nameField) as TextField).maxLength, 100);
      expect((tester.widget(nameField) as TextField).decoration?.counterText, '');

      final idField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('ID number') ?? false));
      expect(idField, findsOneWidget);
      expect((tester.widget(idField) as TextField).maxLength, 20);
      expect((tester.widget(idField) as TextField).decoration?.counterText, '');

      final ageField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0');
      expect(ageField, findsOneWidget);
      expect((tester.widget(ageField) as TextField).maxLength, 3);
      expect((tester.widget(ageField) as TextField).decoration?.counterText, '');

      final phoneField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('+254') ?? false));
      expect(phoneField, findsOneWidget);
      expect((tester.widget(phoneField) as TextField).maxLength, 20);
      expect((tester.widget(phoneField) as TextField).decoration?.counterText, '');
    });

    testWidgets('TriageScreen enforces input limits', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q001')));

      final complaintField = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText?.contains('Describe') ?? false));
      expect(complaintField, findsOneWidget);
      expect((tester.widget(complaintField) as TextField).maxLength, 500);
      expect((tester.widget(complaintField) as TextField).decoration?.counterText, '');

      final bpField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '120');
      expect(bpField, findsOneWidget);
      expect((tester.widget(bpField) as TextField).maxLength, 8);
      expect((tester.widget(bpField) as TextField).decoration?.counterText, '');
    });
  });
}
