import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Interactive Cards Semantics Tests', () {
    testWidgets('GlassCard has correct semantics when onTap is provided', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () {},
              child: const Text('Test Content'),
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(GlassCard));
      final data = semantics.getSemanticsData();
      expect(data.hasFlag(SemanticsFlag.isButton), true);
      expect(data.hasFlag(SemanticsFlag.isEnabled), true);

      handle.dispose();
    });

    testWidgets('KpiCard has correct semantics label and flags', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'OPD Patients',
              value: '42',
              subtitle: '+5 today',
              icon: Icons.people,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'OPD Patients: 42 +5 today');
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), true);

      handle.dispose();
    });

    testWidgets('MetricCard has correct semantics label and flags', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

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
      expect(semantics.label, 'Heart Rate: 72 bpm');
      expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), true);

      handle.dispose();
    });
  });
}
