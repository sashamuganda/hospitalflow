import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class MedicationDetailScreen extends StatelessWidget {
  final String medicationId;

  const MedicationDetailScreen({super.key, required this.medicationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Medication Detail'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildMedicationHero(context),
            const SizedBox(height: 32),
            _buildDosageSchedule(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Directions for Use'),
            const SizedBox(height: 12),
            const GlassCard(
              padding: EdgeInsets.all(16),
              child: Text(
                'Take with food to minimize stomach upset. Complete the full course as prescribed. Avoid alcohol during treatment.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Safety Insights'),
            const SizedBox(height: 12),
            _buildSafetyInsight(Icons.warning_amber_rounded, 'Common Side Effects', 'Nausea, dizziness, mild rash.', AppColors.warning),
            const SizedBox(height: 12),
            _buildSafetyInsight(Icons.info_outline_rounded, 'Generic Alternative', 'Amoxicillin is also available under the brand name Amoxil.', AppColors.secondary),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Request Refill',
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationHero(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.medication_rounded, color: AppColors.secondary, size: 48),
        ),
        const SizedBox(height: 16),
        const Text('Amoxicillin 500mg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const Text('Antibiotic • 14 capsules total', style: TextStyle(color: AppColors.textMuted)),
        const SizedBox(height: 12),
        const StatusBadge(label: 'ACTIVE', color: AppColors.success),
      ],
    );
  }

  Widget _buildDosageSchedule(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Daily Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('3x Daily', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 16),
          _buildTimeRow('Morning', '08:00 AM', true),
          _buildTimeRow('Afternoon', '02:00 PM', false),
          _buildTimeRow('Evening', '08:00 PM', false),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String period, String time, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(completed ? Icons.check_circle_rounded : Icons.radio_button_off_rounded, color: completed ? AppColors.success : AppColors.divider, size: 20),
          const SizedBox(width: 12),
          Text(period, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(time, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSafetyInsight(IconData icon, String title, String value, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
