import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ImagingScreen extends StatelessWidget {
  const ImagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'type': 'Chest X-Ray', 'date': 'July 14, 2026', 'doctor': 'Dr. Emeka Eze', 'facility': 'Lagos University Teaching Hospital'},
      {'type': 'Pelvic Ultrasound', 'date': 'Jan 15, 2025', 'doctor': 'Dr. Fatima Al-Hassan', 'facility': 'Reddington Hospital'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Imaging & Reports'),
      body: reports.isEmpty
          ? const EmptyState(
              icon: Icons.visibility_rounded,
              title: 'No Imaging Reports',
              message: 'Your X-rays, Ultrasounds, and MRI reports will appear here.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final report = reports[index];
                return GlassCard(
                  onTap: () {},
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.image_search_rounded, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(report['type']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(report['facility']!, style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              '${report['date']} • ${report['doctor']}',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.file_download_outlined, color: AppColors.textMuted),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
