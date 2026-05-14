import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Card Accessibility Tests', () {
    testWidgets('GlassCard has correct semantics when interactive',
        (WidgetTester tester) async {
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
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);

      await tester.tap(find.byType(GlassCard));
      expect(tapped, isTrue);
    });

    testWidgets('KpiCard has correct semantics summary even when not interactive',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Patients',
              value: '24',
              subtitle: '+2 today',
              icon: Icons.person,
              color: Colors.blue,
              onTap: null,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, contains('Patients: 24 +2 today'));
      expect(semantics.hasFlag(SemanticsFlag.isButton), isFalse);
    });

    testWidgets('Interactive KpiCard has correct semantics',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Patients',
              value: '24',
              subtitle: '+2 today',
              icon: Icons.person,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(semantics.label, contains('Patients: 24 +2 today'));
    });

    testWidgets('Interactive MetricCard has correct semantics',
        (WidgetTester tester) async {
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
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(semantics.label, contains('Heart Rate: 72 bpm'));
    });
  });
}
