import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _filter = 'All';
  final _filters = ['All', 'Critical', 'Lab', 'Appointment', 'System'];

  List<StaffNotification> get _filtered {
    if (_filter == 'All') return mockNotifications;
    return mockNotifications.where((n) => n.type.toLowerCase() == _filter.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Notifications', style: Theme.of(context).textTheme.headlineSmall)),
                    StatusBadge(
                      label: '${mockNotifications.where((n) => !n.isRead).length} new',
                      color: AppColors.error),
                  ],
                ),
              ),
              // Filter chips
              SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: _filters.length,
                  itemBuilder: (context, i) {
                    final f = _filters[i];
                    final isActive = _filter == f;
                    return GestureDetector(
                      onTap: () => setState(() => _filter = f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.primary : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isActive ? AppColors.primary : AppColors.divider),
                        ),
                        child: Text(f,
                          style: TextStyle(fontFamily: 'Inter', fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isActive ? AppColors.textOnPrimary : AppColors.textSecondary)),
                      ),
                    );
                  },
                ),
              ),
              // List
              Expanded(
                child: _filtered.isEmpty
                    ? const EmptyState(
                        icon: Icons.notifications_off_outlined,
                        title: 'No Notifications',
                        message: 'You\'re all caught up.')
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        itemCount: _filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, i) => _NotificationCard(notif: _filtered[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final StaffNotification notif;
  const _NotificationCard({required this.notif});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: notif.isRead ? null : notif.typeColor.withOpacity(0.4),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: notif.typeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: notif.typeColor.withOpacity(0.3)),
            ),
            child: Icon(notif.typeIcon, color: notif.typeColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(notif.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: notif.isRead ? AppColors.textSecondary : AppColors.textPrimary)),
                    ),
                    if (!notif.isRead)
                      Container(width: 8, height: 8,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(notif.message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4)),
                const SizedBox(height: 8),
                Text(_formatTime(notif.time),
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
