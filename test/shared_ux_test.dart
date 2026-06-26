import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/core/colors.dart';

void main() {
  group('KpiCard UX & Accessibility', () {
    testWidgets('KpiCard has correct semantics and handles tap',
        (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Test KPI',
              value: '100',
              subtitle: 'Up 10%',
              icon: Icons.add,
              color: AppColors.primary,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Test KPI: 100, Up 10%');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);

      await tester.tap(find.byType(KpiCard));
      expect(tapped, true);
    });

    testWidgets('KpiCard semantics when non-interactive',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              label: 'Patients',
              value: '42',
              icon: Icons.person,
              color: AppColors.secondary,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Patients: 42');
      expect(semantics.hasFlag(SemanticsFlag.isButton), false);
    });
  });
}
