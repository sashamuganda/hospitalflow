import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Prescriptions'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: mockMedications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final med = mockMedications[index];
          return GlassCard(
            onTap: () {},
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.medication_rounded, color: AppColors.secondary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(med.genericName, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        'Prescribed by ${med.prescribingDoctor}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: med.isActive ? 'ACTIVE' : 'COMPLETED',
                  color: med.isActive ? AppColors.success : AppColors.textMuted,
                  fontSize: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
