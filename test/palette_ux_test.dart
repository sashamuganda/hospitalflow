import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/staff/staff_directory_screen.dart';

void main() {
  testWidgets('StaffDirectoryScreen UX Verification', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: StaffDirectoryScreen()));

    // Verify tooltip on email icon buttons
    final emailButtons = find.byType(IconButton);
    expect(emailButtons, findsWidgets);
    final firstEmailButton = tester.widget<IconButton>(emailButtons.first);
    expect(firstEmailButton.tooltip, 'Email Staff');

    // Verify Semantics on _FilterChip
    final filterChipSemantics = find.byWidgetPredicate(
      (widget) => widget is Semantics &&
                  widget.properties.button == true &&
                  widget.properties.selected != null &&
                  widget.properties.label != null
    );
    expect(filterChipSemantics, findsAtLeastNWidgets(1));

    final firstChip = tester.widget<Semantics>(filterChipSemantics.first);
    expect(firstChip.excludeSemantics, true);
    expect(firstChip.properties.label, isNotEmpty);
  });
}
