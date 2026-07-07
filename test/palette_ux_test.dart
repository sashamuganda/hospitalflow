import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/auth/role_select_screen.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:flutter/rendering.dart';

void main() {
  group('RoleCard UX Tests', () {
    testWidgets('RoleCard has correct semantics', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RoleSelectScreen(),
        ),
      ));

      const role = StaffRole.doctor;

      final semantics = tester.getSemantics(find.byType(InkWell).first);
      expect(semantics.label, contains(role.displayName));
      expect(semantics.label, contains(role.description));
      // ignore: deprecated_member_use
      expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    });

    testWidgets('RoleCard uses InkWell for feedback', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RoleSelectScreen(),
        ),
      ));

      expect(find.descendant(
        of: find.byType(AnimatedContainer).first,
        matching: find.byType(InkWell),
      ), findsOneWidget);
    });
  });
}
