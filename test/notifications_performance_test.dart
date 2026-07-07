import 'package:flutter_test/flutter_test.dart';
import 'package:medflow_staff/data/mock_data.dart';

void main() {
  test('Benchmark NotificationsScreen logic with 10,000 items', () {
    final largeData = List.generate(
      10000,
      (i) => StaffNotification(
        id: 'n$i',
        title: 'Title $i',
        message: 'Message $i',
        type: i % 2 == 0 ? 'critical' : 'lab',
        time: DateTime.now(),
        isRead: i % 3 == 0,
      ),
    );

    final stopwatch = Stopwatch()..start();

    // Baseline approach: separate traversals and redundant calls
    int unreadCount = 0;
    int itemCount = 0;
    for (int i = 0; i < 100; i++) {
      unreadCount = largeData.where((n) => !n.isRead).length;
      itemCount = largeData.where((n) => n.type == 'critical').toList().length;
      // Simulate 10 visible items
      for (int j = 0; j < 10; j++) {
        var item = largeData.where((n) => n.type == 'critical').toList()[j];
      }
    }

    stopwatch.stop();
    print('Baseline logic (100 runs, 10 visible items): ${stopwatch.elapsedMicroseconds}us');

    stopwatch.reset();
    stopwatch.start();

    // Optimized approach: single traversal and caching
    int optUnreadCount = 0;
    List<StaffNotification> optFiltered = [];
    for (int i = 0; i < 100; i++) {
      optUnreadCount = 0;
      optFiltered = <StaffNotification>[];
      for (int j = 0; j < largeData.length; j++) {
        final n = largeData[j];
        if (!n.isRead) optUnreadCount++;
        if (n.type == 'critical') optFiltered.add(n);
      }
      int optItemCount = optFiltered.length;
      for (int j = 0; j < 10; j++) {
        var item = optFiltered[j];
      }
    }
    stopwatch.stop();
    print('Optimized logic (100 runs, 10 visible items): ${stopwatch.elapsedMicroseconds}us');

    expect(optUnreadCount, unreadCount);
    expect(optFiltered.length, itemCount);
  });
}
