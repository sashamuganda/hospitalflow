import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Enhanced Cards Accessibility and Haptics Tests', () {
    testWidgets('GlassCard provides semantics and haptics', (WidgetTester tester) async {
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
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

      await tester.tap(find.byType(GlassCard));
      expect(tapped, true);
    });

    testWidgets('KpiCard provides semantics and haptics', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'OPD Patients',
            value: '142',
            subtitle: '+12 today',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () => tapped = true,
          ),
        ),
      ));

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      expect(semantics.label, 'OPD Patients: 142, +12 today');

      await tester.tap(find.byType(KpiCard));
      expect(tapped, true);
    });

    testWidgets('MetricCard provides semantics and haptics', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () => tapped = true,
          ),
        ),
      ));

      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      expect(semantics.label, 'Heart Rate: 72 bpm');

      await tester.tap(find.byType(MetricCard));
      expect(tapped, true);
    });
  });
}
