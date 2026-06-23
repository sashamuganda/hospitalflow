import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  testWidgets('GlassCard has Semantics and HapticFeedback', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GlassCard(
          onTap: () => tapped = true,
          child: const Text('Tap Me'),
        ),
      ),
    ));

    final semantics = tester.getSemantics(find.byType(GlassCard));
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue, reason: 'GlassCard with onTap should have isButton flag');

    await tester.tap(find.byType(GlassCard));
    expect(tapped, isTrue);
  });

  testWidgets('KpiCard has descriptive Semantics and HapticFeedback', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: KpiCard(
          label: 'Patients',
          value: '42',
          subtitle: '+2 today',
          icon: Icons.person,
          color: Colors.blue,
        ),
      ),
    ));

    final semantics = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == '42 Patients, +2 today');
    expect(semantics, findsOneWidget, reason: 'KpiCard should have a combined Semantics label');
  });

  testWidgets('MetricCard has descriptive Semantics and HapticFeedback', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: MetricCard(
          label: 'Heart Rate',
          value: '72',
          unit: 'bpm',
          icon: Icons.favorite,
          color: Colors.red,
        ),
      ),
    ));

    final semantics = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == '72 bpm Heart Rate');
    expect(semantics, findsOneWidget, reason: 'MetricCard should have a combined Semantics label');
  });

  testWidgets('SectionHeader title has header Semantics', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SectionHeader(title: 'Overview'),
      ),
    ));

    final headerSemantics = find.byWidgetPredicate((w) => w is Semantics && w.properties.header == true);
    expect(headerSemantics, findsOneWidget, reason: 'SectionHeader title should be marked as a header');
  });

  testWidgets('TriageChip has descriptive Semantics', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: TriageChip(level: TriageLevel.immediate),
      ),
    ));

    final semantics = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Triage level: Immediate');
    expect(semantics, findsOneWidget, reason: 'TriageChip should have descriptive Semantics');
  });

  testWidgets('RoleBadge has descriptive Semantics', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: RoleBadge(label: 'Doctor'),
      ),
    ));

    final semantics = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Role: Doctor');
    expect(semantics, findsOneWidget, reason: 'RoleBadge should have descriptive Semantics');
  });
}
