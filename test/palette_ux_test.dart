import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/staff/staff_directory_screen.dart';

void main() {
  testWidgets('StaffDirectoryScreen has correct accessibility semantics and tooltips', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: StaffDirectoryScreen(),
    ));

    // Verify Filter Chips have correct Semantics
    final allChip = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'All');
    expect(allChip, findsOneWidget);

    final Semantics allSemantics = tester.widget(allChip);
    expect(allSemantics.properties.button, isTrue);
    expect(allSemantics.properties.selected, isTrue); // 'All' is active by default
    // excludeSemantics is on the widget, not properties
    expect(allSemantics.excludeSemantics, isTrue);

    // Verify Email IconButton has correct tooltip
    final emailButton = find.byType(IconButton).first;
    expect(emailButton, findsOneWidget);

    final IconButton iconButton = tester.widget(emailButton);
    expect(iconButton.tooltip, 'Email Staff');
  });
}
