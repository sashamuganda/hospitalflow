import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('KpiCard UX Tests', () {
    testWidgets('KpiCard has summarized semantics', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Patients',
            value: '12',
            subtitle: '+2 today',
            icon: Icons.person,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ));

      // Check summarized semantics
      final semantics = tester.getSemantics(find.byType(KpiCard));
      expect(semantics.label, 'Patients: 12, +2 today');
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);

      // Verify internal elements are excluded from having their own semantics
      // Note: In Flutter widget tests, getSemantics(finder) might return the combined
      // semantics of the branch if the node itself is not a container, but here
      // we set container: true on the parent.

      // We expect the text "12" to be found but its semantics should be merged into parent.
      expect(find.text('12'), findsOneWidget);
    });
  });
}
