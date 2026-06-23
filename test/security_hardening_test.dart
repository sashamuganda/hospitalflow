import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/staff/staff_directory_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => AppState(),
        child: child,
      ),
    );
  }

  testWidgets('ClinicalNoteEditor has security hardening for input lengths', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const ClinicalNoteEditor(patientId: 'p005')));

    // SOAP Sections
    final soapHints = [
      'Patient-reported symptoms, history, and concerns...',
      'Examination findings, observations, measurements...',
      'Clinical impression, diagnoses, differential...',
      'Treatment plan, medications, follow-up, referrals...'
    ];

    for (final hint in soapHints) {
      final textFieldFinder = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText == hint
      );
      expect(textFieldFinder, findsOneWidget);
      final TextField textField = tester.widget(textFieldFinder);
      expect(textField.maxLength, 2000, reason: 'SOAP field with hint "$hint" should have maxLength 2000');
      expect(textField.decoration?.counterText, '', reason: 'SOAP field with hint "$hint" should suppress counterText');
    }

    // Diagnosis field
    final diagFinder = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.hintText == 'e.g. I10 - Essential Hypertension'
    );
    expect(diagFinder, findsOneWidget);
    final TextField diagField = tester.widget(diagFinder);
    expect(diagField.maxLength, 100, reason: 'Diagnosis field should have maxLength 100');
    expect(diagField.decoration?.counterText, '', reason: 'Diagnosis field should suppress counterText');
  });

  testWidgets('EmrHomeScreen search has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const EmrHomeScreen()));

    final searchFinder = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.hintText == 'Search by name, ID, or phone...'
    );
    expect(searchFinder, findsOneWidget);
    final TextField searchField = tester.widget(searchFinder);
    expect(searchField.maxLength, 100);
    expect(searchField.decoration?.counterText, '');
  });

  testWidgets('StaffDirectoryScreen search has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const StaffDirectoryScreen()));

    final searchFinder = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.hintText == 'Search by name...'
    );
    expect(searchFinder, findsOneWidget);
    final TextField searchField = tester.widget(searchFinder);
    expect(searchField.maxLength, 100);
    expect(searchField.decoration?.counterText, '');
  });

  testWidgets('LabOrderScreen notes has security hardening', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const LabOrderScreen(patientId: 'p001')));

    final notesFinder = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.hintText == 'Relevant clinical information for lab...'
    );
    expect(notesFinder, findsOneWidget);
    final TextField notesField = tester.widget(notesFinder);
    expect(notesField.maxLength, 500);
    expect(notesField.decoration?.counterText, '');
  });
}
