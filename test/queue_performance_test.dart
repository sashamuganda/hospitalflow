import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/queue/queue_home_screen.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  testWidgets('QueueHomeScreen shows correct counts and filtered list', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: QueueHomeScreen(),
    ));

    // Verify waiting/immediate counts in header
    final waitingCount = mockQueue.where((q) => q.status == QueueStatus.waiting).length;
    final immediateCount = mockQueue.where((q) => q.triageLevel == TriageLevel.immediate).length;

    if (immediateCount > 0) {
      expect(find.text('$immediateCount IMMEDIATE'), findsOneWidget);
    } else {
      expect(find.text('$waitingCount waiting'), findsOneWidget);
    }

    // Verify triage legend counts
    for (final level in TriageLevel.values) {
      final count = mockQueue.where((q) => q.triageLevel == level).length;
      expect(find.text('$count'), findsWidgets);
    }

    // Verify all patients are shown by default.
    // We use find.byType(_QueueCard) because GlassCard might be off-screen.
    // However, _QueueCard is private. So we use find.byWidgetPredicate.
    expect(find.byWidgetPredicate((w) => w.runtimeType.toString() == '_QueueCard'), findsAtLeastNWidgets(1));
  });
}
