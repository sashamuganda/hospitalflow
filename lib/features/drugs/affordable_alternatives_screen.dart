import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class AffordableAlternativesScreen extends StatelessWidget {
  const AffordableAlternativesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alternatives = [
      {'name': 'Amoksiklav 625mg', 'generic': 'Amoxicillin + Clavulanic Acid', 'price': '₦7,800', 'savings': '37%', 'stock': 'In Stock'},
      {'name': 'Fleming 625mg', 'generic': 'Amoxicillin + Clavulanic Acid', 'price': '₦6,200', 'savings': '50%', 'stock': 'In Stock'},
      {'name': 'Amoxicillin Generic', 'generic': 'Amoxicillin', 'price': '₦2,400', 'savings': '81%', 'stock': 'Limited'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Affordable Alternatives'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComparisonHeader(context),
            const SizedBox(height: 32),
            Text('Lower Cost Options', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...alternatives.map((alt) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildAlternativeCard(context, alt),
            )),
            const SizedBox(height: 40),
            _buildSavingsInsight(context),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonHeader(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: AppColors.secondary.withOpacity(0.3),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.secondary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Comparing for:', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                const Text('Augmentin 625mg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Original Price: ₦12,500', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeCard(BuildContext context, Map<String, String> alt) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alt['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(alt['generic']!, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('SAVE ${alt['savings']}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const TealDivider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  Text(alt['price']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Stock Status', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  Text(alt['stock']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsInsight(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      gradient: AppColors.tealGradient.withOpacity(0.1) as Gradient?,
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: Colors.amber, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Switching to a generic alternative with the same active ingredients can save you over ₦5,000 on this prescription.',
              style: TextStyle(height: 1.4, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
