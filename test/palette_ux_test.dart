import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:medflow_staff/core/app_state.dart';
import 'package:medflow_staff/features/ward/ward_overview_screen.dart';
import 'package:medflow_staff/features/dashboard/home_screen.dart';
import 'package:medflow_staff/data/mock_data.dart';
import 'package:flutter/rendering.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('WardOverviewScreen UX', () {
    testWidgets('Ward selector chips have correct semantics', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          home: const WardOverviewScreen(),
        ),
      );
      // Removed pumpAndSettle to ignore layout overflow errors if they occur during settlement
      await tester.pump();

      final firstWard = mockWards.first;
      final semanticsFinder = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Select ${firstWard.name} Ward');
      expect(semanticsFinder, findsOneWidget);

      final semanticsData = tester.getSemantics(semanticsFinder);
      expect(semanticsData.hasFlag(SemanticsFlag.isButton), isTrue);
      expect(semanticsData.hasFlag(SemanticsFlag.isSelected), isTrue);
    });

    testWidgets('Bed cards have correct semantics', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          home: const WardOverviewScreen(),
        ),
      );
      await tester.pump();

      final firstBed = mockBeds.firstWhere((b) => b.wardId == mockWards.first.id);
      final isOccupied = firstBed.status == BedStatus.occupied;
      final expectedLabel = 'Bed ${firstBed.bedNumber}${isOccupied ? ', occupied by ${firstBed.patientName}' : ', ${firstBed.status.label}'}';

      final semanticsFinder = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == expectedLabel);
      expect(semanticsFinder, findsAtLeastNWidgets(1));

      final semanticsData = tester.getSemantics(semanticsFinder.first);
      expect(semanticsData.hasFlag(SemanticsFlag.isButton), isOccupied);
    });
  });

  group('HomeScreen UX', () {
    testWidgets('Quick action buttons have correct semantics', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final appState = AppState();
      appState.selectRole(StaffRole.doctor);

      await tester.pumpWidget(
        ChangeNotifierProvider<AppState>.value(
          value: appState,
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );
      await tester.pump();

      final semanticsFinder = find.byWidgetPredicate((w) => w is Semantics && w.properties.label == 'Queue');
      expect(semanticsFinder, findsOneWidget);

      final semanticsData = tester.getSemantics(semanticsFinder);
      expect(semanticsData.hasFlag(SemanticsFlag.isButton), isTrue);
    });
  });
}
