import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('Shared card widgets have correct Semantics', (WidgetTester tester) async {
    bool tapped = false;

    // 1. Test KpiCard basic
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Basic KPI',
            value: '100',
            icon: Icons.add,
            color: Colors.blue,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final basicKpiFinder = find.byType(KpiCard);
    final basicKpiSemantics = tester.getSemantics(basicKpiFinder);

    expect(basicKpiSemantics.label, 'KPI: Basic KPI, 100');
    expect(basicKpiSemantics.hasFlag(SemanticsFlag.isButton), true);

    await tester.tap(basicKpiFinder);
    expect(tapped, true);

    // 2. Test KpiCard with subtitle
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Trend KPI',
            value: '50',
            subtitle: '+5%',
            icon: Icons.trending_up,
            color: Colors.orange,
            onTap: () {},
          ),
        ),
      ),
    );

    final trendKpiFinder = find.byType(KpiCard);
    final trendKpiSemantics = tester.getSemantics(trendKpiFinder);
    expect(trendKpiSemantics.label, 'KPI: Trend KPI, 50, +5%');

    // 3. Test MetricCard
    tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Test Metric',
            value: '45',
            unit: 'kg',
            icon: Icons.monitor_weight,
            color: Colors.green,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final metricFinder = find.byType(MetricCard);
    final metricSemantics = tester.getSemantics(metricFinder);

    expect(metricSemantics.label, 'Metric: Test Metric, 45 kg');
    expect(metricSemantics.hasFlag(SemanticsFlag.isButton), true);

    await tester.tap(metricFinder);
    expect(tapped, true);

    // 4. Test GlassCard with onTap
    tapped = false;
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

    final glassFinder = find.byType(GlassCard);
    final glassSemantics = tester.getSemantics(glassFinder);

    expect(glassSemantics.hasFlag(SemanticsFlag.isButton), true);

    await tester.tap(glassFinder);
    expect(tapped, true);
  });
}
