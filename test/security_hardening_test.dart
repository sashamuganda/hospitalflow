import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';

void main() {
  late AppState appState;

  setUp(() {
    appState = AppState();
  });

  Widget wrap(Widget child) {
    return ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('Security Hardening: Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));

      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(5)); // S, O, A, P, Diagnosis

      // SOAP fields
      for (int i = 0; i < 4; i++) {
        final TextField tf = tester.widget(textFields.at(i));
        expect(tf.maxLength, 5000);
        expect(tf.decoration?.counterText, '');
      }

      // Diagnosis field
      final TextField diagTf = tester.widget(textFields.at(4));
      expect(diagTf.maxLength, 200);
      expect(diagTf.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'q001')));

      // Chief Complaint
      final complaintTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('complaint') == true);
      expect(complaintTf, findsOneWidget);
      final TextField tf = tester.widget(complaintTf);
      expect(tf.maxLength, 500);
      expect(tf.decoration?.counterText, '');

      // Vitals fields (Systolic, Diastolic, Heart Rate)
      final vitalsTfs = find.byWidgetPredicate((w) => w is TextField && (w.decoration?.hintText == '120' || w.decoration?.hintText == '80' || w.decoration?.hintText == '72'));
      expect(vitalsTfs, findsNWidgets(3));
      for (int i = 0; i < 3; i++) {
        final TextField vtf = tester.widget(vitalsTfs.at(i));
        expect(vtf.maxLength, 8);
        expect(vtf.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));

      // Additional Instructions
      final notesTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('food') == true);
      expect(notesTf, findsOneWidget);
      final TextField ntf = tester.widget(notesTf);
      expect(ntf.maxLength, 1000);
      expect(ntf.decoration?.counterText, '');

      // Drug Name and Dose in the first Rx card
      final drugNameTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name');
      final doseTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('Dose') == true);

      expect(tester.widget<TextField>(drugNameTf).maxLength, 100);
      expect(tester.widget<TextField>(drugNameTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(doseTf).maxLength, 50);
      expect(tester.widget<TextField>(doseTf).decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));

      final notesTf = find.byType(TextField);
      expect(notesTf, findsOneWidget);
      final TextField tf = tester.widget(notesTf);
      expect(tf.maxLength, 500);
      expect(tf.decoration?.counterText, '');
    });

    testWidgets('PatientCheckInScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));

      final nameTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('full name') == true);
      final idTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('ID number') == true);
      final ageTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0');
      final phoneTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('7XX') == true);

      expect(tester.widget<TextField>(nameTf).maxLength, 100);
      expect(tester.widget<TextField>(nameTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(idTf).maxLength, 20);
      expect(tester.widget<TextField>(idTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(ageTf).maxLength, 3);
      expect(tester.widget<TextField>(ageTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(phoneTf).maxLength, 20);
      expect(tester.widget<TextField>(phoneTf).decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));

      final vitalsTfs = find.byType(TextField);
      expect(vitalsTfs, findsNWidgets(8));

      for (int i = 0; i < 8; i++) {
        final TextField tf = tester.widget(vitalsTfs.at(i));
        expect(tf.maxLength, 8);
        expect(tf.decoration?.counterText, '');
      }
    });

    testWidgets('LoginScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));

      final staffIdTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('DOC-2024') == true);
      final passwordTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '••••••••');
      final facilityTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'MFH-001');

      expect(tester.widget<TextField>(staffIdTf).maxLength, 20);
      expect(tester.widget<TextField>(staffIdTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(passwordTf).maxLength, 64);
      expect(tester.widget<TextField>(passwordTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(facilityTf).maxLength, 10);
      expect(tester.widget<TextField>(facilityTf).decoration?.counterText, '');
    });

    testWidgets('ForgotPasswordScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const ForgotPasswordScreen()));

      final staffIdTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('DOC-2024') == true);
      final emailTf = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('medflow.hospital') == true);

      expect(tester.widget<TextField>(staffIdTf).maxLength, 20);
      expect(tester.widget<TextField>(staffIdTf).decoration?.counterText, '');

      expect(tester.widget<TextField>(emailTf).maxLength, 64);
      expect(tester.widget<TextField>(emailTf).decoration?.counterText, '');
    });

    testWidgets('EmrHomeScreen has correct limits', (tester) async {
      await tester.pumpWidget(wrap(const EmrHomeScreen()));

      final searchTf = find.byType(TextField);
      expect(searchTf, findsOneWidget);
      final TextField tf = tester.widget(searchTf);
      expect(tf.maxLength, 100);
      expect(tf.decoration?.counterText, '');
    });
  });
}
