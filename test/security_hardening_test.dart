import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';

void main() {
  group('Security Hardening: Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has maxLength on SOAP and ICD-10 fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: 'p1')));

      final textFields = find.byType(TextField);
      // 4 SOAP sections + 1 ICD-10
      expect(textFields, findsAtLeastNWidgets(5));

      final soapField = tester.widget<TextField>(textFields.first);
      expect(soapField.maxLength, 5000);
      expect(soapField.decoration?.counterText, '');

      final icdField = tester.widget<TextField>(find.ancestor(
        of: find.byIcon(Icons.local_hospital_outlined),
        matching: find.byType(TextField),
      ));
      expect(icdField.maxLength, 200);
      expect(icdField.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has maxLength on Complaint and Vitals fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'q001')));

      final complaintField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.maxLines == 2
      ));
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final vitalFields = find.byWidgetPredicate(
        (w) => w is TextField && w.keyboardType == TextInputType.number
      );
      expect(vitalFields, findsAtLeastNWidgets(3));
      final vitalField = tester.widget<TextField>(vitalFields.first);
      expect(vitalField.maxLength, 8);
      expect(vitalField.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has maxLength on Drug, Dose and Notes', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: 'p1')));

      final drugField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'Drug name'
      ));
      expect(drugField.maxLength, 100);

      final doseField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'Dose (e.g. 500mg)'
      ));
      expect(doseField.maxLength, 50);

      final notesField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.maxLines == 3
      ));
      expect(notesField.maxLength, 1000);
    });

    testWidgets('PatientCheckInScreen has maxLength on Name, ID and Phone', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final nameField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'Patient full name'
      ));
      expect(nameField.maxLength, 100);

      final idField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'ID number (optional)'
      ));
      expect(idField.maxLength, 20);

      final phoneField = tester.widget<TextField>(find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == '+254 7XX XXX XXX'
      ));
      expect(phoneField.maxLength, 20);
    });

    testWidgets('EmrHomeScreen has maxLength on Search field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: EmrHomeScreen()));

      final searchField = tester.widget<TextField>(find.byType(TextField));
      expect(searchField.maxLength, 100);
      expect(searchField.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has maxLength on all vital fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: 'p001')));

      final vitalFields = find.byType(TextField);
      expect(vitalFields, findsAtLeastNWidgets(8));

      for (var i = 0; i < 8; i++) {
        final field = tester.widget<TextField>(vitalFields.at(i));
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });
  });
}
