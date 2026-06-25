import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:medflow_staff/core/colors.dart';

void main() {
  testWidgets('Shared Widgets UX and Accessibility Test', (WidgetTester tester) async {
    // Enable semantics for the test
    final SemanticsHandle handle = tester.ensureSemantics();

    // 1. Test KpiCard Semantics
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Waiting Patients',
            value: '5',
            subtitle: '2 immediate',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ),
    );

    // KpiCard should have a summary semantic label and indicate it is a button
    expect(
      find.bySemanticsLabel('5 Waiting Patients, 2 immediate'),
      findsOneWidget,
      reason: 'KpiCard should have a summarized semantic label',
    );

    final kpiSemantics = tester.getSemantics(find.byType(KpiCard));
    expect(kpiSemantics.hasFlag(SemanticsFlag.isButton), true, reason: 'KpiCard with onTap should be marked as a button');

    // 2. Test MetricCard Semantics
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(
      find.bySemanticsLabel('72 bpm Heart Rate'),
      findsOneWidget,
      reason: 'MetricCard should have a summarized semantic label',
    );

    final metricSemantics = tester.getSemantics(find.byType(MetricCard));
    expect(metricSemantics.hasFlag(SemanticsFlag.isButton), true, reason: 'MetricCard with onTap should be marked as a button');

    // 3. Test SectionHeader Semantics
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Patient Queue'),
        ),
      ),
    );

    final headerSemantics = tester.getSemantics(find.text('Patient Queue'));
    expect(headerSemantics.hasFlag(SemanticsFlag.isHeader), true, reason: 'SectionHeader title should be marked as a header');

    // 4. Test TriageChip Semantics
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TriageChip(level: TriageLevel.immediate),
        ),
      ),
    );

    expect(
      find.bySemanticsLabel(RegExp(r'Triage level: Immediate')),
      findsOneWidget,
      reason: 'TriageChip should have a descriptive semantic label',
    );

    // 5. Test RoleBadge Semantics
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RoleBadge(label: 'Doctor'),
        ),
      ),
    );

    expect(
      find.bySemanticsLabel(RegExp(r'Role: Doctor')),
      findsOneWidget,
      reason: 'RoleBadge should have a descriptive semantic label',
    );

    // 6. Test GlassCard tactile feedback (interactive check)
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () => tapped = true,
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    expect(tapped, true, reason: 'GlassCard should be interactive when onTap is provided');

    final glassSemantics = tester.getSemantics(find.byType(GlassCard));
    expect(glassSemantics.hasFlag(SemanticsFlag.isButton), true, reason: 'GlassCard with onTap should be marked as a button');

    handle.dispose();
  });
}
