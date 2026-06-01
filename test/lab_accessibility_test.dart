import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/lab/lab_home_screen.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('LabHomeScreen has enhanced accessibility and tooltips',
      (WidgetTester tester) async {
    final appState = AppState();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: const MaterialApp(
          home: LabHomeScreen(),
        ),
      ),
    );

    // Verify priority semantics
    expect(find.bySemanticsLabel(RegExp(r'Priority:.*')), findsAtLeastNWidgets(1));

    // Verify test chips semantics
    expect(find.bySemanticsLabel(RegExp(r'Test:.*')), findsAtLeastNWidgets(1));

    // Verify tooltips for buttons
    expect(find.byTooltip('Process lab order'), findsAtLeastNWidgets(1));
    expect(find.byTooltip('Enter lab results'), findsAtLeastNWidgets(1));
  });
}
