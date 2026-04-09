import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class VitalsScreen extends StatelessWidget {
  const VitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Vitals Tracking'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChartCard(
              context,
              title: 'Blood Pressure',
              value: '118/76',
              unit: 'mmHg',
              color: AppColors.primary,
              chartData: MockVitals.bloodPressure,
              isBP: true,
            ),
            const SizedBox(height: 24),
            _buildChartCard(
              context,
              title: 'Heart Rate',
              value: '72',
              unit: 'bpm',
              color: AppColors.error,
              chartData: MockVitals.heartRate,
            ),
            const SizedBox(height: 24),
            _buildChartCard(
              context,
              title: 'Blood Glucose',
              value: '88',
              unit: 'mg/dL',
              color: AppColors.warning,
              chartData: MockVitals.bloodGlucose,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/health/vitals/entry'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: AppColors.background),
        label: const Text('Log Vital', style: TextStyle(color: AppColors.background, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildChartCard(
    BuildContext context, {
    required String title,
    required String value,
    required String unit,
    required Color color,
    required List<VitalReading> chartData,
    bool isBP = false,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.labelSmall),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(width: 4),
                      Text(unit, style: const TextStyle(fontSize: 14, color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Normal', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
                    isCurved: true,
                    color: color,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withOpacity(0.1),
                    ),
                  ),
                  if (isBP)
                    LineChartBarData(
                      spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value2 ?? 0)).toList(),
                      isCurved: true,
                      color: color.withOpacity(0.4),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.history_rounded, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 6),
              const Text('Past 14 days', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Full History')),
            ],
          ),
        ],
      ),
    );
  }
}
