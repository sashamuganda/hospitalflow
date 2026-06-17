import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/auth/role_select_screen.dart';
import 'package:medflow_staff/features/auth/login_screen.dart';
import 'package:medflow_staff/features/auth/forgot_password_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget createTestWidget(Widget child) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => child),
        GoRoute(path: '/role-select', builder: (context, state) => const Text('Role Select')),
        GoRoute(path: '/login', builder: (context, state) => const Text('Login')),
      ],
    );

    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('RoleSelectScreen has correct semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    // Set larger screen size to avoid scroll-hidden issues in test
    tester.view.physicalSize = const Size(2400, 3600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createTestWidget(const RoleSelectScreen()));
    await tester.pumpAndSettle();

    // Check RoleCards
    for (final role in StaffRole.values) {
      final label = '${role.displayName}: ${role.description}';
      final roleCard = find.bySemanticsLabel(label);
      expect(roleCard, findsOneWidget);

      final semanticsData = tester.getSemantics(roleCard);
      expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);
    }

    // Check Continue button (disabled initially)
    final continueButton = find.bySemanticsLabel(RegExp(r'^Continue as'));
    expect(continueButton, findsOneWidget);

    var continueSemantics = tester.getSemantics(continueButton);
    expect(continueSemantics.hasFlag(SemanticsFlag.isButton), true);
    expect(continueSemantics.hasFlag(SemanticsFlag.isEnabled), false);

    // Select a role
    await tester.tap(find.text(StaffRole.doctor.displayName));
    await tester.pumpAndSettle();

    continueSemantics = tester.getSemantics(continueButton);
    expect(continueSemantics.hasFlag(SemanticsFlag.isEnabled), true);
    expect(continueSemantics.label, 'Continue as Doctor');

    // Reset view
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
    handle.dispose();
  });

  testWidgets('LoginScreen back button has correct semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(createTestWidget(const LoginScreen()));
    await tester.pumpAndSettle();

    final backButton = find.bySemanticsLabel('Back to role selection');
    expect(backButton, findsOneWidget);

    final semanticsData = tester.getSemantics(backButton);
    expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });

  testWidgets('ForgotPasswordScreen back button has correct semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(createTestWidget(const ForgotPasswordScreen()));
    await tester.pumpAndSettle();

    final backButton = find.bySemanticsLabel('Back to login');
    expect(backButton, findsOneWidget);

    final semanticsData = tester.getSemantics(backButton);
    expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });
}
