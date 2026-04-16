import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class AnalyticsHomeScreen extends StatelessWidget {
  const AnalyticsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Analytics',
                            style: Theme.of(context).textTheme.headlineMedium)),
                    IconButton(
                        icon: const Icon(Icons.download_rounded,
                            color: AppColors.primary),
                        onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  children: [
                    Text('Today\'s Performance',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: _StatCard(
                                title: 'OPD Patients',
                                value: '${mockKPIs.todayOPDCount}',
                                icon: Icons.people_rounded,
                                color: AppColors.primary)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _StatCard(
                                title: 'Wait Time',
                                value: '${mockKPIs.avgWaitTimeMinutes}m',
                                icon: Icons.timer_rounded,
                                color: AppColors.warning)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: _StatCard(
                                title: 'IPD Occupancy',
                                value:
                                    '${mockKPIs.ipdOccupancyPercent.toInt()}%',
                                icon: Icons.bed_rounded,
                                color: AppColors.secondary)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _StatCard(
                                title: 'Staff Duty',
                                value: '${mockKPIs.staffOnDuty}',
                                icon: Icons.badge_rounded,
                                color: AppColors.success)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Patient Flow Trends',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _Bar(day: 'Mon', height: 120, label: '142'),
                            _Bar(day: 'Tue', height: 150, label: '168'),
                            _Bar(day: 'Wed', height: 90, label: '105'),
                            _Bar(
                                day: 'Thu',
                                height: 180,
                                label: '190',
                                color: AppColors.warning),
                            _Bar(day: 'Fri', height: 140, label: '155'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Critical Alerts',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    GlassCard(
                      padding: const EdgeInsets.all(16),
                      borderColor: AppColors.error.withOpacity(0.3),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.warning_rounded,
                                color: AppColors.error),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('ICU Nearing Capacity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.error)),
                                const SizedBox(height: 4),
                                const Text(
                                    'Current occupancy is at 85%. Action recommended.',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          fontFamily: 'Inter'))),
            ],
          ),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontFamily: 'Inter')),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final String day;
  final String label;
  final Color color;

  const _Bar(
      {required this.height,
      required this.day,
      required this.label,
      this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Container(
            width: 32,
            height: height,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 8),
        Text(day,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }
}
