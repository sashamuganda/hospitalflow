import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Lab Results'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: mockLabResults.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final result = mockLabResults[index];
          return GlassCard(
            onTap: () => context.push('/records/lab/${result.id}'),
            padding: const EdgeInsets.all(16),
            borderColor: _getStatusColor(result.status).withOpacity(0.3),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getStatusColor(result.status).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.analytics_outlined, color: _getStatusColor(result.status)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.testName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Ordered by ${result.requestingDoctor}', style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        'Received: Jan 15, 2026', // Simplified date
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: result.status.toUpperCase(),
                  color: _getStatusColor(result.status),
                  fontSize: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'normal': return AppColors.success;
      case 'borderline': return AppColors.warning;
      case 'critical': return AppColors.error;
      default: return AppColors.textMuted;
    }
  }
}
