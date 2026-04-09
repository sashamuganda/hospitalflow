import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class BodyMetricsScreen extends StatelessWidget {
  const BodyMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Body Metrics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBmiCard(context),
            const SizedBox(height: 24),
            _buildWeightChart(context),
            const SizedBox(height: 24),
            _buildOtherMetrics(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: AppColors.background),
        label: const Text('Log Weight', style: TextStyle(color: AppColors.background, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBmiCard(BuildContext context) {
    final bmi = MockVitals.bmi;
    String category = 'Normal';
    Color color = AppColors.success;
    
    if (bmi < 18.5) { category = 'Underweight'; color = AppColors.warning; }
    else if (bmi >= 25 && bmi < 30) { category = 'Overweight'; color = AppColors.warning; }
    else if (bmi >= 30) { category = 'Obese'; color = AppColors.error; }

    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: color.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Your Body Mass Index (BMI)', style: Theme.of(context).textTheme.labelSmall),
                   const SizedBox(height: 4),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                     children: [
                       Text(bmi.toStringAsFixed(1), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                       const SizedBox(width: 8),
                       Text(category, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
                     ],
                   ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.accessibility_new_rounded, color: color, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          Text(
            'Keep it up! Your BMI is within the healthy range. Maintaining a healthy weight reduces your risk of chronic conditions.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightChart(BuildContext context) {
    final data = MockVitals.weight;
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Weight Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          const Text('Last 30 days', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 32),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
                    isCurved: true,
                    color: AppColors.secondary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, color: AppColors.secondary.withOpacity(0.1)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSimpleStat('Start', '68.2 kg'),
              _buildSimpleStat('Current', '67.6 kg'),
              _buildSimpleStat('Diff', '-0.6 kg', color: AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color ?? AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildOtherMetrics(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildMetricTile(context, 'Height', '165 cm', Icons.height_rounded)),
            const SizedBox(width: 16),
            Expanded(child: _buildMetricTile(context, 'Waist', '78 cm', Icons.straighten_rounded)),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile(BuildContext context, String label, String value, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
