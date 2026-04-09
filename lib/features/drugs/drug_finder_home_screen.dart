import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class DrugFinderHomeScreen extends StatelessWidget {
  const DrugFinderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Drug Finder'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchHero(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Categories'),
            const SizedBox(height: 12),
            _buildCategoriesGrid(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Recent Searches'),
            const SizedBox(height: 12),
            _buildRecentSearches(context),
            const SizedBox(height: 32),
            _buildSafetyInsight(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHero(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.primaryGradient.withOpacity(0.1) as Gradient?,
      child: Column(
        children: [
          const Text(
             'Save on your medications.',
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          const Text(
             'Find affordable alternatives and check availability nearby.',
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          TextField(
            onSubmitted: (_) => context.push('/drugs/results'),
            decoration: const InputDecoration(
              hintText: 'Search medication brand or generic...',
              prefixIcon: Icon(Icons.search_rounded),
              suffixIcon: Icon(Icons.qr_code_scanner_rounded, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      {'name': 'Pain Relief', 'icon': Icons.healing_rounded},
      {'name': 'Antibiotics', 'icon': Icons.biotech_rounded},
      {'name': 'Cardiac', 'icon': Icons.favorite_rounded},
      {'name': 'Diabetes', 'icon': Icons.opacity_rounded},
      {'name': 'Vitamins', 'icon': Icons.eco_rounded},
      {'name': 'First Aid', 'icon': Icons.medical_services_rounded},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        return GlassCard(
          onTap: () => context.push('/drugs/results'),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cat['icon'] as IconData, color: AppColors.primary, size: 28),
              const SizedBox(height: 8),
              Text(
                cat['name'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentSearches(BuildContext context) {
    final recent = ['Augmentin 625mg', 'Paracetamol 500mg', 'Lipitor 20mg'];
    return Column(
      children: recent.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          onTap: () => context.push('/drugs/results'),
          leading: const Icon(Icons.history_rounded, size: 18, color: AppColors.textMuted),
          title: Text(item, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.north_west_rounded, size: 14, color: AppColors.textMuted),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
      )).toList(),
    );
  }

  Widget _buildSafetyInsight(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.warning, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Always consult your pharmacist or doctor before switching to an alternative medication.',
              style: TextStyle(fontSize: 12, color: AppColors.warning, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
