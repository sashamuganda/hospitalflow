import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('RBAC: Non-admin users are redirected from restricted routes', (WidgetTester tester) async {
    // Set a large surface size to avoid overflow errors in the test environment
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    // Ignore overflow errors in this test
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed')) return;
      originalOnError?.call(details);
    };

    final appState = AppState();
    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // 1. Login as a Doctor (Non-Admin)
    final doctor = MockCurrentUser.forRole(StaffRole.doctor);
    appState.login(doctor);
    await tester.pumpAndSettle();

    // Verify we are at home (look for some home-specific text)
    expect(find.text('At a Glance'), findsOneWidget);
    print('Logged in as doctor, at home.');

    // 2. Try to access /analytics
    print('Navigating to /analytics...');
    router.go('/analytics');
    await tester.pumpAndSettle();

    // Should be redirected back to home (not at analytics)
    expect(find.text('Analytics'), findsNothing);
    expect(find.text('At a Glance'), findsOneWidget);
    print('Redirected from /analytics back to home.');

    // 3. Try to access /staff
    print('Navigating to /staff...');
    router.go('/staff');
    await tester.pumpAndSettle();

    // Should be redirected back to home
    expect(find.text('Staff Directory'), findsNothing);
    expect(find.text('At a Glance'), findsOneWidget);
    print('Redirected from /staff back to home.');
  });

  testWidgets('RBAC: Admin users can access restricted routes', (WidgetTester tester) async {
    // Set a large surface size to avoid overflow errors in the test environment
    await tester.binding.setSurfaceSize(const Size(1280, 1024));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    // Ignore overflow errors in this test
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed')) return;
      originalOnError?.call(details);
    };

    final appState = AppState();
    final router = createRouter(appState);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // 1. Login as an Admin
    final admin = MockCurrentUser.forRole(StaffRole.admin);
    appState.login(admin);
    await tester.pumpAndSettle();

    // 2. Access /analytics
    router.go('/analytics');
    await tester.pumpAndSettle();

    expect(find.text('Analytics'), findsOneWidget);

    // 3. Access /staff
    router.go('/staff');
    await tester.pumpAndSettle();

    expect(find.text('Staff Directory'), findsOneWidget);
  });
}
