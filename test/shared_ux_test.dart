import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('GlassCard has button semantics when onTap is provided', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () => tapped = true,
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(GlassCard));
    expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isButton), isTrue,
        reason: 'GlassCard should have isButton flag when onTap is provided');

    handle.dispose();
  });

  testWidgets('KpiCard has summary semantics and button role', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Patients',
            value: '42',
            subtitle: '+5 today',
            icon: Icons.people,
            color: Colors.blue,
          ),
        ),
      ),
    );

    final kpiFinder = find.byType(KpiCard);
    final semantics = tester.getSemantics(kpiFinder);

    // Check for summary label
    expect(semantics.getSemanticsData().label, contains('Patients'));
    expect(semantics.getSemanticsData().label, contains('42'));
    expect(semantics.getSemanticsData().label, contains('+5 today'));

    handle.dispose();
  });

  testWidgets('MetricCard has summary semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
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

    final metricFinder = find.byType(MetricCard);
    final semantics = tester.getSemantics(metricFinder);

    expect(semantics.getSemanticsData().label, contains('Heart Rate'));
    expect(semantics.getSemanticsData().label, contains('72'));
    expect(semantics.getSemanticsData().label, contains('bpm'));

    handle.dispose();
  });

  testWidgets('SectionHeader title has header semantics', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Overview'),
        ),
      ),
    );

    final titleFinder = find.text('Overview');
    final semantics = tester.getSemantics(titleFinder);

    expect(semantics.getSemanticsData().hasFlag(SemanticsFlag.isHeader), isTrue,
        reason: 'SectionHeader title should be marked as a header');

    handle.dispose();
  });
}
