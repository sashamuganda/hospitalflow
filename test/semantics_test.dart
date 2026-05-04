import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Interactive Cards Semantics Tests', () {
    testWidgets('GlassCard has correct semantics when onTap is provided', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () => tapped = true,
              child: const Text('Content'),
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(GlassCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

      await tester.tap(find.byType(GlassCard));
      expect(tapped, true);

      handle.dispose();
    });

    testWidgets('KpiCard has correct summary label and semantics', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Patients',
              value: '42',
              subtitle: '+5 today',
              icon: Icons.person,
              color: Colors.blue,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Patients: 42, +5 today');
      // KpiCard should exclude child semantics to avoid redundancy
      expect(find.text('42'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('MetricCard has correct summary label and semantics', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetricCard(
              label: 'Heart Rate',
              value: '72',
              unit: 'bpm',
              icon: Icons.favorite,
              color: Colors.red,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.label, 'Heart Rate: 72 bpm');

      handle.dispose();
    });
  });
}
