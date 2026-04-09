import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class HealthProfileScreen extends StatelessWidget {
  const HealthProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Health Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVitalStats(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Blood Information'),
            const SizedBox(height: 12),
            _buildStaticCard(context, 'Blood Group', 'A Positive (A+)', Icons.bloodtype_rounded, AppColors.error),
            const SizedBox(height: 12),
            _buildStaticCard(context, 'Genotype', 'AA', Icons.biotech_rounded, AppColors.primary),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Allergies'),
            const SizedBox(height: 12),
            _buildTagCloud(['Penicillin', 'Peanuts', 'Dust Mites'], AppColors.warning),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Chronic Conditions'),
            const SizedBox(height: 12),
            _buildTagCloud(['Mild Hypertension'], AppColors.secondary),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Lifestyle'),
            const SizedBox(height: 12),
            _buildLifestyleGrid(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Request Data Correction',
              icon: Icons.edit_note_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalStats(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildMetricTile(context, 'Height', '165 cm', Icons.height_rounded)),
        const SizedBox(width: 16),
        Expanded(child: _buildMetricTile(context, 'Weight', '67.6 kg', Icons.monitor_weight_rounded)),
      ],
    );
  }

  Widget _buildMetricTile(BuildContext context, String label, String value, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget _buildStaticCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagCloud(List<String> tags, Color color) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(t, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
      )).toList(),
    );
  }

  Widget _buildLifestyleGrid(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLifestyleRow('Smoking', 'Never', AppColors.success),
          const TealDivider(),
          _buildLifestyleRow('Alcohol', 'Occasionally', AppColors.warning),
          const TealDivider(),
          _buildLifestyleRow('Exercise', '3x Weekly', AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildLifestyleRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
