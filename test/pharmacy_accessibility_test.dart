import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';
import 'package:medflow_staff/core/colors.dart';

void main() {
  testWidgets('PharmacyHomeScreen tab buttons have correct Semantics', (WidgetTester tester) async {
    // Increase view size to ensure all widgets are visible
    tester.view.physicalSize = const Size(2400, 1800);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: PharmacyHomeScreen(),
      ),
    );

    // Verify 'Pending' tab semantics
    final pendingTab = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Pending');
    expect(pendingTab, findsOneWidget);

    final pendingSemantics = tester.getSemantics(pendingTab);
    expect(pendingSemantics.hasFlag(SemanticsFlag.isButton), true);
    expect(pendingSemantics.hasFlag(SemanticsFlag.isSelected), true);

    // Verify 'Processing & Ready' tab semantics
    final readyTab = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Processing & Ready');
    expect(readyTab, findsOneWidget);

    final readySemantics = tester.getSemantics(readyTab);
    expect(readySemantics.hasFlag(SemanticsFlag.isButton), true);
    expect(readySemantics.hasFlag(SemanticsFlag.isSelected), false);

    // Switch to 'Processing & Ready' tab
    await tester.tap(readyTab);
    await tester.pumpAndSettle();

    // Verify selection state changed
    expect(tester.getSemantics(find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Pending')).hasFlag(SemanticsFlag.isSelected), false);
    expect(tester.getSemantics(find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Processing & Ready')).hasFlag(SemanticsFlag.isSelected), true);
  });
}
