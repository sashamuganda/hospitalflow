import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/widgets/shared_widgets.dart';

void main() {
  group('GlassCard UX Tests', () {
    testWidgets('GlassCard has isButton semantic flag when onTap is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              onTap: () {},
              child: const Text('Clickable Card'),
            ),
          ),
        ),
      );

      final Finder cardFinder = find.byType(GlassCard);
      final SemanticsNode node = tester.getSemantics(cardFinder);

      expect(node.hasFlag(SemanticsFlag.isButton), isTrue,
          reason: 'GlassCard should have isButton semantic flag when onTap is provided');
    });

    testWidgets('GlassCard does not have isButton semantic flag when onTap is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassCard(
              child: Text('Static Card'),
            ),
          ),
        ),
      );

      final Finder cardFinder = find.byType(GlassCard);
      final SemanticsNode node = tester.getSemantics(cardFinder);

      expect(node.hasFlag(SemanticsFlag.isButton), isFalse,
          reason: 'GlassCard should NOT have isButton semantic flag when onTap is null');
    });

    testWidgets('GlassCard triggers onTap and provides ripple feedback (InkWell)', (WidgetTester tester) async {
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

      final Finder inkWellFinder = find.byType(InkWell);
      expect(inkWellFinder, findsOneWidget, reason: 'GlassCard should contain an InkWell for ripple effects');

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue, reason: 'onTap should be called when card is tapped');
    });
  });
}
