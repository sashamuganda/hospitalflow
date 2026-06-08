import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/main.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  void ignoreOverflowErrors(
    FlutterErrorDetails details, {
    bool forceReport = false,
  }) {
    bool isOverflowError = false;
    final exception = details.exception;
    if (exception is FlutterError) {
      isOverflowError = exception.diagnostics.any(
        (e) => e.value.toString().startsWith('A RenderFlex overflowed'),
      );
    }

    if (isOverflowError) {
      return;
    }

    FlutterError.presentError(details);
  }

  testWidgets('RBAC: Non-admin users should be redirected from admin routes', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await tester.pumpWidget(const MedFlowStaffApp());
    // Wait for splash screen
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Finder routerFinder = find.byType(Router<Object>);
    final BuildContext context = tester.element(routerFinder.first);
    final appState = context.read<AppState>();

    // Login as Doctor
    final doctor = MockCurrentUser.forRole(StaffRole.doctor);
    appState.selectRole(StaffRole.doctor);
    appState.login(doctor);
    await tester.pumpAndSettle();

    // Verify we are on home
    final router = GoRouter.of(context);
    expect(router.routerDelegate.currentConfiguration.last.matchedLocation, '/home');

    // Attempt to go to /analytics (Admin route)
    router.go('/analytics');
    await tester.pumpAndSettle();

    // This SHOULD be /home after fix, but will be /analytics before fix
    expect(router.routerDelegate.currentConfiguration.last.matchedLocation, '/home', reason: 'Non-admin should be redirected from /analytics to /home');
  });
}
