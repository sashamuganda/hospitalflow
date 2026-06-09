import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('PharmacyHomeScreen accessibility and micro-UX verification', (WidgetTester tester) async {
    // Build the PharmacyHomeScreen
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const PharmacyHomeScreen(),
      ),
    );

    // 1. Verify Header Semantics
    final headerFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.header == true && widget.child is Text && (widget.child as Text).data == 'Pharmacy Queue'
    );
    expect(headerFinder, findsOneWidget, reason: 'Header should have Semantics(header: true)');

    // 2. Verify KPI Card Semantics
    final kpiSemanticsFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label != null && widget.properties.label!.contains('prescriptions')
    );
    expect(kpiSemanticsFinder, findsAtLeastNWidgets(2), reason: 'KPI cards should have descriptive Semantics labels');

    final pendingKpi = tester.getSemantics(find.byWidgetPredicate((w) => w is Semantics && w.properties.label == '12 Pending prescriptions'));
    expect(pendingKpi.label, '12 Pending prescriptions');

    // 3. Verify Tab Button Semantics
    final pendingTabFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == 'Pending' && widget.properties.button == true
    );
    expect(pendingTabFinder, findsOneWidget, reason: 'Pending tab should be a semantic button');

    final pendingTabSemantics = tester.getSemantics(pendingTabFinder);
    expect(pendingTabSemantics.hasFlag(SemanticsFlag.isSelected), true, reason: 'Pending tab should be selected by default');

    // 4. Verify Tooltips for Action Buttons
    // Need to ensure at least one prescription is visible (mock data should provide some)
    final processTooltipFinder = find.byWidgetPredicate(
      (widget) => widget is Tooltip && widget.message!.startsWith('Start processing prescription')
    );
    expect(processTooltipFinder, findsAtLeastNWidgets(1), reason: 'Start Processing button should be wrapped in a Tooltip');

    // 5. Switch tab and check tooltips
    await tester.tap(find.text('Processing & Ready'));
    await tester.pumpAndSettle();

    final dispensedTooltipFinder = find.byWidgetPredicate(
      (widget) => widget is Tooltip && widget.message!.endsWith('as dispensed')
    );
    expect(dispensedTooltipFinder, findsAtLeastNWidgets(1), reason: 'Mark as Dispensed button should be wrapped in a Tooltip');
  });
}
