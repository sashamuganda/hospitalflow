import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('GlassCard has correct semantics and haptics', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GlassCard(
          onTap: () => tapped = true,
          child: const Text('Tap Me'),
        ),
      ),
    ));

    final semantics = tester.getSemantics(find.byType(GlassCard));
    expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

    await tester.tap(find.byType(GlassCard));
    expect(tapped, true);
    handle.dispose();
  });

  testWidgets('KpiCard has correct semantics and haptics', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: KpiCard(
          label: 'Patients',
          value: '42',
          subtitle: '+2 today',
          icon: Icons.person,
          color: Colors.blue,
          onTap: () => tapped = true,
        ),
      ),
    ));

    final semantics = tester.getSemantics(find.byType(KpiCard));
    expect(semantics.label, 'Patients: 42, +2 today');
    expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

    await tester.tap(find.byType(KpiCard));
    expect(tapped, true);
    handle.dispose();
  });

  testWidgets('MetricCard has correct semantics and haptics', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
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
    ));

    final semantics = tester.getSemantics(find.byType(MetricCard));
    expect(semantics.label, 'Heart Rate: 72 bpm');
    expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), true);

    await tester.tap(find.byType(MetricCard));
    expect(tapped, true);
    handle.dispose();
  });
}
