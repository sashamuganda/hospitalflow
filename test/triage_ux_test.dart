import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  Widget createTriageScreen() {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MaterialApp(
        home: TriageScreen(patientId: 'q002'),
      ),
    );
  }

  testWidgets('TriageScreen has accessible back button', (WidgetTester tester) async {
    await tester.pumpWidget(createTriageScreen());

    final backButtonFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == 'Back',
    );
    expect(backButtonFinder, findsOneWidget);

    final SemanticsData data = tester.getSemantics(backButtonFinder).getSemanticsData();
    expect(data.hasFlag(SemanticsFlag.isButton), true);
  });

  testWidgets('TriageScreen has accessible quick complaint chips', (WidgetTester tester) async {
    await tester.pumpWidget(createTriageScreen());

    // Check the first complaint chip: 'Chest Pain'
    final chipFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == 'Chest Pain',
    );
    expect(chipFinder, findsOneWidget);

    final SemanticsData data = tester.getSemantics(chipFinder).getSemanticsData();
    expect(data.hasFlag(SemanticsFlag.isButton), true);
  });

  testWidgets('TriageScreen has accessible triage selector items', (WidgetTester tester) async {
    await tester.pumpWidget(createTriageScreen());

    // TriageLevel.immediate.label is 'Immediate'
    final selectorFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == 'Immediate',
    );
    expect(selectorFinder, findsOneWidget);

    final SemanticsData data = tester.getSemantics(selectorFinder).getSemanticsData();
    expect(data.hasFlag(SemanticsFlag.isButton), true);

    // Test selection state toggle
    await tester.ensureVisible(selectorFinder);
    await tester.tap(selectorFinder);
    await tester.pump();

    final SemanticsData updatedData = tester.getSemantics(selectorFinder).getSemanticsData();
    expect(updatedData.hasFlag(SemanticsFlag.isSelected), true);
  });
}
