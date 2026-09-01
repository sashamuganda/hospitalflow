import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/dashboard/home_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Quick Actions have Semantics', (WidgetTester tester) async {
    // Enable semantics for the test
    final SemanticsHandle handle = tester.ensureSemantics();

    final appState = AppState();
    // Login as doctor to see specific quick actions
    appState.login(MockCurrentUser.forRole(StaffRole.doctor));

    await tester.pumpWidget(
      ChangeNotifierProvider<AppState>.value(
        value: appState,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find "Queue" quick action which should have semantics
    final queueAction = find.byWidgetPredicate((widget) {
      if (widget is Semantics) {
        return widget.properties.label == 'Queue';
      }
      return false;
    });
    expect(queueAction, findsOneWidget);

    // Verify it has the button flag
    final semantics = tester.getSemantics(queueAction);
    expect(semantics.hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });
}
