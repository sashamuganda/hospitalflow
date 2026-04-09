import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ConsultationHistoryScreen extends StatelessWidget {
  const ConsultationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'doc': 'Dr. Ngozi Adeyemi', 'specialty': 'Cardiology', 'date': 'Today', 'status': 'Completed', 'avatar': 'NA'},
      {'doc': 'Dr. Sarah Chen', 'specialty': 'Pediatrics', 'date': '12 Mar 2025', 'status': 'Completed', 'avatar': 'SC'},
      {'doc': 'Dr. Malik Abiola', 'specialty': 'Mental Health', 'date': '01 Feb 2025', 'status': 'Cancelled', 'avatar': 'MA'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Consultation History'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final h = history[index];
          final isCancelled = h['status'] == 'Cancelled';
          return GlassCard(
            onTap: isCancelled ? null : () => context.push('/telemedicine/summary'),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AvatarCircle(initials: h['avatar']!, size: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(h['doc']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${h['specialty']} • ${h['date']}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                StatusBadge(
                  label: h['status']!.toUpperCase(),
                  color: isCancelled ? AppColors.error : AppColors.success,
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
