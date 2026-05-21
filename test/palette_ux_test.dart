import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/features/shell/main_shell.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  group('Palette UX Accessibility Tests', () {
    testWidgets('KpiCard has correct semantics', (WidgetTester tester) async {
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
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Test Label: 100 Test Subtitle');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      handle.dispose();
    });

    testWidgets('MetricCard has correct semantics', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MetricCard(
              label: 'Test Metric',
              value: '50',
              unit: 'kg',
              icon: Icons.monitor_weight,
              color: Colors.green,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.label, 'Test Metric: 50 kg');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      handle.dispose();
    });

    testWidgets('GlassCard has button semantic when onTap is provided', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();
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
      handle.dispose();
    });
  });
}
