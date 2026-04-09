import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PharmacyLocatorScreen extends StatelessWidget {
  const PharmacyLocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = [
      {'name': 'HealthPlus', 'addr': 'Awolowo Way, Ikoyi', 'dist': '0.5 km', 'stock': 'In Stock', 'stockColor': AppColors.success},
      {'name': 'Medplus Pharmacy', 'addr': 'Adetokunbo Ademola, VI', 'dist': '1.1 km', 'stock': 'Limited Stock', 'stockColor': AppColors.warning},
      {'name': 'Nett Pharmacy', 'addr': 'Bourdillon Rd, Ikoyi', 'dist': '2.2 km', 'stock': 'Out of Stock', 'stockColor': AppColors.error},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Pharmacy Locator'),
      body: Column(
        children: [
          _buildDrugStockCheck(context),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: pharmacies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final pharm = pharmacies[index];
                return GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.local_pharmacy_rounded, color: AppColors.secondary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pharm['name']! as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(pharm['addr']! as String, style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 8),
                            Text(
                              pharm['stock']! as String,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: pharm['stockColor']! as Color),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(pharm['dist']! as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          const SizedBox(height: 8),
                          const Icon(Icons.directions_rounded, color: AppColors.primary, size: 20),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrugStockCheck(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Check Availability for:', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.medication_rounded, color: AppColors.primary),
              const SizedBox(width: 12),
              const Text('Amoxicillin 500mg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              TextButton(onPressed: () => context.pop(), child: const Text('Change')),
            ],
          ),
        ],
      ),
    );
  }
}
