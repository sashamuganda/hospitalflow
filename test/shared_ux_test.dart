import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Shared Widgets UX & Accessibility', () {
    testWidgets('KpiCard has correct semantics', (WidgetTester tester) async {
      bool tapped = false;
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test Label',
              value: '100',
              subtitle: 'Test Subtitle',
              icon: Icons.add,
              color: Colors.blue,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      final Finder finder = find.byType(KpiCard);
      final SemanticsData data = tester.getSemantics(finder).getSemanticsData();

      expect(data.hasFlag(SemanticsFlag.isButton), true, reason: 'KpiCard should be a button');
      expect(data.label, '100 Test Label, Test Subtitle');

      await tester.tap(finder);
      expect(tapped, true);

      handle.dispose();
    });

    testWidgets('MetricCard has correct semantics', (WidgetTester tester) async {
      bool tapped = false;
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetricCard(
              label: 'Metric Label',
              value: '25',
              unit: 'kg',
              icon: Icons.monitor_weight,
              color: Colors.green,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      final Finder finder = find.byType(MetricCard);
      final SemanticsData data = tester.getSemantics(finder).getSemanticsData();

      expect(data.hasFlag(SemanticsFlag.isButton), true, reason: 'MetricCard should be a button');
      expect(data.label, '25 kg Metric Label');

      await tester.tap(finder);
      expect(tapped, true);

      handle.dispose();
    });

    testWidgets('SectionHeader has header semantics', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Test Section'),
          ),
        ),
      );

      final Finder finder = find.text('Test Section');
      final SemanticsData data = tester.getSemantics(finder).getSemanticsData();

      expect(data.hasFlag(SemanticsFlag.isHeader), true, reason: 'SectionHeader title should be a header');

      handle.dispose();
    });

    testWidgets('GlassCard has button semantics when interactive', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () {},
              child: const Text('Content'),
            ),
          ),
        ),
      );

      final Finder finder = find.byType(GlassCard);
      final SemanticsData data = tester.getSemantics(finder).getSemanticsData();

      expect(data.hasFlag(SemanticsFlag.isButton), true, reason: 'GlassCard with onTap should be a button');

      handle.dispose();
    });
  });
}
