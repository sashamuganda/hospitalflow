import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  testWidgets('StaffAppointmentsHome UX and Accessibility verification', (WidgetTester tester) async {
    // Set a large screen size to avoid items being pruned by ListView.separated
    tester.view.physicalSize = const Size(1080, 5000);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const StaffAppointmentsHome(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify FloatingActionButton Tooltip
    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);
    expect(tester.widget<FloatingActionButton>(fabFinder).tooltip, 'Book Appointment');

    // 2. Verify Calendar IconButton Tooltip
    final calendarIconBtnFinder = find.byTooltip('View Calendar');
    expect(calendarIconBtnFinder, findsOneWidget);

    // 3. Verify Appointment Card Semantics
    // We use a predicate to find the Semantics widget with our label
    final cardSemanticsFinder = find.byWidgetPredicate(
      (w) => w is Semantics && w.properties.label != null && w.properties.label!.startsWith('Appointment:')
    );
    expect(cardSemanticsFinder, findsAtLeastNWidgets(1));

    // 4. Verify that "Confirm" button is accessible (NOT excluded)
    final confirmButtonText = find.text('Confirm');
    if (mockStaffAppointments.any((a) => a.status == AppointmentStatus.pending)) {
        expect(confirmButtonText, findsAtLeastNWidgets(1));
    }

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
