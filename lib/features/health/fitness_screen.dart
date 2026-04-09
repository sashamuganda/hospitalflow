import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Fitness & Activity'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivityRings(context),
            const SizedBox(height: 24),
            Text('Daily Stats', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildDailyStats(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Step Trend (7 Days)'),
            const SizedBox(height: 12),
            _buildStepChart(context),
            const SizedBox(height: 32),
            _buildWorkoutHistory(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRings(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(value: 0.8, strokeWidth: 8, color: AppColors.primary, strokeCap: StrokeCap.round),
                SizedBox(width: 80, height: 80, child: CircularProgressIndicator(value: 0.6, strokeWidth: 8, color: AppColors.secondary, strokeCap: StrokeCap.round)),
                SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: 0.4, strokeWidth: 8, color: AppColors.success, strokeCap: StrokeCap.round)),
                const Icon(Icons.fitness_center_rounded, color: AppColors.textMuted, size: 24),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRingLegend('Moves', '480 kcal', AppColors.primary),
                const SizedBox(height: 8),
                _buildRingLegend('Exercise', '32 min', AppColors.secondary),
                const SizedBox(height: 8),
                _buildRingLegend('Stand', '10/12 hr', AppColors.success),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRingLegend(String label, String value, Color color) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDailyStats(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildStatTile(context, 'Steps', '8,421', Icons.directions_walk_rounded, AppColors.primary)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatTile(context, 'Calories', '1,240', Icons.local_fire_department_rounded, AppColors.error)),
      ],
    );
  }

  Widget _buildStatTile(BuildContext context, String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget _buildStepChart(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120,
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: [
              _makeGroup(0, 5200),
              _makeGroup(1, 8400),
              _makeGroup(2, 6100),
              _makeGroup(3, 4200),
              _makeGroup(4, 10500),
              _makeGroup(5, 7800),
              _makeGroup(6, 8421),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primary,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildWorkoutHistory(BuildContext context) {
    final workouts = [
      {'type': 'Morning Run', 'duration': '35 min', 'kcal': '320', 'icon': Icons.directions_run_rounded},
      {'type': 'Yoga Session', 'duration': '45 min', 'kcal': '110', 'icon': Icons.self_improvement_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Workouts', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...workouts.map((w) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(w['icon'] as IconData, color: AppColors.secondary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(w['type'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${w['duration']} • ${w['kcal']} kcal', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
