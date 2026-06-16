import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/core/router.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget createTestWidget(AppState appState, GoRouter router) {
    return ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  group('RBAC Redirect Tests', () {
    testWidgets('Doctor is redirected from /analytics to /home', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 1024));

      // Suppress RenderFlex overflow errors for this test
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };

      final appState = AppState();
      appState.selectRole(StaffRole.doctor);
      appState.login(MockCurrentUser.forRole(StaffRole.doctor));

      final router = createRouter(appState);
      await tester.pumpWidget(createTestWidget(appState, router));
      await tester.pumpAndSettle();

      // Attempt to navigate to /analytics
      router.go('/analytics');
      await tester.pumpAndSettle();

      expect(find.text('At a Glance'), findsOneWidget);
      expect(find.text('Analytics'), findsNothing);

      FlutterError.onError = originalOnError;
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Admin can access /analytics', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 1024));

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };

      final appState = AppState();
      appState.selectRole(StaffRole.admin);
      appState.login(MockCurrentUser.forRole(StaffRole.admin));

      final router = createRouter(appState);
      await tester.pumpWidget(createTestWidget(appState, router));
      await tester.pumpAndSettle();

      router.go('/analytics');
      await tester.pumpAndSettle();

      expect(find.text('Analytics'), findsWidgets);

      FlutterError.onError = originalOnError;
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Nurse is redirected from /staff to /home', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 1024));

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };

      final appState = AppState();
      appState.selectRole(StaffRole.nurse);
      appState.login(MockCurrentUser.forRole(StaffRole.nurse));

      final router = createRouter(appState);
      await tester.pumpWidget(createTestWidget(appState, router));
      await tester.pumpAndSettle();

      router.go('/staff');
      await tester.pumpAndSettle();

      expect(find.text('At a Glance'), findsOneWidget);
      expect(find.text('Staff Directory'), findsNothing);

      FlutterError.onError = originalOnError;
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Unauthenticated user is redirected to role-select', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 1024));

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };

      final appState = AppState();

      final router = createRouter(appState);
      await tester.pumpWidget(createTestWidget(appState, router));
      await tester.pumpAndSettle();

      expect(find.text('Select Your Role'), findsOneWidget);

      FlutterError.onError = originalOnError;
      await tester.binding.setSurfaceSize(null);
    });
  });
}
