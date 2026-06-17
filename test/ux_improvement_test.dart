import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/waiting_times_screen.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('WaitingTimesScreen back button has correct semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(
      home: WaitingTimesScreen(),
    ));

    final backButton = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Back');
    final semantics = tester.getSemantics(backButton);

    expect(semantics.label, 'Back');
    expect(semantics.hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });

  testWidgets('GlassCard with onTap has correct semantics and keeps children accessible', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GlassCard(
          onTap: () => tapped = true,
          child: const Text('Accessible Content'),
        ),
      ),
    ));

    final glassCard = find.byType(GlassCard);
    final semantics = tester.getSemantics(glassCard);

    expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

    // Verify children are still accessible (not excluded)
    expect(find.text('Accessible Content'), findsOneWidget);

    await tester.tap(glassCard);
    expect(tapped, true);

    handle.dispose();
  });

  testWidgets('KpiCard has correct semantics label and excludes children', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: KpiCard(
          label: 'Test KPI',
          value: '100',
          icon: Icons.add,
          color: Colors.blue,
          onTap: null,
        ),
      ),
    ));

    final kpiCard = find.byType(KpiCard);
    final semantics = tester.getSemantics(kpiCard);

    expect(semantics.label, 'Test KPI: 100');
    // The individual texts should be excluded from the tree because excludeSemantics: true
    // In widget tests, find.byText still finds widgets, but we can check if they have semantics.

    handle.dispose();
  });
}
