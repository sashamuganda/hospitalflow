import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  group('Accessibility & Micro-UX Tests', () {
    testWidgets('KpiCard has correct semantics and interaction triggers', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Patients',
            value: '24',
            subtitle: '+2 today',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () => tapped = true,
          ),
        ),
      ));

      // Check Semantics
      final SemanticsData semantics = tester.getSemantics(find.byType(KpiCard)).getSemanticsData();
      expect(semantics.label, '24 Patients, +2 today');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);

      // Check interaction
      await tester.tap(find.byType(KpiCard));
      expect(tapped, true);

      // Verify InkWell exists
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('TriageChip has descriptive semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TriageChip(level: TriageLevel.urgent),
      ));

      final SemanticsData semantics = tester.getSemantics(find.byType(TriageChip)).getSemanticsData();
      expect(semantics.label, 'Triage level: Urgent');
    });

    testWidgets('RoleBadge has descriptive semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: RoleBadge(label: 'Doctor'),
      ));

      final SemanticsData semantics = tester.getSemantics(find.byType(RoleBadge)).getSemanticsData();
      expect(semantics.label, 'Role: Doctor');
    });

    testWidgets('GlassCard uses InkWell for visual feedback', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () => tapped = true,
            child: const Text('Content'),
          ),
        ),
      ));

      expect(find.byType(InkWell), findsOneWidget);
      await tester.tap(find.byType(GlassCard));
      expect(tapped, true);
    });
  });
}
