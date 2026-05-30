import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  group('RBAC Redirection Tests', () {
    testWidgets('Unauthenticated users are redirected to role-select', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      final appState = AppState();
      final router = createRouter(appState);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      router.go('/home');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(router.routeInformationProvider.value.uri.path, '/role-select');
    });

    testWidgets('Pharmacist cannot access EMR', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      final appState = AppState();
      final router = createRouter(appState);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Login as Pharmacist
      appState.selectRole(StaffRole.pharmacist);
      appState.login(MockCurrentUser.forRole(StaffRole.pharmacist));
      await tester.pump();

      // Attempt to go to EMR
      router.go('/emr');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(router.routeInformationProvider.value.uri.path, '/home');
    });

    testWidgets('Doctor can access EMR', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      final appState = AppState();
      final router = createRouter(appState);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Login as Doctor
      appState.selectRole(StaffRole.doctor);
      appState.login(MockCurrentUser.forRole(StaffRole.doctor));
      await tester.pump();

      // Attempt to go to EMR
      router.go('/emr');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(router.routeInformationProvider.value.uri.path, '/emr');
    });

    testWidgets('Nurse can access Lab but not Analytics', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      final appState = AppState();
      final router = createRouter(appState);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      appState.selectRole(StaffRole.nurse);
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));
      await tester.pump();

      router.go('/lab');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(router.routeInformationProvider.value.uri.path, '/lab');

      router.go('/analytics');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(router.routeInformationProvider.value.uri.path, '/home');
    });
  });
}

/// Utility to ignore overflow errors in widget tests.
void ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool isOverflowError = false;

  // Detect overflow errors.
  final exception = details.exception;
  if (exception is FlutterError) {
    isOverflowError = exception.diagnostics.any(
      (e) => e.value.toString().startsWith('A RenderFlex overflowed'),
    );
  }

  // If it's not an overflow error, report it normally.
  if (!isOverflowError) {
    FlutterError.presentError(details);
  }
}
