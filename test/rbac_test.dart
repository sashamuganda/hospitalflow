import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  // Helper to ignore RenderFlex overflow errors in tests
  void ignoreOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    if (details.exception is FlutterError && (details.exception as FlutterError).message.contains('A RenderFlex overflowed')) {
      return;
    }
    FlutterError.presentError(details);
  }

  testWidgets('RBAC: Non-admin (Doctor) is redirected from /analytics to /home', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final appState = AppState();
    appState.selectRole(StaffRole.doctor);
    appState.login(MockCurrentUser.forRole(StaffRole.doctor));

    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify we start at home
    expect(find.text('Home'), findsWidgets);

    // Attempt to navigate to /analytics manually
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should be redirected back to /home because Doctor is not Admin
    // (Analytics screen has 'Analytics' text in headline)
    expect(find.text('Analytics'), findsNothing);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('RBAC: Admin can access /analytics', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    final appState = AppState();
    appState.selectRole(StaffRole.admin);
    appState.login(MockCurrentUser.forRole(StaffRole.admin));

    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should successfully reach Analytics
    expect(find.text('Analytics'), findsWidgets);
  });
}
