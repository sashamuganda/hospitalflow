import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';

void main() {
  testWidgets('Shared widgets have correct semantics',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            GlassCard(
              onTap: () {},
              child: const Text('GlassCard Content'),
            ),
            KpiCard(
              label: 'Test KPI',
              value: '100',
              subtitle: 'Sub',
              icon: Icons.add,
              color: Colors.blue,
              onTap: () {},
            ),
            MetricCard(
              label: 'Test Metric',
              value: '50',
              unit: 'kg',
              icon: Icons.person,
              color: Colors.green,
              onTap: () {},
            ),
          ],
        ),
      ),
    ));

    // Verify GlassCard semantics
    final glassCardData = tester.getSemantics(find.byType(GlassCard));
    expect(glassCardData.hasFlag(SemanticsFlag.isButton), true);

    // Verify KpiCard semantics
    final kpiCardData = tester.getSemantics(find.byType(KpiCard));
    expect(kpiCardData.label, 'Test KPI: 100 Sub');
    expect(kpiCardData.hasFlag(SemanticsFlag.isButton), true);

    // Verify MetricCard semantics
    final metricCardData = tester.getSemantics(find.byType(MetricCard));
    expect(metricCardData.label, 'Test Metric: 50 kg');
    expect(metricCardData.hasFlag(SemanticsFlag.isButton), true);
  });

  testWidgets('StaffAppointmentsHome has tooltip and FilterChip semantics',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: StaffAppointmentsHome()));

    // Check IconButton tooltip
    expect(find.byTooltip('View Calendar'), findsOneWidget);

    // Check FilterChip semantics
    // In StaffAppointmentsHome, 'All' is in a _FilterChip
    final allChipText = find.text('All');
    expect(allChipText, findsOneWidget);

    final allChipSemantics = tester.getSemantics(allChipText);
    expect(allChipSemantics.hasFlag(SemanticsFlag.isButton), true);
    expect(allChipSemantics.hasFlag(SemanticsFlag.isSelected), true);
  });

  testWidgets('PharmacyHomeScreen TabBtn semantics',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PharmacyHomeScreen()));

    // Find the 'Pending' text. It exists in _KpiCard and _TabBtn.
    // _TabBtn uses Expanded -> Semantics -> GestureDetector -> Container -> Text
    // We want the one that has the selection state.

    final pendingTexts = find.text('Pending');
    bool foundTab = false;
    for (final element in pendingTexts.evaluate()) {
      final semantics = tester.getSemantics(find.byWidget(element.widget));
      if (semantics.hasFlag(SemanticsFlag.isButton) &&
          semantics.hasFlag(SemanticsFlag.isSelected)) {
        foundTab = true;
        break;
      }
    }
    expect(foundTab, true,
        reason: 'Should find a TabBtn for Pending that is selected');
  });
}
