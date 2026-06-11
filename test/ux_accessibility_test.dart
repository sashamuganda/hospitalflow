import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('UX Accessibility Tests', () {
    testWidgets('KpiCard has correct semantics', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test Label',
              value: '100',
              subtitle: 'Test Subtitle',
              icon: Icons.add,
              color: Colors.blue,
            ),
          ),
        ),
      );

      final labelFinder = find.bySemanticsLabel('100 Test Label, Test Subtitle');
      expect(labelFinder, findsOneWidget);

      handle.dispose();
    });

    testWidgets('KpiCard as button has correct semantics', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test Label',
              value: '100',
              icon: Icons.add,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final labelFinder = find.bySemanticsLabel('100 Test Label');
      expect(labelFinder, findsOneWidget);

      handle.dispose();
    });

    testWidgets('GlassCard with onTap has tap action', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

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

      final finder = find.byType(GlassCard);
      final semanticsData = tester.getSemantics(finder).getSemanticsData();

      // Check if it has any actions, should have tap
      expect(semanticsData.hasAction(SemanticsAction.tap), isTrue);

      handle.dispose();
    });
  });
}
