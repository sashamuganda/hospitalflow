import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Role-Based Access Control (RBAC) Tests', () {
    late AppState appState;
    late GoRouter router;

    setUp(() {
      appState = AppState();
      router = createRouter(appState);
    });

    testWidgets('Nurse should be redirected from /emr to /home', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));
      appState.selectRole(StaffRole.nurse);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3)); // Bypass splash screen

      router.go('/emr');
      await tester.pump();

      expect(router.routeInformationProvider.value.uri.path, '/home');
    });

    testWidgets('Doctor should be allowed to access /emr', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.doctor));
      appState.selectRole(StaffRole.doctor);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3));

      router.go('/emr');
      await tester.pump();

      expect(router.routeInformationProvider.value.uri.path, '/emr');
    });

    testWidgets('Admin should be allowed to access /analytics', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.admin));
      appState.selectRole(StaffRole.admin);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3));

      router.go('/analytics');
      await tester.pump();

      expect(router.routeInformationProvider.value.uri.path, '/analytics');
    });

    testWidgets('Nurse should be allowed to access /ward', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));
      appState.selectRole(StaffRole.nurse);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3));

      router.go('/ward');
      await tester.pump();

      expect(router.routeInformationProvider.value.uri.path, '/ward');
    });

    testWidgets('Pharmacist should be redirected from /analytics to /home', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.pharmacist));
      appState.selectRole(StaffRole.pharmacist);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 3));

      router.go('/analytics');
      await tester.pump();

      expect(router.routeInformationProvider.value.uri.path, '/home');
    });
  });
}
