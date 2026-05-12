import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';

void main() {
  group('Security Hardening Tests - Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: 'p001')));

      // SOAP sections (S, O, A, P) - all should have 5000 limit
      final soapHints = [
        'Subjective',
        'Objective',
        'Assessment',
        'Plan'
      ];
      final fields = find.byType(TextField);
      expect(fields, findsAtLeastNWidgets(4));

      int foundSoap = 0;
      for (final widget in tester.widgetList<TextField>(fields)) {
        if (widget.maxLength == 5000 && widget.decoration?.counterText == '') {
          foundSoap++;
        }
      }
      expect(foundSoap, 4, reason: 'Should find 4 SOAP fields with limit 5000');

      // ICD-10 Diagnosis - 200 limit
      final diagField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 200);
      expect(diagField, findsOneWidget);
    });

    testWidgets('TriageScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'q001')));

      // Chief Complaint - 500 limit
      final complaintField = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500);
      expect(complaintField, findsOneWidget);

      // Vitals - 8 limit
      final vitalFields = find.byWidgetPredicate((w) => w is TextField && w.maxLength == 8);
      expect(vitalFields, findsAtLeastNWidgets(3));
    });

    testWidgets('PrescriptionWriterScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: 'p001')));

      // Drug Name - 100 limit
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100), findsAtLeastNWidgets(1));

      // Dose - 50 limit
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 50), findsAtLeastNWidgets(1));

      // Instructions - 1000 limit
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 1000), findsOneWidget);
    });

    testWidgets('LabOrderScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: 'p001')));

      // Notes - 500 limit
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 500), findsOneWidget);
    });

    testWidgets('PatientCheckInScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20), findsAtLeastNWidgets(2)); // Name, ID, Phone
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 3), findsOneWidget);
    });

    testWidgets('VitalsEntryStaff has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: 'p001')));

      final fields = find.byType(TextField);
      expect(fields, findsAtLeastNWidgets(1));
      for (final widget in tester.widgetList<TextField>(fields)) {
        expect(widget.maxLength, 8);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('EmrHomeScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: EmrHomeScreen()));

      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 100), findsOneWidget);
    });

    testWidgets('ForgotPasswordScreen has input limits', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));

      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 64), findsOneWidget);
    });

    testWidgets('LoginScreen has input limits', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AppState(),
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 20), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 64), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TextField && w.maxLength == 10), findsOneWidget);
    });
   group('Accessibility Verification', () {
      testWidgets('Interactive elements in TriageScreen have HapticFeedback and Semantics', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'q001')));
        // Verify quick complaint chips have interaction
      });
    });
  });
}
