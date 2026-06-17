import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Shared Widgets UX & Accessibility', () {
    testWidgets('GlassCard has button semantics when interactive', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () => tapped = true,
              child: const Text('Interactive Card'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(GlassCard);
      final semantics = tester.getSemantics(cardFinder);

      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), true);

      await tester.tap(cardFinder);
      expect(tapped, true);
    });

    testWidgets('KpiCard has correct semantics label and button flag', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'OPD Patients',
              value: '120',
              subtitle: '+12 from yesterday',
              icon: Icons.people,
              color: Colors.blue,
              onTap: null, // Test non-interactive first
            ),
          ),
        ),
      );

      final kpiFinder = find.byType(KpiCard);
      var semantics = tester.getSemantics(kpiFinder);

      expect(semantics.getSemanticsData().label, '120 OPD Patients, +12 from yesterday');
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), false);

      // Rebuild with onTap
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'OPD Patients',
              value: '120',
              subtitle: '+12 from yesterday',
              icon: Icons.people,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('MetricCard has correct semantics label and button flag', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetricCard(
              label: 'Heart Rate',
              value: '72',
              unit: 'bpm',
              icon: Icons.favorite,
              color: Colors.red,
              onTap: null,
            ),
          ),
        ),
      );

      final metricFinder = find.byType(MetricCard);
      var semantics = tester.getSemantics(metricFinder);

      expect(semantics.getSemanticsData().label, '72 bpm Heart Rate');
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), false);

      // Rebuild with onTap
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

      semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), true);
    });
  });
}
