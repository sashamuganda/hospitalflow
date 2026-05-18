import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';

void main() {
  testWidgets('StaffAppointmentsHome UX Verification', (WidgetTester tester) async {
    // Enable semantics for testing
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(
      const MaterialApp(
        home: StaffAppointmentsHome(),
      ),
    );

    // 1. Verify Calendar Icon Tooltip
    final calendarIcon = find.byTooltip('View Calendar');
    expect(calendarIcon, findsOneWidget);
    expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);

    // 2. Verify Filter Chips Semantics
    final opdChip = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.label == 'OPD',
    );
    expect(opdChip, findsOneWidget);

    final SemanticsData opdSemantics = tester.getSemantics(find.bySemanticsLabel('OPD')).getSemanticsData();
    expect(opdSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(opdSemantics.hasFlag(SemanticsFlag.isSelected), isFalse); // Initially 'All' is selected

    final SemanticsData allSemantics = tester.getSemantics(find.bySemanticsLabel('All')).getSemanticsData();
    expect(allSemantics.hasFlag(SemanticsFlag.isSelected), isTrue);

    handle.dispose();
  });
}
