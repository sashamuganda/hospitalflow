import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';

void main() {
  testWidgets('ClinicalNoteEditor has length limits', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ClinicalNoteEditor(patientId: '1')));
    final textFields = find.byType(TextField);

    // S, O, A, P fields (5000) and Diagnosis field (200)
    expect(textFields, findsNWidgets(5));

    for (int i = 0; i < 4; i++) {
      final TextField soapField = tester.widget(textFields.at(i));
      expect(soapField.maxLength, 5000);
      expect(soapField.decoration?.counterText, '');
    }

    final TextField diagField = tester.widget(textFields.at(4));
    expect(diagField.maxLength, 200);
  });

  testWidgets('TriageScreen has length limits', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

    final complaintField = tester.widget<TextField>(find.widgetWithText(TextField, 'Describe the patient\'s main complaint...'));
    expect(complaintField.maxLength, 500);
    expect(complaintField.decoration?.counterText, '');

    final systolicField = tester.widget<TextField>(find.widgetWithText(TextField, '120'));
    expect(systolicField.maxLength, 8);
    expect(systolicField.decoration?.counterText, '');
  });

  testWidgets('PrescriptionWriterScreen has length limits', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrescriptionWriterScreen(patientId: '1')));

    final drugNameField = tester.widget<TextField>(find.widgetWithText(TextField, 'Drug name'));
    expect(drugNameField.maxLength, 100);

    final doseField = tester.widget<TextField>(find.widgetWithText(TextField, 'Dose (e.g. 500mg)'));
    expect(doseField.maxLength, 50);

    final notesField = tester.widget<TextField>(find.widgetWithText(TextField, 'e.g. Take with food. Avoid alcohol. Return if symptoms worsen...'));
    expect(notesField.maxLength, 1000);
    expect(notesField.decoration?.counterText, '');
  });

  testWidgets('PatientCheckInScreen has length limits', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

    final nameField = tester.widget<TextField>(find.widgetWithText(TextField, 'Patient full name'));
    expect(nameField.maxLength, 100);

    final idField = tester.widget<TextField>(find.widgetWithText(TextField, 'ID number (optional)'));
    expect(idField.maxLength, 20);

    final ageField = tester.widget<TextField>(find.widgetWithText(TextField, '0'));
    expect(ageField.maxLength, 3);

    final phoneField = tester.widget<TextField>(find.widgetWithText(TextField, '+254 7XX XXX XXX'));
    expect(phoneField.maxLength, 20);
  });

  testWidgets('LabOrderScreen has length limits', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LabOrderScreen(patientId: '1')));

    final notesField = tester.widget<TextField>(find.widgetWithText(TextField, 'Relevant clinical information for lab...'));
    expect(notesField.maxLength, 500);
    expect(notesField.decoration?.counterText, '');
  });
}
