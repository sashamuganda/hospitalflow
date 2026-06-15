import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:medflow_staff/features/dashboard/home_screen.dart';
import 'package:medflow_staff/features/analytics/analytics_home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Doctor is redirected to /home when accessing /analytics', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1024));

    // Ignore RenderFlex overflow errors in tests
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is FlutterError &&
          details.exception.toString().contains('A RenderFlex overflowed')) {
        return;
      }
      originalOnError?.call(details);
    };

    final appState = AppState();
    // Simulate authenticated Doctor
    appState.selectRole(StaffRole.doctor);
    appState.login(MockCurrentUser.forRole(StaffRole.doctor));

    // Start at /home to avoid splash screen timers
    final router = createRouter(appState, initialLocation: '/home');

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Navigate to /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should be redirected back to /home
    expect(find.byType(AnalyticsHomeScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);

    // Restore original onError and reset surface size
    FlutterError.onError = originalOnError;
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Admin can access /analytics', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 1024));

    // Ignore RenderFlex overflow errors in tests
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is FlutterError &&
          details.exception.toString().contains('A RenderFlex overflowed')) {
        return;
      }
      originalOnError?.call(details);
    };

    final appState = AppState();
    // Simulate authenticated Admin
    appState.selectRole(StaffRole.admin);
    appState.login(MockCurrentUser.forRole(StaffRole.admin));

    // Start at /home to avoid splash screen timers
    final router = createRouter(appState, initialLocation: '/home');

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    router.go('/analytics');
    await tester.pumpAndSettle();

    expect(find.byType(AnalyticsHomeScreen), findsOneWidget);

    // Restore original onError and reset surface size
    FlutterError.onError = originalOnError;
    await tester.binding.setSurfaceSize(null);
  });
}
