import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';

void main() {
  group('Security Hardening: Input Length Limits', () {
    testWidgets('PatientCheckInScreen has length limits on demographic fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

      final textFields = tester.widgetList<TextField>(find.byType(TextField)).toList();

      // Full Name
      expect(textFields[0].maxLength, 100);
      expect(textFields[0].decoration?.counterText, '');

      // National ID
      expect(textFields[1].maxLength, 20);
      expect(textFields[1].decoration?.counterText, '');

      // Age
      expect(textFields[2].maxLength, 3);
      expect(textFields[2].decoration?.counterText, '');

      // Phone Number
      expect(textFields[3].maxLength, 20);
      expect(textFields[3].decoration?.counterText, '');
    });

    testWidgets('TriageScreen has length limits on clinical fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'p001')));

      final complaintField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.maxLines == 2));
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final vitalFields = tester.widgetList<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.keyboardType == TextInputType.number)).toList();

      for (var field in vitalFields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });

    testWidgets('ClinicalNoteEditor has length limits on SOAP and diagnosis fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: 'p001')));

      // SOAP sections (maxLines: 4)
      final soapFields = tester.widgetList<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.maxLines == 4)).toList();

      expect(soapFields.length, 4);
      for (var field in soapFields) {
        expect(field.maxLength, 5000);
        expect(field.decoration?.counterText, '');
      }

      // Diagnosis field
      final diagField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.maxLines == 1 && widget.decoration?.hintText?.contains('I10') == true));
      expect(diagField.maxLength, 200);
      expect(diagField.decoration?.counterText, '');
    });

    testWidgets('PrescriptionWriterScreen has length limits on Rx items and instructions', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: 'p001')));

      // Drug Name
      final nameField = tester.widgetList<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText == 'Drug name')).first;
      expect(nameField.maxLength, 100);
      expect(nameField.decoration?.counterText, '');

      // Dose
      final doseField = tester.widgetList<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText?.contains('Dose') == true)).first;
      expect(doseField.maxLength, 50);
      expect(doseField.decoration?.counterText, '');

      // Additional Instructions
      final notesField = tester.widget<TextField>(find.byWidgetPredicate(
        (widget) => widget is TextField && widget.maxLines == 3));
      expect(notesField.maxLength, 1000);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('VitalsEntryStaff has length limits on all vital fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: VitalsEntryStaff(patientId: 'p001')));

      final vitalFields = tester.widgetList<TextField>(find.byType(TextField)).toList();

      expect(vitalFields.length, 8);
      for (var field in vitalFields) {
        expect(field.maxLength, 8);
        expect(field.decoration?.counterText, '');
      }
    });
  });
}
