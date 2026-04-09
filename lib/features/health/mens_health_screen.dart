import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class MensHealthScreen extends StatelessWidget {
  const MensHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Men\'s Health'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCVRiskCard(context),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Hormonal Wellness'),
            const SizedBox(height: 12),
            _buildHormoneMetrics(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Musculoskeletal Health'),
            const SizedBox(height: 12),
            _buildStructuralCard(context),
            const SizedBox(height: 32),
            _buildProstateInsight(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCVRiskCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.tealGradient.withOpacity(0.15) as Gradient?,
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CV Risk Score (ASCVD)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Level: Low', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.success)),
                ],
              ),
              const Icon(Icons.monitor_heart_rounded, color: AppColors.primary, size: 32),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Cholesterol', '185', 'mg/dL'),
              _buildMetric('LDL', '110', 'mg/dL'),
              _buildMetric('HDL', '45', 'mg/dL'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(unit, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildHormoneMetrics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            label: 'Testosterone',
            value: '540',
            unit: 'ng/dL',
            icon: Icons.bolt_rounded,
            color: Colors.orange,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            label: 'Cortisol',
            value: '12',
            unit: 'µg/dL',
            icon: Icons.waves_rounded,
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildStructuralCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
           _buildStructuralRow('Back/Spine Health', 'Good', AppColors.success),
           const TealDivider(),
           _buildStructuralRow('Joint Mobility', 'Moderate', AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildStructuralRow(String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          StatusBadge(label: status.toUpperCase(), color: color, fontSize: 10),
        ],
      ),
    );
  }

  Widget _buildProstateInsight(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Prostate Screening', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Based on your age (42), regular PSA screening is recommended starting from age 45.',
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
