import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  testWidgets('KpiCard has correct accessibility semantics when interactive', (WidgetTester tester) async {
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

    final semantics = find.bySemanticsLabel('5 Waiting Patients, 2 immediate');
    expect(semantics, findsOneWidget);

    final data = tester.getSemantics(semantics);
    expect(data.hasFlag(SemanticsFlag.isButton), isTrue);
  });

  testWidgets('KpiCard is not a button when not interactive', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Waiting Patients',
            value: '5',
            icon: Icons.people,
            color: Colors.blue,
          ),
        ),
      ),
    );

    final semantics = find.bySemanticsLabel('5 Waiting Patients');
    expect(semantics, findsOneWidget);

    final data = tester.getSemantics(semantics);
    expect(data.hasFlag(SemanticsFlag.isButton), isFalse);
  });

  testWidgets('MetricCard has correct accessibility semantics when interactive', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Avg Wait Time',
            value: '23',
            unit: 'min',
            icon: Icons.timer,
            color: Colors.orange,
            onTap: () {},
          ),
        ),
      ),
    );

    final semantics = find.bySemanticsLabel('23 min, Avg Wait Time');
    expect(semantics, findsOneWidget);

    final data = tester.getSemantics(semantics);
    expect(data.hasFlag(SemanticsFlag.isButton), isTrue);
  });

  testWidgets('TriageChip has correct accessibility semantics', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TriageChip(level: TriageLevel.urgent),
        ),
      ),
    );

    final semantics = find.bySemanticsLabel('Triage level: Urgent');
    expect(semantics, findsOneWidget);
  });

  testWidgets('RoleBadge has correct accessibility semantics', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RoleBadge(label: 'Doctor'),
        ),
      ),
    );

    final semantics = find.bySemanticsLabel('Role: Doctor');
    expect(semantics, findsOneWidget);
  });
}
