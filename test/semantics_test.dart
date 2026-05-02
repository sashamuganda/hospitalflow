import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Semantics Verification', () {
    testWidgets('GlassCard has correct semantics when interactive', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();
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

      final semantics = tester.getSemantics(find.byType(GlassCard));
      // ignore: deprecated_member_use
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      // ignore: deprecated_member_use
      expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

      await tester.tap(find.byType(GlassCard));
      expect(tapped, true);

      handle.dispose();
    });

    testWidgets('KpiCard has correct semantics (standard)', (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Patients',
              value: '12',
              subtitle: 'Wait: 5m',
              icon: Icons.person,
              color: Colors.blue,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      // ignore: deprecated_member_use
      expect(semantics.hasFlag(SemanticsFlag.isButton), false);

      handle.dispose();
    });
  });
}
