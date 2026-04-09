import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class HealthInsightsScreen extends StatelessWidget {
  const HealthInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Health Insights'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildYearlyProgressCard(context),
            const SizedBox(height: 32),
            Text('Actionable Insights', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildInsightItem(
              context,
              'Cardiovascular Trend',
              'Your resting heart rate has decreased by 5bpm over the last 6 months. This indicates improved cardiovascular efficiency.',
              Icons.trending_down_rounded,
              AppColors.success,
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              context,
              'Activity Consistency',
              'You hit your step goal 22 days last month. Consistency is higher than your average for 2024.',
              Icons.star_rounded,
              AppColors.primary,
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              context,
              'Sleep Quality Correlation',
              'Higher protein intake in the evening correlates with 15% more deep sleep in your data.',
              Icons.bedtime_rounded,
              AppColors.secondary,
            ),
            const SizedBox(height: 32),
            _buildGoalSummary(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Download Full Year Report',
              icon: Icons.picture_as_pdf_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildYearlyProgressCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Wellness Trend (2025)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 65),
                      FlSpot(1, 68),
                      FlSpot(2, 72),
                      FlSpot(3, 70),
                      FlSpot(4, 75),
                      FlSpot(5, 78),
                      FlSpot(6, 82),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 4,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.1)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Overall Health Score: +17% YoY', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(BuildContext context, String title, String body, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(body, style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Goal Status', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        _buildGoalProgress('Weight Goal (65kg)', 0.8, '67.6kg'),
        const SizedBox(height: 12),
        _buildGoalProgress('Sleep Consistency', 0.95, '95%'),
        const SizedBox(height: 12),
        _buildGoalProgress('BP Management', 1.0, 'Controlled'),
      ],
    );
  }

  Widget _buildGoalProgress(String label, double progress, String status) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Text(status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
        ],
      ),
    );
  }
}
