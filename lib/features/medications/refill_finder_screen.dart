import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class RefillFinderScreen extends StatelessWidget {
  const RefillFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Focused on Symbicort refill which was nearing end in mock data
    final med = mockMedications.firstWhere((m) => m.name == 'Symbicort');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Refill & Finder'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSupplyStatusCard(context, med),
            const SizedBox(height: 32),
            Text('Affordable Alternatives', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildGenericRecommendation(context),
            const SizedBox(height: 32),
            Text('Nearby Pharmacies', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildPharmacyList(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'See All Pharmacies on Map',
              icon: Icons.map_rounded,
              onPressed: () => context.push('/facilities'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplyStatusCard(BuildContext context, MockMedication med) {
    return GlassCard(
      borderColor: AppColors.warning.withOpacity(0.3),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_cart_checkout_rounded, color: AppColors.warning),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(med.name, style: Theme.of(context).textTheme.titleLarge),
                    const Text('Low Supply Alert', style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('Remaining', '${med.daysRemaining} Days'),
              _buildStat('Quantity', 'Approx. 5 doses'),
              _buildStat('Last Refill', 'Dec 2024'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildGenericRecommendation(BuildContext context) {
    return GlassCard(
      gradient: AppColors.tealGradient.withOpacity(0.1) as Gradient?,
      borderColor: AppColors.primary.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.savings_outlined, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Switch to Generic & Save',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Budesonide/Formoterol (Generic) is available at a ~40% lower price than Symbicort brand. Same efficacy, lower cost.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.push('/drugs/alternatives'),
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: const Text('Compare Prices'),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyList(BuildContext context) {
    final pharmacies = mockFacilities.where((f) => f.type == 'pharmacy').toList();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pharmacies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final phar = pharmacies[index];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(phar.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${phar.distance} • ${phar.address}', style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('IN STOCK', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 10)),
                  Text(phar.hours.split(' – ')[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
