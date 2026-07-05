import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  test('Benchmark NotificationsScreen logic complexity', () {
    // Generate a large dataset to make performance differences measurable
    final largeMockNotifications = List.generate(10000, (i) => StaffNotification(
      id: 'n$i',
      title: 'Notification $i',
      message: 'Message $i',
      type: i % 4 == 0 ? 'critical' : (i % 4 == 1 ? 'lab' : (i % 4 == 2 ? 'appointment' : 'system')),
      time: DateTime.now().subtract(Duration(minutes: i)),
      isRead: i % 2 == 0,
    ));

    final stopwatch = Stopwatch()..start();

    // Current (unoptimized) style logic: multiple O(N) passes
    // 1. pass for unread count
    final unreadCount = largeMockNotifications.where((n) => !n.isRead).length;
    // 2. pass for filtering
    final filter = 'Critical';
    final filtered = largeMockNotifications
        .where((n) => n.type.toLowerCase() == filter.toLowerCase())
        .toList();

    stopwatch.stop();
    print('Baseline logic execution time: ${stopwatch.elapsedMicroseconds}us');
    print('Unread count: $unreadCount, Filtered count: ${filtered.length}');

    final stopwatchOptimized = Stopwatch()..start();

    // Optimized style logic: single O(N) pass
    int optUnreadCount = 0;
    final List<StaffNotification> optFiltered = [];
    final filterLower = filter.toLowerCase();
    final isFilterAll = filterLower == 'all';

    for (final n in largeMockNotifications) {
      if (!n.isRead) optUnreadCount++;
      if (isFilterAll || n.type.toLowerCase() == filterLower) {
        optFiltered.add(n);
      }
    }

    stopwatchOptimized.stop();
    print('Optimized logic execution time: ${stopwatchOptimized.elapsedMicroseconds}us');

    expect(optUnreadCount, unreadCount);
    expect(optFiltered.length, filtered.length);
  });
}
