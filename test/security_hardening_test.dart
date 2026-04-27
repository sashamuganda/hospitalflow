import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';

void main() {
  testWidgets('ClinicalNoteEditor has security length limits on TextFields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ClinicalNoteEditor(patientId: 'test-patient-id'),
    ));

    // Find all TextFields
    final textFields = find.byType(TextField);

    // There should be 4 SOAP sections and 1 ICD-10 diagnosis section = 5 TextFields
    expect(textFields, findsNWidgets(5));

    // Get all TextField widgets to inspect their properties
    final List<TextField> widgets = textFields.evaluate().map((e) => e.widget as TextField).toList();

    // The first 4 should be SOAP (Subjective, Objective, Assessment, Plan)
    for (int i = 0; i < 4; i++) {
      expect(widgets[i].maxLength, 5000, reason: 'SOAP TextField $i missing maxLength: 5000');
      expect(widgets[i].decoration?.counterText, '', reason: 'SOAP TextField $i missing counterText suppression');
    }

    // The last one should be ICD-10
    expect(widgets[4].maxLength, 200, reason: 'ICD-10 TextField missing maxLength: 200');
    expect(widgets[4].decoration?.counterText, '', reason: 'ICD-10 TextField missing counterText suppression');
  });
}
