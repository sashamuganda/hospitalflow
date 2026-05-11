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
import 'package:medflow_staff/features/auth/login_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  group('Security Hardening: Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has length limits', (tester) async {
      await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: 'p001')));
      final textFields = find.byType(TextField);
      expect(textFields, findsAtLeastNWidgets(2));

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull, reason: 'TextField missing maxLength');
        expect(widget.decoration?.counterText, '', reason: 'Counter should be hidden');
      }
    });

    testWidgets('TriageScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const TriageScreen(patientId: 'p001')));
      final textFields = find.byType(TextField);
      expect(textFields, findsAtLeastNWidgets(2));

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: 'p001')));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('LabOrderScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const LabOrderScreen(patientId: 'p001')));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('PatientCheckInScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const PatientCheckInScreen()));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('VitalsEntryStaff has length limits', (tester) async {
      await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: 'p001')));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('LoginScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const LoginScreen()));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('EmrHomeScreen has length limits', (tester) async {
      await tester.pumpWidget(wrap(const EmrHomeScreen()));
      final textFields = find.byType(TextField);

      for (final widget in tester.widgetList<TextField>(textFields)) {
        expect(widget.maxLength, isNotNull);
        expect(widget.decoration?.counterText, '');
      }
    });
  });
}
