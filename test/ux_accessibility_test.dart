import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('Accessibility and Micro-UX Verification', () {
    testWidgets('KpiCard has descriptive semantics and button role', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Total Patients',
            value: '128',
            subtitle: '+5 from yesterday',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ));

      final semanticsFinder = find.byType(KpiCard);
      final semanticsData = tester.getSemantics(semanticsFinder);

      expect(semanticsData.label, 'Total Patients: 128 +5 from yesterday');
      expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);
    });
  });
}
