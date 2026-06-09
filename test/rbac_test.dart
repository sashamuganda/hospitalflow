import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  // Ignore overflow errors in test environment
  void ignoreOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    bool isOverflowError = false;
    final exception = details.exception;
    if (exception is FlutterError) {
      isOverflowError = exception.message.contains('A RenderFlex overflowed');
    }

    if (isOverflowError) {
      debugPrint('Ignored overflow error during test');
    } else {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  }

  Widget createTestWidget(AppState appState) {
    final router = createRouter(appState);
    return ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('RBAC: Non-admin users are redirected from restricted routes', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final appState = AppState();

    // 1. Log in as a Doctor (non-admin)
    final doctor = MockCurrentUser.forRole(StaffRole.doctor);
    appState.login(doctor);
    appState.selectRole(StaffRole.doctor);

    await tester.pumpWidget(createTestWidget(appState));
    await tester.pumpAndSettle();

    // Verify we are on a screen accessible to doctors (e.g., Home)
    expect(find.text('Home'), findsWidgets);

    // 2. Try to navigate to /analytics
    // Instead of GoRouter.of(context), we can find the inherited widget or just use context from a widget
    final Finder appFinder = find.byType(MaterialApp);
    final BuildContext context = tester.element(find.descendant(of: appFinder, matching: find.byType(Navigator)).first);

    GoRouter.of(context).go('/analytics');
    await tester.pumpAndSettle();

    // Should be redirected back to /home because not an admin
    expect(find.text('Analytics'), findsNothing);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('RBAC: Admin users can access restricted routes', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final appState = AppState();

    // 1. Log in as an Admin
    final admin = MockCurrentUser.forRole(StaffRole.admin);
    appState.login(admin);
    appState.selectRole(StaffRole.admin);

    await tester.pumpWidget(createTestWidget(appState));
    await tester.pumpAndSettle();

    // 2. Navigate to /analytics
    final Finder appFinder = find.byType(MaterialApp);
    final BuildContext context = tester.element(find.descendant(of: appFinder, matching: find.byType(Navigator)).first);

    GoRouter.of(context).go('/analytics');
    await tester.pumpAndSettle();

    // Should be allowed to see Analytics
    expect(find.text('Analytics'), findsWidgets);
  });

  testWidgets('RBAC: Unauthenticated users are redirected to role-select', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final appState = AppState();
    // Ensure not logged in

    await tester.pumpWidget(createTestWidget(appState));
    await tester.pumpAndSettle();

    // Should be redirected to /role-select
    expect(find.text('Select Your Role'), findsOneWidget);

    // Try to go to /home
    final Finder appFinder = find.byType(MaterialApp);
    final BuildContext context = tester.element(find.descendant(of: appFinder, matching: find.byType(Navigator)).first);

    GoRouter.of(context).go('/home');
    await tester.pumpAndSettle();

    expect(find.text('Select Your Role'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
  });
}
