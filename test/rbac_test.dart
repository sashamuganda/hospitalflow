import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('RBAC Navigation Tests', () {
    late AppState appState;
    late GoRouter router;

    Widget createTestWidget() {
      return ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      );
    }

    setUp(() {
      appState = AppState();
      router = createRouter(appState);

      // Ignore overflow errors in tests
      FlutterError.onError = (details) {
        if (details.exception is FlutterError && (details.exception as FlutterError).message.contains('overflowed')) {
          return;
        }
        FlutterError.presentError(details);
      };
    });

    testWidgets('Doctor can access EMR and is not redirected', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.doctor));
      appState.selectRole(StaffRole.doctor);

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3)); // Wait for splash screen timer

      router.go('/emr');
      await tester.pump();

      expect(router.state!.matchedLocation, '/emr');
    });

    testWidgets('Nurse cannot access EMR and is redirected to /home', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));
      appState.selectRole(StaffRole.nurse);

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3));

      router.go('/emr');
      await tester.pump();

      expect(router.state!.matchedLocation, '/home');
    });

    testWidgets('Pharmacist can access pharmacy and inventory', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.pharmacist));
      appState.selectRole(StaffRole.pharmacist);

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3));

      router.go('/pharmacy');
      await tester.pump();
      expect(router.state!.matchedLocation, '/pharmacy');

      router.go('/inventory');
      await tester.pump();
      expect(router.state!.matchedLocation, '/inventory');
    });

    testWidgets('Pharmacist cannot access ward', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.pharmacist));
      appState.selectRole(StaffRole.pharmacist);

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3));

      router.go('/ward');
      await tester.pump();

      expect(router.state!.matchedLocation, '/home');
    });

    testWidgets('Admin can access analytics and staff directory', (tester) async {
      appState.login(MockCurrentUser.forRole(StaffRole.admin));
      appState.selectRole(StaffRole.admin);

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3));

      router.go('/analytics');
      await tester.pump();
      expect(router.state!.matchedLocation, '/analytics');

      router.go('/staff');
      await tester.pump();
      expect(router.state!.matchedLocation, '/staff');
    });

    testWidgets('Unauthenticated user is redirected to /role-select', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 3));

      router.go('/home');
      await tester.pump();
      expect(router.state!.matchedLocation, '/role-select');
    });
  });
}
