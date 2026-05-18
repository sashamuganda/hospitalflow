import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  group('Security Hardening: Input Length Constraints', () {
    testWidgets('ClinicalNoteEditor has length limits on SOAP and Diagnosis', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'P-001')));

      final soapFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 5000);
      expect(soapFields, findsNWidgets(4));

      for (final field in tester.widgetList<TextField>(soapFields)) {
        expect(field.decoration?.counterText, '');
      }

      final diagField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 200);
      expect(diagField, findsOneWidget);
      expect(tester.widget<TextField>(diagField).decoration?.counterText, '');
    });

    testWidgets('TriageScreen has length limits on Complaint and Vitals', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'P-001')));

      final complaintField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500);
      expect(complaintField, findsOneWidget);
      expect(tester.widget<TextField>(complaintField).decoration?.counterText, '');

      final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 8);
      expect(vitalFields, findsNWidgets(3)); // Systolic, Diastolic, HR
      for (final field in tester.widgetList<TextField>(vitalFields)) {
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen has length limits on Drug, Dose, and Notes', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'P-001')));

      final drugField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100);
      expect(drugField, findsOneWidget);
      expect(tester.widget<TextField>(drugField).decoration?.counterText, '');

      final doseField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 50);
      expect(doseField, findsOneWidget);
      expect(tester.widget<TextField>(doseField).decoration?.counterText, '');

      final notesField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 1000);
      expect(notesField, findsOneWidget);
      expect(tester.widget<TextField>(notesField).decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has length limits on Clinical Notes', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'P-001')));

      final notesField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500);
      expect(notesField, findsOneWidget);
      expect(tester.widget<TextField>(notesField).decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen has length limits on Name, ID, Age, and Phone', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));

      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100 && w.decoration?.counterText == ''), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.counterText == ''), findsNWidgets(2)); // ID and Phone
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 3 && w.decoration?.counterText == ''), findsOneWidget); // Age
    });

    testWidgets('VitalsEntryStaff has length limits on all vital fields', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'P-001')));

      final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 8);
      expect(vitalFields, findsNWidgets(8));
      for (final field in tester.widgetList<TextField>(vitalFields)) {
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('LoginScreen and ForgotPasswordScreen have standardized Staff ID limits', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.hintText?.contains('DOC-2024') == true), findsOneWidget);

      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20 && w.decoration?.hintText?.contains('DOC-2024') == true), findsOneWidget);
    });
  });
}
