import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';

void main() {
  testWidgets('ClinicalNoteEditor has hardened input fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: ClinicalNoteEditor(patientId: 'p001')));

    final soapHints = [
      'Patient-reported symptoms, history, and concerns...',
      'Examination findings, observations, measurements...',
      'Clinical impression, diagnoses, differential...',
      'Treatment plan, medications, follow-up, referrals...',
    ];

    for (final hint in soapHints) {
      final textField = find.byWidgetPredicate((widget) =>
          widget is TextField && widget.decoration?.hintText == hint);
      expect(textField, findsOneWidget,
          reason: 'TextField with hint "$hint" not found');
      final widget = tester.widget<TextField>(textField);
      expect(widget.maxLength, 5000,
          reason: 'TextField with hint "$hint" should have maxLength 5000');
      expect(widget.decoration?.counterText, '',
          reason: 'TextField with hint "$hint" should hide counter');
    }

    final diagField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'e.g. I10 - Essential Hypertension');
    expect(diagField, findsOneWidget);
    final diagWidget = tester.widget<TextField>(diagField);
    expect(diagWidget.maxLength, 200);
    expect(diagWidget.decoration?.counterText, '');
  });

  testWidgets('TriageScreen has hardened input fields',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: TriageScreen(patientId: 'p001')));

    final complaintField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText ==
            'Describe the patient\'s main complaint...');
    expect(complaintField, findsOneWidget);
    final complaintWidget = tester.widget<TextField>(complaintField);
    expect(complaintWidget.maxLength, 500);
    expect(complaintWidget.decoration?.counterText, '');

    final vitalHints = [
      '120',
      '80',
      '72'
    ]; // Systolic, Diastolic, Heart Rate hints
    for (final hint in vitalHints) {
      final field = find.byWidgetPredicate((widget) =>
          widget is TextField && widget.decoration?.hintText == hint);
      expect(field, findsOneWidget);
      final widget = tester.widget<TextField>(field);
      expect(widget.maxLength, 8);
      expect(widget.decoration?.counterText, '');
    }
  });

  testWidgets('PatientCheckInScreen has hardened input fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PatientCheckInScreen()));

    final nameField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'Patient full name');
    expect(nameField, findsOneWidget);
    expect(tester.widget<TextField>(nameField).maxLength, 100);
    expect(tester.widget<TextField>(nameField).decoration?.counterText, '');

    final idField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'ID number (optional)');
    expect(idField, findsOneWidget);
    expect(tester.widget<TextField>(idField).maxLength, 20);
    expect(tester.widget<TextField>(idField).decoration?.counterText, '');

    final ageField = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText == '0');
    expect(ageField, findsOneWidget);
    expect(tester.widget<TextField>(ageField).maxLength, 3);
    expect(tester.widget<TextField>(ageField).decoration?.counterText, '');

    final phoneField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == '+254 7XX XXX XXX');
    expect(phoneField, findsOneWidget);
    expect(tester.widget<TextField>(phoneField).maxLength, 20);
    expect(tester.widget<TextField>(phoneField).decoration?.counterText, '');
  });

  testWidgets('PrescriptionWriterScreen has hardened input fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: PrescriptionWriterScreen(patientId: 'p001')));

    final drugField = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration?.hintText == 'Drug name');
    expect(drugField, findsOneWidget);
    expect(tester.widget<TextField>(drugField).maxLength, 100);
    expect(tester.widget<TextField>(drugField).decoration?.counterText, '');

    final doseField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'Dose (e.g. 500mg)');
    expect(doseField, findsOneWidget);
    expect(tester.widget<TextField>(doseField).maxLength, 50);
    expect(tester.widget<TextField>(doseField).decoration?.counterText, '');

    final notesField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText ==
            'e.g. Take with food. Avoid alcohol. Return if symptoms worsen...');
    expect(notesField, findsOneWidget);
    expect(tester.widget<TextField>(notesField).maxLength, 1000);
    expect(tester.widget<TextField>(notesField).decoration?.counterText, '');
  });

  testWidgets('EmrHomeScreen has hardened input fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmrHomeScreen()));

    final searchField = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.hintText == 'Search by name, ID, or phone...');
    expect(searchField, findsOneWidget);
    expect(tester.widget<TextField>(searchField).maxLength, 100);
    expect(tester.widget<TextField>(searchField).decoration?.counterText, '');
  });
}
