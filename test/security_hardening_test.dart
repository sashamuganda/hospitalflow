import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/emr/clinical_note_editor.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/features/emr/prescription_writer_screen.dart';
import 'package:medflow_staff/features/queue/patient_check_in_screen.dart';
import 'package:medflow_staff/features/emr/vitals_entry_staff.dart';
import 'package:medflow_staff/features/emr/lab_order_screen.dart';
import 'package:medflow_staff/features/emr/emr_home_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(home: child),
    );
  }

  testWidgets('ClinicalNoteEditor has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const ClinicalNoteEditor(patientId: '1')));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('TriageScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const TriageScreen(patientId: '1')));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('PrescriptionWriterScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const PrescriptionWriterScreen(patientId: '1')));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('PatientCheckInScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const PatientCheckInScreen()));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('VitalsEntryStaff has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const VitalsEntryStaff(patientId: '1')));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('LabOrderScreen has security length limits', (tester) async {
    await tester.pumpWidget(wrap(const LabOrderScreen(patientId: '1')));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'TextField missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'TextField counter should be hidden');
    }
  });

  testWidgets('EmrHomeScreen has security length limits on search', (tester) async {
    await tester.pumpWidget(wrap(const EmrHomeScreen()));
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    for (var field in fields) {
      expect(field.maxLength, isNotNull, reason: 'Search field missing maxLength');
      expect(field.decoration?.counterText, '', reason: 'Search field counter should be hidden');
    }
  });
}
