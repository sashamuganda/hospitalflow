import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('ClinicalNoteEditor has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const ClinicalNoteEditor(patientId: '1')));

    final textFields = find.byType(TextField);
    // 4 SOAP fields + 1 ICD-10 field = 5
    expect(textFields, findsNWidgets(5));

    for (int i = 0; i < 4; i++) {
      final TextField soapField = tester.widget(textFields.at(i));
      expect(soapField.maxLength, 5000);
      expect(soapField.decoration?.counterText, '');
    }

    final TextField icdField = tester.widget(textFields.at(4));
    expect(icdField.maxLength, 200);
    expect(icdField.decoration?.counterText, '');
  });

  testWidgets('TriageScreen has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const TriageScreen(patientId: '1')));

    final complaintTF = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Describe the patient\'s main complaint...'));
    expect(complaintTF.maxLength, 500);
    expect(complaintTF.decoration?.counterText, '');

    final vitalsFields = find.byType(TextField);
    // 1 complaint + 3 vitals = 4
    for (int i = 1; i < 4; i++) {
      final TextField vitalsTF = tester.widget(vitalsFields.at(i));
      expect(vitalsTF.maxLength, 8);
      expect(vitalsTF.decoration?.counterText, '');
    }
  });

  testWidgets('PatientCheckInScreen has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const PatientCheckInScreen()));

    final nameField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.controller != null && w.decoration?.hintText == 'Patient full name'));
    expect(nameField.maxLength, 100);
    expect(nameField.decoration?.counterText, '');

    final idField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'ID number (optional)'));
    expect(idField.maxLength, 20);
    expect(idField.decoration?.counterText, '');

    final ageField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '0'));
    expect(ageField.maxLength, 3);
    expect(ageField.decoration?.counterText, '');

    final phoneField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '+254 7XX XXX XXX'));
    expect(phoneField.maxLength, 20);
    expect(phoneField.decoration?.counterText, '');
  });

  testWidgets('PrescriptionWriterScreen has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const PrescriptionWriterScreen(patientId: '1')));

    final nameField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Drug name'));
    expect(nameField.maxLength, 100);
    expect(nameField.decoration?.counterText, '');

    final doseField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Dose (e.g. 500mg)'));
    expect(doseField.maxLength, 50);
    expect(doseField.decoration?.counterText, '');

    final notesField = tester.widget<TextField>(find.byWidgetPredicate((w) => w is TextField && w.maxLines == 3));
    expect(notesField.maxLength, 1000);
    expect(notesField.decoration?.counterText, '');
  });

  testWidgets('LabOrderScreen has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const LabOrderScreen(patientId: '1')));

    final notesField = tester.widget<TextField>(find.byType(TextField));
    expect(notesField.maxLength, 500);
    expect(notesField.decoration?.counterText, '');
  });

  testWidgets('VitalsEntryStaff has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const VitalsEntryStaff(patientId: '1')));

    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(8));

    for (int i = 0; i < 8; i++) {
      final TextField tf = tester.widget(fields.at(i));
      expect(tf.maxLength, 8);
      expect(tf.decoration?.counterText, '');
    }
  });

  testWidgets('EmrHomeScreen has security length limits', (tester) async {
    await tester.pumpWidget(createTestableWidget(const EmrHomeScreen()));

    final searchField = tester.widget<TextField>(find.byType(TextField));
    expect(searchField.maxLength, 100);
    expect(searchField.decoration?.counterText, '');
  });
}
