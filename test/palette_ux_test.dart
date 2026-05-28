import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';

void main() {
  group('Palette UX Accessibility Tests', () {
    testWidgets('PharmacyHomeScreen tabs have correct Semantics', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PharmacyHomeScreen()));

      // Target the 'Pending' tab. excludeSemantics: true on _TabBtn's Semantics
      // means the inner Text shouldn't have its own label.
      final pendingTab = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'Pending'
      );
      expect(pendingTab, findsOneWidget);

      final Semantics pendingSemantics = tester.widget(pendingTab);
      expect(pendingSemantics.properties.selected, isTrue);
      expect(pendingSemantics.properties.button, isTrue);

      // Target the 'Processing & Ready' tab
      final readyTab = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'Processing & Ready'
      );
      expect(readyTab, findsOneWidget);

      final Semantics readySemantics = tester.widget(readyTab);
      expect(readySemantics.properties.selected, isFalse);
    });

    testWidgets('StaffAppointmentsHome filters have correct Semantics and tooltips', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StaffAppointmentsHome()));

      // Target the 'All' filter chip
      final allFilter = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'All'
      );
      expect(allFilter, findsOneWidget);

      final Semantics allSemantics = tester.widget(allFilter);
      expect(allSemantics.properties.selected, isTrue);
      expect(allSemantics.properties.button, isTrue);

      // Verify IconButton tooltip
      final calendarButton = find.byType(IconButton);
      expect(calendarButton, findsOneWidget);
      final IconButton iconButton = tester.widget(calendarButton);
      expect(iconButton.tooltip, 'View Calendar');
    });
  });
}
