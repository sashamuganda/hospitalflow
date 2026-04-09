import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class DischargeSummariesScreen extends StatelessWidget {
  const DischargeSummariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final summaries = [
      {
        'title': 'Hospital Admission Summary',
        'date': 'Oct 12, 2024',
        'facility': 'Lagos University Teaching Hospital',
        'reason': 'Acute Asthma Exacerbation'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Discharge Summaries'),
      body: summaries.isEmpty
          ? const EmptyState(
              icon: Icons.description_rounded,
              title: 'No Discharge Summaries',
              message: 'Full reports from your hospital stays will appear here.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: summaries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final summary = summaries[index];
                return GlassCard(
                  onTap: () {},
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.assignment_return_rounded, color: AppColors.error, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(summary['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(summary['facility']!, style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const TealDivider(),
                      const SizedBox(height: 16),
                      Text('Reason for Admission', style: Theme.of(context).textTheme.labelSmall),
                      Text(summary['reason']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discharge Date: ${summary['date']}', style: Theme.of(context).textTheme.bodySmall),
                          const Text('View PDF', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
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
