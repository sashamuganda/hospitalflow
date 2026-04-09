import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class DrugSearchResultsScreen extends StatefulWidget {
  const DrugSearchResultsScreen({super.key});

  @override
  State<DrugSearchResultsScreen> createState() => _DrugSearchResultsScreenState();
}

class _DrugSearchResultsScreenState extends State<DrugSearchResultsScreen> {
  final List<Map<String, dynamic>> _drugs = [
    {'name': 'Augmentin 625mg', 'generic': 'Amoxicillin + Clavulanic Acid', 'price': '₦12,500', 'brand': true, 'stock': true},
    {'name': 'Amoksiklav 625mg', 'generic': 'Amoxicillin + Clavulanic Acid', 'price': '₦7,800', 'brand': false, 'stock': true},
    {'name': 'Fleming 625mg', 'generic': 'Amoxicillin + Clavulanic Acid', 'price': '₦6,200', 'brand': false, 'stock': true},
    {'name': 'Amoxicillin Generic', 'generic': 'Amoxicillin', 'price': '₦2,400', 'brand': false, 'stock': true},
    {'name': 'Zinnat 500mg', 'generic': 'Cefuroxime', 'price': '₦14,200', 'brand': true, 'stock': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Medication Search'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search again...',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _buildFilterIcon(),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _drugs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final drug = _drugs[index];
                return _DrugResultCard(drug: drug);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
    );
  }
}

class _DrugResultCard extends StatelessWidget {
  final Map<String, dynamic> drug;

  const _DrugResultCard({required this.drug});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () => context.push('/drugs/detail/1'),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.medication_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(drug['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (drug['brand']!)
                      StatusBadge(label: 'BRAND', color: AppColors.secondary, fontSize: 8),
                  ],
                ),
                Text(drug['generic']!, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      drug['price']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                    ),
                    if (drug['stock']!)
                      const Text('In Stock', style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold))
                    else
                      const Text('Out of Stock', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
