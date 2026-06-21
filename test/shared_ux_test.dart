import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:flutter/rendering.dart';

void main() {
  testWidgets('Shared widgets accessibility and micro-UX verification', (WidgetTester tester) async {
    // 1. Verify SectionHeader Header Semantics
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Test Section'),
        ),
      ),
    );

    final headerSemantics = tester.getSemantics(find.text('Test Section'));
    expect(headerSemantics.hasFlag(SemanticsFlag.isHeader), isTrue,
      reason: 'SectionHeader title should be a semantic header');

    // 2. Verify KpiCard Semantics and Interaction
    bool kpiTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Test Label',
            value: '100',
            subtitle: 'Test Subtitle',
            icon: Icons.add,
            color: Colors.blue,
            onTap: () => kpiTapped = true,
          ),
        ),
      ),
    );

    final kpiFinder = find.byType(KpiCard);
    final kpiSemantics = tester.getSemantics(kpiFinder);

    expect(kpiSemantics.label, contains('100 Test Label'),
      reason: 'KpiCard should have a descriptive semantic label');
    expect(kpiSemantics.label, contains('Test Subtitle'),
      reason: 'KpiCard semantic label should include subtitle for parity');
    expect(kpiSemantics.hasFlag(SemanticsFlag.isButton), isTrue,
      reason: 'KpiCard with onTap should have button role');

    await tester.tap(kpiFinder);
    expect(kpiTapped, isTrue);

    // 3. Verify MetricCard Semantics
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Pulse',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );

    final metricSemantics = tester.getSemantics(find.byType(MetricCard));
    expect(metricSemantics.label, contains('72 bpm Pulse'),
      reason: 'MetricCard should have a descriptive semantic label');
  });
}
