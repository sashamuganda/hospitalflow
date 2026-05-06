import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('Security Hardening: Input Length Limits', () {
    testWidgets('ClinicalNoteEditor has length limits on SOAP and Diagnosis fields', (tester) async {
      await tester.pumpWidget(createTestWidget(const ClinicalNoteEditor(patientId: '1')));

      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(5)); // S, O, A, P, Diagnosis

      for (int i = 0; i < 4; i++) {
        final soapField = tester.widget<TextField>(textFields.at(i));
        expect(soapField.maxLength, 5000);
        expect(soapField.decoration?.counterText, '');
      }

      final diagField = tester.widget<TextField>(textFields.at(4));
      expect(diagField.maxLength, 200);
      expect(diagField.decoration?.counterText, '');
    });

    testWidgets('TriageScreen has length limits on Chief Complaint and Vitals', (tester) async {
      await tester.pumpWidget(createTestWidget(const TriageScreen(patientId: '1')));

      final complaintFieldFind = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration?.hintText?.contains('Describe') == true);
      expect(complaintFieldFind, findsOneWidget);

      final complaintField = tester.widget<TextField>(complaintFieldFind);
      expect(complaintField.maxLength, 500);
      expect(complaintField.decoration?.counterText, '');

      final vitalFields = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.keyboardType == TextInputType.number);
      // Systolic, Diastolic, Heart Rate. SpO2 and Temp are not in the grid currently in the code I saw.
      // Wait, let me check triage_screen.dart again.
      // _buildVitalsGrid only has 3 fields.
      expect(vitalFields, findsNWidgets(3));

      for (int i = 0; i < 3; i++) {
        final vitalField = tester.widget<TextField>(vitalFields.at(i));
        expect(vitalField.maxLength, 8);
        expect(vitalField.decoration?.counterText, '');
      }
    });

    testWidgets('PrescriptionWriterScreen has length limits on Drug, Dose, and Notes', (tester) async {
      await tester.pumpWidget(createTestWidget(const PrescriptionWriterScreen(patientId: '1')));

      final drugNameField = tester.widget<TextField>(find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration?.hintText == 'Drug name'));
      expect(drugNameField.maxLength, 100);
      expect(drugNameField.decoration?.counterText, '');

      final doseField = tester.widget<TextField>(find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration?.hintText?.contains('Dose') == true));
      expect(doseField.maxLength, 50);
      expect(doseField.decoration?.counterText, '');

      final notesField = tester.widget<TextField>(find.byWidgetPredicate((widget) =>
        widget is TextField && widget.maxLines == 3));
      expect(notesField.maxLength, 1000);
      expect(notesField.decoration?.counterText, '');
    });

    testWidgets('LabOrderScreen has length limits on Clinical Notes', (tester) async {
      await tester.pumpWidget(createTestWidget(const LabOrderScreen(patientId: '1')));

      final notesField = tester.widget<TextField>(find.byType(TextField));
      expect(notesField.maxLength, 500);
      expect(notesField.decoration?.counterText, '');
    });
  });
}
