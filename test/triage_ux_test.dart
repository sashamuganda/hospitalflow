import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:flutter/rendering.dart';

void main() {
  testWidgets('TriageScreen interactive elements have correct Semantics',
      (WidgetTester tester) async {
    // Set a larger size to ensure all elements are visible (especially bottom sections)
    tester.view.physicalSize = const Size(2400, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    // We use a mock patient ID from mock_data.dart (e.g., 'q002')
    await tester.pumpWidget(const MaterialApp(
      home: TriageScreen(patientId: 'q002'),
    ));

    await tester.pumpAndSettle();

    // 1. Verify Back Button Semantics
    final backButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'Back');
    expect(backButton, findsOneWidget);
    final backSemantics = tester.getSemantics(backButton);
    expect(backSemantics.hasFlag(SemanticsFlag.isButton), isTrue);

    // 2. Verify Quick Complaint Chips Semantics
    // Taking 'Chest Pain' as an example from _quickComplaints in TriageScreen
    final chestPainChip = find.bySemanticsLabel('Add Chest Pain to notes');
    expect(chestPainChip, findsOneWidget);
    final chipSemantics = tester.getSemantics(chestPainChip);
    expect(chipSemantics.hasFlag(SemanticsFlag.isButton), isTrue);

    // 3. Verify Triage Level Selector Semantics
    // Taking 'Urgent' as an example
    final urgentSelector = find.bySemanticsLabel('Select Urgent triage');
    expect(urgentSelector, findsOneWidget);
    final urgentSemantics = tester.getSemantics(urgentSelector);
    expect(urgentSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    // Initially not selected (default is null in TriageScreen state)
    expect(urgentSemantics.hasFlag(SemanticsFlag.isSelected), isFalse);

    // Tap to select and verify it becomes selected
    await tester.tap(urgentSelector);
    await tester.pumpAndSettle();

    final urgentSemanticsSelected = tester.getSemantics(urgentSelector);
    expect(urgentSemanticsSelected.hasFlag(SemanticsFlag.isSelected), isTrue);
  });
}
