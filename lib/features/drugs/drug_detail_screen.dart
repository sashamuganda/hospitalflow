import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class DrugDetailScreen extends StatelessWidget {
  final String drugId;

  const DrugDetailScreen({super.key, required this.drugId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Medication Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 32),
            _buildActionButtons(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Dosage & Administration'),
            const SizedBox(height: 12),
            const Text(
              'For adults: 625mg twice daily (every 12 hours) for 5-7 days or as prescribed. Should be taken at the start of a meal to minimize gastrointestinal intolerance.',
              style: TextStyle(height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Common Side Effects'),
            const SizedBox(height: 12),
            _buildSideEffects(context),
            const SizedBox(height: 32),
            _buildPrecautions(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'See Affordable Alternatives',
              icon: Icons.savings_rounded,
              onPressed: () => context.push('/drugs/alternatives'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.medication_rounded, color: AppColors.primary, size: 40),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Augmentin 625mg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Text('Amoxicillin + Clavulanic Acid', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Average Price: ₦12,500', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('/facilities/pharmacy'),
            icon: const Icon(Icons.map_rounded, size: 18),
            label: const Text('Find Nearby'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded, size: 18),
            label: const Text('Share Info'),
          ),
        ),
      ],
    );
  }

  Widget _buildSideEffects(BuildContext context) {
    final effects = ['Nausea', 'Diarrhea', 'Skin Rash', 'Stomach Pain'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: effects.map((e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.divider)),
        child: Text(e, style: const TextStyle(fontSize: 12)),
      )).toList(),
    );
  }

  Widget _buildPrecautions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
              const SizedBox(width: 8),
              Text('Precautions', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Contraindicated in patients with a history of penicillin allergy. Use with caution in patients with hepatic impairment.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}
