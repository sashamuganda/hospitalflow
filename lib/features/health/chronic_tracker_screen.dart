import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ChronicTrackerScreen extends StatelessWidget {
  const ChronicTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Chronic Management'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConditionSummary(context, 'Hypertension', 'Controlled', AppColors.success),
            const SizedBox(height: 24),
            _buildConditionSummary(context, 'Iron Deficiency', 'Managing', AppColors.warning),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Symptom Logger'),
            const SizedBox(height: 12),
            _buildSymptomLog(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Trigger Analysis'),
            const SizedBox(height: 12),
            _buildTriggerCard(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionSummary(BuildContext context, String title, String status, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: color.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  const Text('Last checked: 2 days ago', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
              StatusBadge(label: status.toUpperCase(), color: color, fontSize: 10),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat('Readings', '14/14', 'Past 2 weeks'),
              _buildMiniStat('Adherence', '98%', 'On target'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, String subtitle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildSymptomLog(BuildContext context) {
    final symptoms = ['Fatigue', 'Dizziness', 'Shortness of breath', 'Chest pain', 'Headache'];
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Did you experience any of these today?', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: symptoms.map((s) => FilterChip(
              label: Text(s, style: const TextStyle(fontSize: 12)),
              selected: false,
              onSelected: (val) {},
              backgroundColor: AppColors.surface,
              side: BorderSide(color: AppColors.divider),
            )).toList(),
          ),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Add Tracking Entry',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.psychology_alt_rounded, color: AppColors.warning, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Potential Triggers Identified', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Your BP spikes correlate with "High Stress" mental states tagged in your wellness log.',
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
