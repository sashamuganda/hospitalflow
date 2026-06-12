import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Shared Widgets Accessibility', () {
    testWidgets('KpiCard exposes correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test Label',
              value: '123',
              subtitle: 'Test Subtitle',
              icon: Icons.add,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, '123 Test Label, Test Subtitle');
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    });

    testWidgets('GlassCard handles interactive state semantics', (WidgetTester tester) async {
      // Interactive
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () {},
              child: const Text('Interactive'),
            ),
          ),
        ),
      );
      expect(tester.getSemantics(find.byType(GlassCard)).hasFlag(SemanticsFlag.isButton), isTrue);

      // Non-interactive
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              child: const Text('Static'),
            ),
          ),
        ),
      );
      expect(tester.getSemantics(find.byType(GlassCard)).hasFlag(SemanticsFlag.isButton), isFalse);
    });
  });
}
