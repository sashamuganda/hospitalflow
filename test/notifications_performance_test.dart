import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  group('NotificationsScreen Performance Benchmark', () {
    final largeData = List.generate(10000, (i) => StaffNotification(
      id: 'n$i',
      title: 'Notif $i',
      message: 'Message for $i',
      type: i % 4 == 0 ? 'critical' : (i % 4 == 1 ? 'lab' : (i % 4 == 2 ? 'appointment' : 'system')),
      time: DateTime.now(),
      isRead: i % 2 == 0,
    ));

    test('Baseline: Multi-pass approach', () {
      final stopwatch = Stopwatch()..start();

      const filter = 'Critical';

      // Pass 1: Get unread count (O(N))
      final unreadCount = largeData.where((n) => !n.isRead).length;

      // Pass 2: Filter (O(N))
      final filtered = largeData.where((n) => n.type.toLowerCase() == filter.toLowerCase()).toList();

      stopwatch.stop();
      print('Baseline execution time for 10k items: ${stopwatch.elapsedMicroseconds}us');
      print('Unread: $unreadCount, Filtered: ${filtered.length}');
    });

    test('Optimized: Single-pass approach', () {
      final stopwatch = Stopwatch()..start();

      const filter = 'Critical';
      final filterLower = filter.toLowerCase();

      int unreadCount = 0;
      final List<StaffNotification> filtered = [];

      for (final n in largeData) {
        if (!n.isRead) unreadCount++;
        if (filter == 'All' || n.type.toLowerCase() == filterLower) {
          filtered.add(n);
        }
      }

      stopwatch.stop();
      print('Optimized execution time for 10k items: ${stopwatch.elapsedMicroseconds}us');
      print('Unread: $unreadCount, Filtered: ${filtered.length}');
    });
  });
}
