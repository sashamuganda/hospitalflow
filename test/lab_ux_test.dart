import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/lab/lab_home_screen.dart';
import 'package:medflow_staff/core/colors.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  testWidgets('LabHomeScreen accessibility and micro-UX verification', (WidgetTester tester) async {
    // Build the LabHomeScreen
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const LabHomeScreen(),
      ),
    );

    // 1. Verify Header Semantics
    final headerFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.header == true && widget.child is Text && (widget.child as Text).data == 'Laboratory Processing'
    );
    expect(headerFinder, findsOneWidget, reason: 'Header should have Semantics(header: true)');

    // 2. Verify Priority Badge Semantics
    // Get the first lab order from mock data to know what to expect
    final firstOrder = mockLabOrders.first;
    final priorityLabel = 'Priority: ${firstOrder.priority.toUpperCase()}';

    final prioritySemanticsFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == priorityLabel
    );
    expect(prioritySemanticsFinder, findsAtLeastNWidgets(1), reason: 'Priority badge should have descriptive Semantics label');

    // 3. Verify Tooltips for Action Buttons
    final processTooltipFinder = find.byWidgetPredicate(
      (widget) => widget is Tooltip && widget.message!.contains('Start processing lab order')
    );
    expect(processTooltipFinder, findsAtLeastNWidgets(1), reason: 'Process button should be wrapped in a Tooltip');

    final resultsTooltipFinder = find.byWidgetPredicate(
      (widget) => widget is Tooltip && widget.message!.contains('Enter results for lab order')
    );
    expect(resultsTooltipFinder, findsAtLeastNWidgets(1), reason: 'Enter Results button should be wrapped in a Tooltip');

    // 4. Verify Haptic Feedback call (Indirectly by checking if buttons are clickable)
    // We can't easily verify HapticFeedback in a widget test without mocking the channel,
    // but we can ensure the buttons exist and their onPressed is not null.
    final processButton = find.widgetWithText(ElevatedButton, 'Process').first;
    expect(tester.widget<ElevatedButton>(processButton).onPressed, isNotNull);

    final resultsButton = find.widgetWithText(ElevatedButton, 'Enter Results').first;
    expect(tester.widget<ElevatedButton>(resultsButton).onPressed, isNotNull);
  });
}
