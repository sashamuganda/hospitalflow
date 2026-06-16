import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:flutter/rendering.dart';

void main() {
  testWidgets('StaffAppointmentsHome UX and accessibility verification', (WidgetTester tester) async {
    // Enable semantics for testing
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const StaffAppointmentsHome(),
      ),
    );

    // 1. Verify Tooltips
    expect(find.byTooltip('View Calendar'), findsOneWidget);
    expect(find.byTooltip('Add Appointment'), findsOneWidget);

    // 2. Verify Filter Chip Semantics
    // We search for a Semantics widget that contains the label 'All'
    final filterChip = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'All');
    expect(filterChip, findsAtLeastNWidgets(1));

    final SemanticsData allChipData = tester.getSemantics(filterChip.first).getSemanticsData();
    expect(allChipData.hasFlag(SemanticsFlag.isButton), true, reason: 'Filter chips should have button semantics');
    expect(allChipData.hasFlag(SemanticsFlag.isSelected), true, reason: 'Initial "All" chip should be selected');

    // 3. Verify Appointment Card Semantics
    final firstAppt = mockStaffAppointments.first;
    // Format is like "9:00 AM: Alice Wambua, Completed"
    final expectedSummary = '9:00 AM: ${firstAppt.patientName}, ${firstAppt.status.label}';

    final apptCard = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == expectedSummary);
    expect(apptCard, findsAtLeastNWidgets(1),
      reason: 'Appointment cards should have a descriptive summary label');

    handle.dispose();
  });
}
