import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('GlassCard accessibility and feedback verification', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () => tapped = true,
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    // Verify Semantics
    final semantics = tester.getSemantics(find.byType(GlassCard));
    // ignore: deprecated_member_use
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);

    // Verify InkWell exists for ripples
    expect(find.byType(InkWell), findsOneWidget);

    // Verify interaction
    await tester.tap(find.text('Test Content'));
    expect(tapped, isTrue);
  });

  testWidgets('KpiCard accessibility verification', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Total Patients',
            value: '128',
            subtitle: '+5 today',
            icon: Icons.people,
            color: Colors.blue,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(KpiCard));
    expect(semantics.label, 'Total Patients: 128, +5 today');
  });

  testWidgets('MetricCard accessibility verification', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(MetricCard));
    expect(semantics.label, 'Heart Rate: 72 bpm');
  });
}
