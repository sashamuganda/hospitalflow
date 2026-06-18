import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('Shared widgets should have accessibility semantics', (WidgetTester tester) async {
    // Enable semantics for testing
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const SectionHeader(title: 'Test Header'),
              KpiCard(
                label: 'Test KPI',
                value: '100',
                subtitle: '+10%',
                icon: Icons.add,
                color: Colors.blue,
                onTap: () {},
              ),
              MetricCard(
                label: 'Test Metric',
                value: '50',
                unit: 'kg',
                icon: Icons.monitor_weight,
                color: Colors.green,
                onTap: () {},
              ),
              GlassCard(
                onTap: () {},
                child: const Text('Test Glass'),
              ),
            ],
          ),
        ),
      ),
    );

    // Verify SectionHeader semantics
    // In Flutter tests, we should check for semantics properties on the compiled semantics tree
    // using tester.getSemantics() rather than byWidgetPredicate on the Semantics widget itself
    // because Semantics properties are often merged or stored in SemanticsProperties.

    final headerSemantics = tester.getSemantics(find.text('Test Header'));
    expect(headerSemantics.hasFlag(SemanticsFlag.isHeader), true, reason: 'SectionHeader should be a header');

    // Verify KpiCard semantics
    final kpiSemantics = tester.getSemantics(find.byType(KpiCard));
    expect(kpiSemantics.label, 'Test KPI: 100, +10%');
    expect(kpiSemantics.hasFlag(SemanticsFlag.isButton), true);

    // Verify MetricCard semantics
    final metricSemantics = tester.getSemantics(find.byType(MetricCard));
    expect(metricSemantics.label, 'Test Metric: 50 kg');
    expect(metricSemantics.hasFlag(SemanticsFlag.isButton), true);

    // Verify GlassCard semantics specifically
    final glassSemantics = tester.getSemantics(find.text('Test Glass'));
    expect(glassSemantics.hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });
}
