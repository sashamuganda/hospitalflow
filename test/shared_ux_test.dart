import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';
import 'package:medflow_staff/core/colors.dart';
import 'package:flutter/rendering.dart';

void main() {
  testWidgets('KpiCard accessibility semantics verification', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KpiCard(
            label: 'Total Patients',
            value: '150',
            subtitle: '+5 from yesterday',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ),
    );

    final semanticsFinder = find.bySemanticsLabel('150 Total Patients, +5 from yesterday');
    expect(semanticsFinder, findsOneWidget);

    final semanticsData = tester.getSemantics(semanticsFinder).getSemanticsData();
    expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);
    handle.dispose();
  });

  testWidgets('MetricCard accessibility semantics verification', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MetricCard(
            label: 'Heart Rate',
            value: '72',
            unit: 'bpm',
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () {},
          ),
        ),
      ),
    );

    final semanticsFinder = find.bySemanticsLabel('72 bpm Heart Rate');
    expect(semanticsFinder, findsOneWidget);

    final semanticsData = tester.getSemantics(semanticsFinder).getSemanticsData();
    expect(semanticsData.hasFlag(SemanticsFlag.isButton), true);
    handle.dispose();
  });

  testWidgets('GlassCard accessibility semantics verification when interactive', (WidgetTester tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlassCard(
            onTap: () {},
            child: const Text('Interactive Card'),
          ),
        ),
      ),
    );

    final semanticsFinder = find.byType(Semantics);
    // Find the one that has button flag
    bool foundButton = false;
    for (final element in tester.allElements) {
      if (element.widget is Semantics) {
        final data = tester.getSemantics(find.byWidget(element.widget)).getSemanticsData();
        if (data.hasFlag(SemanticsFlag.isButton)) {
          foundButton = true;
          break;
        }
      }
    }
    expect(foundButton, true, reason: 'GlassCard should have button semantics when onTap is provided');
    handle.dispose();
  });
}
