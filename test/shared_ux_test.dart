import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('KpiCard should have button semantics and custom label when onTap is provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Test KPI',
            value: '100',
            subtitle: '+5',
            icon: Icons.add,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ),
    );

    final finder = find.byType(KpiCard);
    final SemanticsData semantics = tester.getSemantics(finder).getSemanticsData();
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue, reason: 'KpiCard should have isButton flag');
    expect(semantics.label, equals('Test KPI: 100, +5'));
  });
}
