import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';

void main() {
  group('Security Hardening: Input Length Constraints', () {
    testWidgets('ClinicalNoteEditor has correct maxLength and suppressed counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: '1')));

      final textFields = find.byType(TextField);
      expect(textFields, findsAtLeastNWidgets(5));

      final soapHints = [
        'Patient-reported symptoms, history, and concerns...',
        'Examination findings, observations, measurements...',
        'Clinical impression, diagnoses, differential...',
        'Treatment plan, medications, follow-up, referrals...',
      ];

      for (final hint in soapHints) {
        final field = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == hint);
        expect(field, findsOneWidget, reason: 'Field with hint "$hint" not found');
        final TextField widget = tester.widget(field);
        expect(widget.maxLength, 2000);
        expect(widget.decoration?.counterText, '');
      }

      final diagField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'e.g. I10 - Essential Hypertension');
      expect(diagField, findsOneWidget);
      final TextField diagWidget = tester.widget(diagField);
      expect(diagWidget.maxLength, 150);
      expect(diagWidget.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has correct maxLength and suppressed counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

      final complaintField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Describe the patient\'s main complaint...');
      expect(complaintField, findsOneWidget);
      final TextField complaintWidget = tester.widget(complaintField);
      expect(complaintWidget.maxLength, 500);
      expect(complaintWidget.decoration?.counterText, '');

      final vitalHints = ['120', '80', '72'];
      for (final hint in vitalHints) {
        final field = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == hint);
        expect(field, findsOneWidget);
        final TextField widget = tester.widget(field);
        expect(widget.maxLength, 10);
        expect(widget.decoration?.counterText, '');
      }
    });

    testWidgets('PatientCheckInScreen has correct maxLength and suppressed counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final fields = {
        'Patient full name': 100,
        'ID number (optional)': 50,
        '0': 3,
        '+254 7XX XXX XXX': 20,
      };

      fields.forEach((hint, length) {
        final field = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == hint);
        expect(field, findsOneWidget, reason: 'Field with hint "$hint" not found');
        final TextField widget = tester.widget(field);
        expect(widget.maxLength, length);
        expect(widget.decoration?.counterText, '');
      });
    });

    testWidgets('PrescriptionWriterScreen has correct maxLength and suppressed counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

      final noteField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText?.contains('Take with food') == true);
      expect(noteField, findsOneWidget);
      final TextField noteWidget = tester.widget(noteField);
      expect(noteWidget.maxLength, 500);
      expect(noteWidget.decoration?.counterText, '');

      final drugField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name');
      expect(drugField, findsOneWidget);
      final TextField drugWidget = tester.widget(drugField);
      expect(drugWidget.maxLength, 100);
      expect(drugWidget.decoration?.counterText, '');

      final doseField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Dose (e.g. 500mg)');
      expect(doseField, findsOneWidget);
      final TextField doseWidget = tester.widget(doseField);
      expect(doseWidget.maxLength, 50);
      expect(doseWidget.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has correct maxLength and suppressed counter', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: '1')));

      final vitalFields = find.byType(TextField);
      expect(vitalFields, findsAtLeastNWidgets(8));

      for (int i = 0; i < 8; i++) {
        final TextField widget = tester.widget(vitalFields.at(i));
        expect(widget.maxLength, 10);
        expect(widget.decoration?.counterText, '');
      }
    });
  });
}
