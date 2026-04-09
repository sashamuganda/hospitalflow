import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class VisitHistoryScreen extends StatelessWidget {
  const VisitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visits = mockAppointments.where((a) => a.status == 'past').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Visit History'),
      body: visits.isEmpty
          ? const EmptyState(
              icon: Icons.history_rounded,
              title: 'No Visit History',
              message: 'Your past hospital visits and consultations will appear here.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: visits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final visit = visits[index];
                return GlassCard(
                  onTap: () => context.push('/records/visit/${visit.id}'),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.description_outlined, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(visit.doctorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(visit.facility, style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              'July 14, 2026 • Wellness Check', // Simplified date
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
