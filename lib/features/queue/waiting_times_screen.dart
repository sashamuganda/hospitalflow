import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class WaitingTimesScreen extends StatelessWidget {
  const WaitingTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = _deptStats();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Wait Times', style: Theme.of(context).textTheme.headlineSmall),
                ]),
              ),
              const SizedBox(height: 20),
              // Summary KPI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(child: KpiCard(label: 'Avg Wait Time', value: '${mockKPIs.avgWaitTimeMinutes.toInt()} min',
                    icon: Icons.timer_outlined, color: AppColors.primary)),
                  const SizedBox(width: 12),
                  Expanded(child: KpiCard(label: 'Queue Size', value: '${mockQueue.length}',
                    icon: Icons.people_alt_rounded, color: AppColors.secondary)),
                ]),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const SectionHeader(title: 'By Department'),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: departments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => _DeptWaitCard(stats: departments[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_DeptStats> _deptStats() {
    final Map<String, List<PatientInQueue>> byDept = {};
    for (final p in mockQueue) {
      byDept.putIfAbsent(p.department, () => []).add(p);
    }
    return byDept.entries.map((e) {
      final waiting = e.value.where((p) => p.status == QueueStatus.waiting).length;
      final avgWait = e.value.isEmpty ? 0 : e.value.map((p) => p.waitMinutes).reduce((a, b) => a + b) ~/ e.value.length;
      final hasImmediate = e.value.any((p) => p.triageLevel == TriageLevel.immediate);
      return _DeptStats(name: e.key, patientCount: e.value.length, waitingCount: waiting,
        avgWaitMinutes: avgWait, hasImmediate: hasImmediate);
    }).toList();
  }
}

class _DeptStats {
  final String name;
  final int patientCount;
  final int waitingCount;
  final int avgWaitMinutes;
  final bool hasImmediate;
  const _DeptStats({required this.name, required this.patientCount, required this.waitingCount,
    required this.avgWaitMinutes, required this.hasImmediate});

  Color get statusColor {
    if (hasImmediate) return AppColors.error;
    if (avgWaitMinutes > 45) return AppColors.warning;
    return AppColors.success;
  }

  String get statusLabel {
    if (hasImmediate) return 'CRITICAL';
    if (avgWaitMinutes > 45) return 'BUSY';
    return 'NORMAL';
  }
}

class _DeptWaitCard extends StatelessWidget {
  final _DeptStats stats;
  const _DeptWaitCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final pct = (stats.avgWaitMinutes / 90).clamp(0.0, 1.0);
    return GlassCard(
      borderColor: stats.statusColor.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(stats.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('${stats.patientCount} patients · ${stats.waitingCount} waiting',
                  style: Theme.of(context).textTheme.bodySmall),
              ]),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              StatusBadge(label: stats.statusLabel, color: stats.statusColor, fontSize: 10),
              const SizedBox(height: 4),
              Text('${stats.avgWaitMinutes} min avg',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                  color: stats.statusColor, fontFamily: 'Inter')),
            ]),
          ]),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(stats.statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
