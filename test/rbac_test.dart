import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('RBAC: Non-admin (Doctor) is redirected from /analytics to /home',
      (WidgetTester tester) async {
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('RenderFlex overflowed')) {
        return;
      }
      FlutterError.dumpErrorToConsole(details);
    };
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    final appState = AppState();
    // Simulate login as Doctor
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

    // Navigate to restricted route
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Verify redirection to /home (Home screen title or unique widget)
    expect(find.text('Good Morning,'), findsOneWidget); // Found in HomeScreen
    expect(find.text('Analytics'), findsNothing);
  });

  testWidgets('RBAC: Admin can access /analytics', (WidgetTester tester) async {
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('RenderFlex overflowed')) {
        return;
      }
      FlutterError.dumpErrorToConsole(details);
    };
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    final appState = AppState();
    // Simulate login as Admin
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

    // Navigate to restricted route
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Verify access to /analytics
    expect(find.text('Analytics'), findsOneWidget);
  });
}
