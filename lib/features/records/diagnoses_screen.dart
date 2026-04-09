import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class DiagnosesScreen extends StatelessWidget {
  const DiagnosesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Diagnoses'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: mockDiagnoses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final diag = mockDiagnoses[index];
          return GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        diag.condition,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    if (diag.isChronic)
                      const StatusBadge(label: 'CHRONIC', color: AppColors.error, fontSize: 10),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'ICD Code: ${diag.icdCode}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                const TealDivider(),
                const SizedBox(height: 12),
                Text(
                  diag.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      'Diagnosed by ${diag.diagnosedBy}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      'Jan 2025', // Simplified date
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
