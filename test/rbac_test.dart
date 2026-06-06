import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  bool ignoreOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    final bool isOverflowError = details.exception is FlutterError &&
        (details.exception as FlutterError).message.contains('A RenderFlex overflowed');

    if (isOverflowError) {
      return true;
    }

    return false;
  }

  testWidgets('RBAC: Non-admin users are redirected from /analytics to /home', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final appState = AppState();
    // Simulate authentication as a doctor
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

    // Initial load might be splash/home
    await tester.pumpAndSettle();

    // Attempt to navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Verify redirection to /home
    expect(router.routeInformationProvider.value.uri.path, '/home');
  });

  testWidgets('RBAC: Admin users can access /analytics', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final appState = AppState();
    // Simulate authentication as an admin
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

    // Attempt to navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Verify they are on /analytics
    expect(router.routeInformationProvider.value.uri.path, '/analytics');
  });
}
