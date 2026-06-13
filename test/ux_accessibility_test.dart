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
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(GlassCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('KpiCard has correct semantics label and button role', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'OPD Patients',
              value: '12',
              subtitle: '+2 today',
              icon: Icons.people,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, '12 OPD Patients, +2 today');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('MetricCard has correct semantics label and button role', (WidgetTester tester) async {
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

      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.label, '72 bpm, Heart Rate');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('Cards without onTap do not have button role', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassCard(child: Text('Not a button')),
                KpiCard(
                  label: 'Static',
                  value: '0',
                  icon: Icons.info,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      );

      final glassSemantics = tester.getSemantics(find.byType(GlassCard));
      expect(glassSemantics.hasFlag(SemanticsFlag.isButton), false);

      final kpiSemantics = tester.getSemantics(find.byType(KpiCard));
      expect(kpiSemantics.hasFlag(SemanticsFlag.isButton), false);
    });
  });
}
