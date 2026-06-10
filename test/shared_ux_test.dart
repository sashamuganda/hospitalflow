import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('SectionHeader should have header semantics', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Test Header'),
        ),
      ),
    );

    final headerFinder = find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.header == true && widget.child is Text && (widget.child as Text).data == 'Test Header'
    );
    expect(headerFinder, findsOneWidget);
  });

  testWidgets('KpiCard should have button semantics and label when interactive', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Patients',
            value: '12',
            icon: Icons.person,
            color: Colors.blue,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final finder = find.byType(KpiCard);
    final semantics = tester.getSemantics(finder);

    expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), isTrue);
    expect(semantics.getSemanticsData().label, '12 Patients');

    await tester.tap(finder);
    expect(tapped, isTrue);
  });

  testWidgets('MetricCard should have button semantics and label when interactive', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    final finder = find.byType(MetricCard);
    final semantics = tester.getSemantics(finder);

    expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), isTrue);
    expect(semantics.getSemanticsData().label, '72 bpm Heart Rate');

    await tester.tap(finder);
    expect(tapped, isTrue);
  });

  testWidgets('GlassCard should have button semantics when interactive', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () => tapped = true,
            child: const Text('Click me'),
          ),
        ),
      ),
    );

    final finder = find.byType(GlassCard);
    final semantics = tester.getSemantics(finder);

    expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), isTrue);

    await tester.tap(finder);
    expect(tapped, isTrue);
  });
}
