import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class MedicationsHomeScreen extends StatelessWidget {
  const MedicationsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeMeds = mockMedications.where((m) => m.isActive).toList();
    final pastMeds = mockMedications.where((m) => !m.isActive).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Medications',
        showBack: false,
        actions: [
          IconButton(
            onPressed: () => context.push('/medications/reminders'),
            icon: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Active Cycles'),
            const SizedBox(height: 12),
            ...activeMeds.map((med) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MedicationCard(medication: med),
                )),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'History',
              actionLabel: 'Filter',
              onAction: () {},
            ),
            const SizedBox(height: 12),
            ...pastMeds.map((med) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _MedicationHistoryTile(medication: med),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/drugs'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.search_rounded, color: AppColors.background),
        label: const Text('Find Drugs', style: TextStyle(color: AppColors.background, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final MockMedication medication;

  const _MedicationCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    final bool nearingEnd = medication.daysRemaining <= 5;
    final color = nearingEnd ? AppColors.warning : AppColors.secondary;

    return GlassCard(
      onTap: () => context.push('/medications/detail/${medication.id}'),
      padding: const EdgeInsets.all(20),
      borderColor: color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.medication_rounded, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medication.name, style: Theme.of(context).textTheme.titleLarge),
                    Text(medication.genericName, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              if (nearingEnd)
                const StatusBadge(label: 'REFILL SOON', color: AppColors.warning, fontSize: 10),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfo(context, 'Dosage', medication.dosage),
              _buildInfo(context, 'Frequency', medication.frequency),
              _buildInfo(context, 'Remaining', '${medication.daysRemaining} Days',
                  color: nearingEnd ? AppColors.warning : AppColors.primary),
            ],
          ),
          if (nearingEnd) ...[
            const SizedBox(height: 20),
            GradientButton(
              label: 'Find Refill Nearby',
              gradient: AppColors.violetGradient,
              onPressed: () => context.push('/medications/refill'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _MedicationHistoryTile extends StatelessWidget {
  final MockMedication medication;

  const _MedicationHistoryTile({required this.medication});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, color: AppColors.textMuted, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medication.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('Completed on Jan 12, 2025', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
