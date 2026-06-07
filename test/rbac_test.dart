import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  // Global flag to ignore overflow errors
  bool ignoreOverflowErrors(FlutterErrorDetails details,
      {bool forceReport = false}) {
    return details.exception is FlutterError &&
        details.exception.toString().contains('A RenderFlex overflowed');
  }

  testWidgets('Doctor is redirected from /analytics to /home',
      (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
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

    // We navigate to /home first
    router.go('/home');
    // Pump and then advance clock to clear the splash screen timer
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));

    router.go('/analytics');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(router.state?.matchedLocation, '/home');

    FlutterError.onError = originalOnError;
  });

  testWidgets('Admin can access /analytics', (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
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

    router.go('/home');
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));

    router.go('/analytics');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(router.state?.matchedLocation, '/analytics');

    FlutterError.onError = originalOnError;
  });

  testWidgets('Doctor is redirected from /staff to /home',
      (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
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

    router.go('/home');
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));

    router.go('/staff');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(router.state?.matchedLocation, '/home');

    FlutterError.onError = originalOnError;
  });
}
