import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Sleep Tracking'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSleepScoreCard(context),
            const SizedBox(height: 24),
            _buildSleepChart(context),
            const SizedBox(height: 24),
            _buildSleepStages(context),
            const SizedBox(height: 32),
            _buildInsights(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepScoreCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: Colors.indigo.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sleep Score', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 4),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('84', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.indigoAccent)),
                  SizedBox(width: 4),
                  Text('/ 100', style: TextStyle(fontSize: 16, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Duration', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              Text('7h 24m', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSleepChart(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sleep Duration Trend', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeGroup(0, 6.5),
                  _makeGroup(1, 7.2),
                  _makeGroup(2, 5.8),
                  _makeGroup(3, 8.1),
                  _makeGroup(4, 6.9),
                  _makeGroup(5, 7.5),
                  _makeGroup(6, 7.4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text('Last 7 Days', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.indigoAccent,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildSleepStages(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sleep Stages', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildStageRow('Deep Sleep', '1h 12m', 0.15, Colors.indigo),
          const SizedBox(height: 12),
          _buildStageRow('Light Sleep', '4h 45m', 0.65, Colors.blue),
          const SizedBox(height: 12),
          _buildStageRow('REM', '1h 27m', 0.20, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStageRow(String label, String value, double percent, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: percent,
          color: color,
          backgroundColor: color.withOpacity(0.1),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }

  Widget _buildInsights(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: Colors.amber, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sleep Insight', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Your deep sleep is up 10% this week. Aim for a consistent bedtime to maintain this.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
