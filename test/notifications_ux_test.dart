import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/features/dashboard/notifications_screen.dart';
import 'package:medflow_staff/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';

void main() {
  testWidgets('NotificationsScreen has correct accessibility semantics', (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const NotificationsScreen(),
        ),
      ),
    );

    // Verify Back Button Semantics
    final backButton = find.bySemanticsLabel('Back');
    expect(backButton, findsOneWidget);

    final backSemantics = tester.getSemantics(backButton);
    expect(backSemantics.hasFlag(SemanticsFlag.isButton), isTrue);

    // Verify Filter Chips Semantics
    expect(find.bySemanticsLabel('Filter by All'), findsOneWidget);
    expect(find.bySemanticsLabel('Filter by Critical'), findsOneWidget);

    final allFilter = tester.getSemantics(find.bySemanticsLabel('Filter by All'));
    expect(allFilter.hasFlag(SemanticsFlag.isSelected), isTrue);
    expect(allFilter.hasFlag(SemanticsFlag.isButton), isTrue);

    final criticalFilter = tester.getSemantics(find.bySemanticsLabel('Filter by Critical'));
    expect(criticalFilter.hasFlag(SemanticsFlag.isSelected), isFalse);
    expect(criticalFilter.hasFlag(SemanticsFlag.isButton), isTrue);

    semantics.dispose();
  });
}
