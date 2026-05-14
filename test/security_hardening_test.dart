import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  group('Security Hardening - Input Constraints', () {
    testWidgets(
        'TriageScreen should have maxLength on Chief Complaint and Vitals',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: TriageScreen(patientId: '1')));

      final complaintField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Describe the patient') == true);
      expect(complaintField, findsOneWidget);
      final TextField complaintWidget = tester.widget(complaintField);
      expect(complaintWidget.maxLength, 500);
      expect(complaintWidget.decoration?.counterText, '');

      final systolicField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == '120');
      expect(systolicField, findsOneWidget);
      final TextField systolicWidget = tester.widget(systolicField);
      expect(systolicWidget.maxLength, 8);
      expect(systolicWidget.decoration?.counterText, '');
    });

    testWidgets(
        'ForgotPasswordScreen should have correct maxLength on Staff ID and Email',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));

      final staffIdField = find.byWidgetPredicate((w) =>
          w is TextField && w.decoration?.hintText == 'e.g. DOC-2024-001');
      expect(staffIdField, findsOneWidget);
      final TextField staffIdWidget = tester.widget(staffIdField);
      expect(staffIdWidget.maxLength, 20);
      expect(staffIdWidget.decoration?.counterText, '');

      final emailField = find.byWidgetPredicate((w) =>
          w is TextField && w.decoration?.hintText == 'staff@medflow.hospital');
      expect(emailField, findsOneWidget);
      final TextField emailWidget = tester.widget(emailField);
      expect(emailWidget.maxLength, 64);
      expect(emailWidget.decoration?.counterText, '');
    });

    testWidgets(
        'LoginScreen should have correct maxLength on Staff ID, Password, and Facility Code',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AppState(),
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      final staffIdField = find.byWidgetPredicate((w) =>
          w is TextField && w.decoration?.hintText == 'e.g. DOC-2024-001');
      expect(staffIdField, findsOneWidget);
      final TextField staffIdWidget = tester.widget(staffIdField);
      expect(staffIdWidget.maxLength, 20);
      expect(staffIdWidget.decoration?.counterText, '');

      final passwordField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == '••••••••');
      expect(passwordField, findsOneWidget);
      final TextField passwordWidget = tester.widget(passwordField);
      expect(passwordWidget.maxLength, 64);
      expect(passwordWidget.decoration?.counterText, '');

      final facilityField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'MFH-001');
      expect(facilityField, findsOneWidget);
      final TextField facilityWidget = tester.widget(facilityField);
      expect(facilityWidget.maxLength, 10);
      expect(facilityWidget.decoration?.counterText, '');
    });

    testWidgets(
        'ClinicalNoteEditor should have maxLength on SOAP and Diagnosis',
        (WidgetTester tester) async {
      // Use larger size to ensure all fields are rendered in SingleChildScrollView
      tester.view.physicalSize = const Size(2400, 3600);
      addTearDown(tester.view.resetPhysicalSize);

      await tester
          .pumpWidget(MaterialApp(home: ClinicalNoteEditor(patientId: '1')));

      final subjectiveField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Patient-reported symptoms') ==
              true);
      expect(subjectiveField, findsOneWidget);
      final TextField subjectiveWidget = tester.widget(subjectiveField);
      expect(subjectiveWidget.maxLength, 5000);
      expect(subjectiveWidget.decoration?.counterText, '');

      final objectiveField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Examination findings') == true);
      expect(objectiveField, findsOneWidget);

      final diagField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Essential Hypertension') == true);
      expect(diagField, findsOneWidget);
      final TextField diagWidget = tester.widget(diagField);
      expect(diagWidget.maxLength, 200);
      expect(diagWidget.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen should have maxLength on drug fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

      final drugField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'Drug name');
      expect(drugField, findsOneWidget);
      final TextField drugWidget = tester.widget(drugField);
      expect(drugWidget.maxLength, 100);
      expect(drugWidget.decoration?.counterText, '');

      final noteField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Take with food') == true);
      expect(noteField, findsOneWidget);
      final TextField noteWidget = tester.widget(noteField);
      expect(noteWidget.maxLength, 1000);
      expect(noteWidget.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen should have maxLength on notes',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: LabOrderScreen(patientId: '1')));

      final noteField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('Relevant clinical information') ==
              true);
      expect(noteField, findsOneWidget);
      final TextField noteWidget = tester.widget(noteField);
      expect(noteWidget.maxLength, 500);
      expect(noteWidget.decoration?.counterText, '');
    });

    testWidgets(
        'PatientCheckInScreen should have maxLength on registration fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final nameField = find.byWidgetPredicate((w) =>
          w is TextField && w.decoration?.hintText == 'Patient full name');
      expect(nameField, findsOneWidget);
      final TextField nameWidget = tester.widget(nameField);
      expect(nameWidget.maxLength, 100);
      expect(nameWidget.decoration?.counterText, '');

      final idField = find.byWidgetPredicate((w) =>
          w is TextField &&
          w.decoration?.hintText?.contains('ID number') == true);
      expect(idField, findsOneWidget);
      final TextField idWidget = tester.widget(idField);
      expect(idWidget.maxLength, 20);
      expect(idWidget.decoration?.counterText, '');

      final ageField = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == '0');
      expect(ageField, findsOneWidget);
      final TextField ageWidget = tester.widget(ageField);
      expect(ageWidget.maxLength, 3);
      expect(ageWidget.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff should have maxLength on vital signs',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: VitalsEntryStaff(patientId: '1')));

      final vitalsField = find.byType(TextField).first;
      final TextField vitalsWidget = tester.widget(vitalsField);
      expect(vitalsWidget.maxLength, 8);
      expect(vitalsWidget.decoration?.counterText, '');
    });
  });
}
