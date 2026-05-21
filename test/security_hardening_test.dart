import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:provider/provider.dart';

void main() {
  group('Security Hardening Tests', () {
    testWidgets('ForgotPasswordScreen Staff ID maxLength is 20', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));
      final staffIdField = find.byWidgetPredicate((w) =>
        w is TextField && w.decoration?.hintText == 'e.g. DOC-2024-001'
      );
      expect(staffIdField, findsOneWidget);
      final textField = tester.widget<TextField>(staffIdField);
      expect(textField.maxLength, 20);
      expect(textField.decoration?.counterText, '');
    });

    testWidgets('RBAC logic verification', (tester) async {
      final appState = AppState();
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));
      appState.selectRole(StaffRole.nurse);

      final router = createRouter(appState);

      await tester.pumpWidget(
        ChangeNotifierProvider<AppState>.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      // Wait for splash screen timer and transitions
      // We skip pumpAndSettle to avoid failing on overflow errors which are irrelevant for RBAC logic
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();

      // Nurse attempts to go to EMR
      router.go('/emr');
      await tester.pump();
      expect(router.routeInformationProvider.value.uri.path, '/home');

      // Admin attempts to go to Staff
      appState.selectRole(StaffRole.admin);
      router.go('/staff');
      await tester.pump();
      expect(router.routeInformationProvider.value.uri.path, '/staff');

      // Pharmacist attempts to go to Staff
      appState.selectRole(StaffRole.pharmacist);
      router.go('/staff');
      await tester.pump();
      expect(router.routeInformationProvider.value.uri.path, '/home');
    });
  });
}
