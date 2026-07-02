import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/queue_home_screen.dart';

void main() {
  testWidgets('QueueHomeScreen filter and count consolidation verification', (WidgetTester tester) async {
    // Set a large surface size to ensure all items in the list are built
    tester.view.physicalSize = const Size(1080, 5000);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: QueueHomeScreen(),
      ),
    );

    // 1. Verify Header Badge (Initial state)
    // Should show "1 IMMEDIATE" since q001 is immediate
    expect(find.text('1 IMMEDIATE'), findsOneWidget);

    // 2. Verify Initial List Count
    // Should show all 7 patients
    expect(find.byType(findCardType(tester)), findsNWidgets(7));

    // 3. Verify Triage Legend Counts
    expect(find.text('1'), findsAtLeastNWidgets(1)); // RED: 1

    // 4. Test Status Filter: 'Waiting'
    // There are multiple "Waiting" texts because of cards, we want the filter chip.
    // Filter chips have fontWeight: FontWeight.w600 and fontSize: 12.0
    final waitingFilter = find.byWidgetPredicate((w) => w is Text && w.data == 'Waiting' && w.style?.fontSize == 12.0);
    await tester.tap(waitingFilter);
    await tester.pumpAndSettle();
    expect(find.byType(findCardType(tester)), findsNWidgets(6));

    // 5. Test Status Filter: 'In Consult'
    final inConsultFilter = find.byWidgetPredicate((w) => w is Text && w.data == 'In Consult' && w.style?.fontSize == 12.0);
    await tester.tap(inConsultFilter);
    await tester.pumpAndSettle();
    expect(find.byType(findCardType(tester)), findsNWidgets(1));
    expect(find.text('James Mwangi'), findsOneWidget);

    // 6. Reset Status Filter to 'All'
    final allFilter = find.byWidgetPredicate((w) => w is Text && w.data == 'All' && w.style?.fontSize == 12.0);
    await tester.tap(allFilter);
    await tester.pumpAndSettle();
    expect(find.byType(findCardType(tester)), findsNWidgets(7));

    // 7. Test Triage Filter: 'RED'
    final redFilter = find.byWidgetPredicate((w) => w is Text && w.data == 'RED' && w.style?.fontSize == 9.0);
    await tester.tap(redFilter);
    await tester.pumpAndSettle();
    expect(find.byType(findCardType(tester)), findsNWidgets(1));
    expect(find.text('James Mwangi'), findsOneWidget);

    // 8. Test Triage Filter: 'ORANGE'
    final orangeFilter = find.byWidgetPredicate((w) => w is Text && w.data == 'ORANGE' && w.style?.fontSize == 9.0);
    await tester.tap(orangeFilter);
    await tester.pumpAndSettle();
    expect(find.byType(findCardType(tester)), findsNWidgets(2));
    expect(find.text('Mary Njeri'), findsOneWidget);
    expect(find.text('Peter Kiprotich'), findsOneWidget);

    // Reset surface size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}

// Helper to find the private _QueueCard type
Type findCardType(WidgetTester tester) {
  return find.byWidgetPredicate((w) => w.runtimeType.toString() == '_QueueCard').evaluate().first.widget.runtimeType;
}
