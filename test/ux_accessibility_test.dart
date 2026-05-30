import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/pharmacy/pharmacy_home_screen.dart';
import 'package:medflow_staff/features/appointments/staff_appointments_home.dart';

void main() {
  group('UX & Accessibility Verification', () {
    testWidgets('PharmacyHomeScreen TabBtn has Semantics and HapticFeedback', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PharmacyHomeScreen(),
        ),
      );

      final Finder semanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'Pending',
      );
      expect(semanticsFinder, findsOneWidget);

      final SemanticsData data = tester.getSemantics(semanticsFinder).getSemanticsData();
      expect(data.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(data.hasFlag(SemanticsFlag.isSelected), isTrue); // Default active tab

      final Semantics semanticsWidget = tester.widget(semanticsFinder);
      expect(semanticsWidget.excludeSemantics, isTrue);
    });

    testWidgets('StaffAppointmentsHome has tooltip and FilterChip Semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StaffAppointmentsHome(),
        ),
      );

      // Tooltip check
      expect(find.byTooltip('View Calendar'), findsOneWidget);

      // FilterChip Semantics check
      final Finder semanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.label == 'All',
      );
      expect(semanticsFinder, findsOneWidget);

      final SemanticsData data = tester.getSemantics(semanticsFinder).getSemanticsData();
      expect(data.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(data.hasFlag(SemanticsFlag.isSelected), isTrue);

      final Semantics semanticsWidget = tester.widget(semanticsFinder);
      expect(semanticsWidget.excludeSemantics, isTrue);
    });
  });
}
