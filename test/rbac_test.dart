import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('RBAC: Non-admin user is redirected from /analytics to /home', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
        return;
      }
      FlutterError.presentError(details);
    };
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    final appState = AppState();
    // Default role is doctor, which is not admin
    appState.login(MockCurrentUser.forRole(StaffRole.doctor));

    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Initial location is splash, then it should go to home because we are authenticated
    await tester.pumpAndSettle();
    expect(router.state?.matchedLocation, '/home');

    // Attempt to navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should be redirected back to /home
    expect(router.state?.matchedLocation, '/home');
  });

  testWidgets('RBAC: Admin user can access /analytics', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
        return;
      }
      FlutterError.presentError(details);
    };
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    final appState = AppState();
    appState.selectRole(StaffRole.admin);
    appState.login(MockCurrentUser.forRole(StaffRole.admin));

    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(router.state?.matchedLocation, '/home');

    // Attempt to navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should stay at /analytics
    expect(router.state?.matchedLocation, '/analytics');
  });
}
