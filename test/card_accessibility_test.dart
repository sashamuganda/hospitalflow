import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Card Accessibility Tests', () {
    testWidgets('GlassCard has correct semantics when interactive', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: GlassCard(onTap: () {}, child: const Text('Content')))));
      final semantics = tester.getSemantics(find.byType(GlassCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);
    });

    testWidgets('KpiCard has correct semantics and label', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: KpiCard(label: 'Test Label', value: '100', subtitle: '+5', icon: Icons.add, color: Colors.blue, onTap: () {}))));
      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Test Label: 100, +5');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('MetricCard has correct semantics and label', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: MetricCard(label: 'Heart Rate', value: '72', unit: 'bpm', icon: Icons.favorite, color: Colors.red, onTap: () {}))));
      final semantics = tester.getSemantics(find.byType(MetricCard));
      expect(semantics.label, 'Heart Rate: 72 bpm');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });
  });
}
