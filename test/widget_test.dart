import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/main.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('MedFlow Staff smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MedFlowStaffApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    // Clear pending timers from SplashScreen
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('GradientButton has semantics', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GradientButton(label: 'Test Button', onPressed: () {}),
      ),
    ));
    // Find the Semantics widget that is a descendant of GradientButton
    final semanticsFinder = find.descendant(
      of: find.byType(GradientButton),
      matching: find.byType(Semantics),
    );
    expect(semanticsFinder, findsOneWidget);

    final Semantics semanticsWidget = tester.widget(semanticsFinder);
    expect(semanticsWidget.properties.label, 'Test Button');
    expect(semanticsWidget.properties.button, true);
  });

  testWidgets('MedFlowAppBar back button has tooltip', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MedFlowAppBar(title: 'Test Title', showBack: true),
    ));

    final iconButtonFinder = find.byType(IconButton);
    expect(iconButtonFinder, findsOneWidget);

    final IconButton iconButton = tester.widget(iconButtonFinder);
    expect(iconButton.tooltip, 'Back');
  });
}
