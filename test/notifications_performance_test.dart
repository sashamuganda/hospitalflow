import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  test('NotificationsScreen Logic Performance Benchmark', () {
    // Generate a large dataset for benchmarking
    final largeMockNotifications = List.generate(10000, (i) => StaffNotification(
      id: 'n$i',
      title: 'Notification $i',
      message: 'Message $i',
      type: i % 4 == 0 ? 'critical' : (i % 4 == 1 ? 'lab' : (i % 4 == 2 ? 'appointment' : 'system')),
      time: DateTime.now(),
      isRead: i % 2 == 0,
    ));

    const filter = 'Lab';
    final filterLower = filter.toLowerCase();

    // Baseline: Separate traversals (O(2N))
    final stopwatchBaseline = Stopwatch()..start();

    // Traversal 1: Unread count
    final unreadCountBaseline = largeMockNotifications.where((n) => !n.isRead).length;

    // Traversal 2: Filtering
    final filteredBaseline = (filter == 'All')
        ? largeMockNotifications
        : largeMockNotifications
            .where((n) => n.type.toLowerCase() == filter.toLowerCase())
            .toList();

    stopwatchBaseline.stop();

    // Optimized: Single pass (O(N))
    final stopwatchOptimized = Stopwatch()..start();

    int unreadCountOptimized = 0;
    List<StaffNotification> filteredOptimized;
    const isAll = filter == 'All';

    if (isAll) {
      filteredOptimized = largeMockNotifications;
      for (final n in largeMockNotifications) {
        if (!n.isRead) unreadCountOptimized++;
      }
    } else {
      filteredOptimized = <StaffNotification>[];
      for (final n in largeMockNotifications) {
        if (!n.isRead) unreadCountOptimized++;
        if (n.type.toLowerCase() == filterLower) {
          filteredOptimized.add(n);
        }
      }
    }

    stopwatchOptimized.stop();

    // Verification
    expect(unreadCountOptimized, unreadCountBaseline);
    expect(filteredOptimized.length, filteredBaseline.length);

    expect(stopwatchOptimized.elapsedMicroseconds, lessThan(stopwatchBaseline.elapsedMicroseconds),
      reason: 'Optimized logic should be faster than baseline');
  });
}
