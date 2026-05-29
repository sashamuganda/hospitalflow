import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  testWidgets('Pharmacy tab buttons have correct semantics', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AppState(),
          child: const PharmacyHomeScreen(),
        ),
      ),
    );

    // Initial state: Pending is active
    final pendingTab = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Pending');
    expect(pendingTab, findsOneWidget);

    final pendingSemantics = tester.getSemantics(pendingTab);
    expect(pendingSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(pendingSemantics.hasFlag(SemanticsFlag.isSelected), isTrue);

    // Processing & Ready is inactive
    final processingTab = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Processing & Ready');
    expect(processingTab, findsOneWidget);

    final processingSemantics = tester.getSemantics(processingTab);
    expect(processingSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(processingSemantics.hasFlag(SemanticsFlag.isSelected), isFalse);

    // Tap Processing & Ready
    await tester.tap(processingTab);
    await tester.pump();

    // Verify switch
    expect(tester.getSemantics(pendingTab).hasFlag(SemanticsFlag.isSelected), isFalse);
    expect(tester.getSemantics(processingTab).hasFlag(SemanticsFlag.isSelected), isTrue);
  });
}
