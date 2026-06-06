import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Shared Widgets UX/Accessibility Tests', () {
    testWidgets('GlassCard has button semantics when onTap is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () {},
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(GlassCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('KpiCard has correct semantics and button role', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test KPI',
              value: '123',
              subtitle: 'Increasing',
              icon: Icons.add,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Test KPI: 123, Increasing');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('MetricCard has correct semantics and button role', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetricCard(
              label: 'Test Metric',
              value: '98',
              unit: '%',
              icon: Icons.percent,
              color: Colors.green,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.label, 'Test Metric: 98 %');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('Cards without onTap do not have button semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassCard(child: Text('No Tap')),
                KpiCard(label: 'KPI', value: '1', icon: Icons.ac_unit, color: Colors.red),
                MetricCard(label: 'Metric', value: '2', unit: 'x', icon: Icons.adb, color: Colors.blue),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSemantics(find.byType(GlassCard)).hasFlag(SemanticsFlag.isButton), false);
      expect(tester.getSemantics(find.byType(KpiCard)).hasFlag(SemanticsFlag.isButton), false);
      expect(tester.getSemantics(find.byType(MetricCard)).hasFlag(SemanticsFlag.isButton), false);
    });
  });
}
