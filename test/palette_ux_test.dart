import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/queue_home_screen.dart';
import 'package:medflow_staff/features/queue/triage_screen.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('QueueHomeScreen semantics verification', (WidgetTester tester) async {
    // Enable semantics
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(home: QueueHomeScreen()));

    // Triage legend chips
    final legendChip = find.bySemanticsLabel(RegExp(r'^Filter by .*'));
    expect(legendChip, findsAtLeastNWidgets(1));

    final legendSemantics = tester.getSemantics(legendChip.first);
    expect(legendSemantics.hasFlag(SemanticsFlag.isButton), true);

    // Status filter chips
    final statusChip = find.bySemanticsLabel('Filter by All');
    expect(statusChip, findsOneWidget);

    final statusSemantics = tester.getSemantics(statusChip);
    expect(statusSemantics.hasFlag(SemanticsFlag.isButton), true);
    expect(statusSemantics.hasFlag(SemanticsFlag.isSelected), true);

    handle.dispose();
  });

  testWidgets('TriageScreen semantics verification', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MaterialApp(home: TriageScreen(patientId: '1')));

    // Back button
    final backBtn = find.bySemanticsLabel('Back');
    expect(backBtn, findsOneWidget);
    expect(tester.getSemantics(backBtn).hasFlag(SemanticsFlag.isButton), true);

    // Quick complaints
    final complaintChip = find.bySemanticsLabel(RegExp(r'^Add .* to complaint'));
    expect(complaintChip, findsAtLeastNWidgets(1));
    expect(tester.getSemantics(complaintChip.first).hasFlag(SemanticsFlag.isButton), true);

    // Triage selector
    final triageSelector = find.bySemanticsLabel('Immediate');
    expect(triageSelector, findsOneWidget);
    expect(tester.getSemantics(triageSelector).hasFlag(SemanticsFlag.isButton), true);

    handle.dispose();
  });

  testWidgets('GlassCard semantics verification', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    bool tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GlassCard(
          onTap: () => tapped = true,
          child: const Text('Tappable Card'),
        ),
      ),
    ));

    final card = find.byType(GlassCard);
    expect(card, findsOneWidget);
    expect(tester.getSemantics(card).hasFlag(SemanticsFlag.isButton), true);

    await tester.tap(card);
    expect(tapped, true);

    handle.dispose();
  });
}
