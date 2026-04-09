import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Immunizations'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVaccinePassport(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Completed Vaccinations'),
            const SizedBox(height: 12),
            _buildVaccineList(context, completed: true),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Recommended / Due'),
            const SizedBox(height: 12),
            _buildVaccineList(context, completed: false),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccinePassport(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.primaryGradient.withOpacity(0.1) as Gradient?,
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_rounded, color: AppColors.success, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Digital Vaccine Record', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Verified • 12 Records found', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.qr_code_2_rounded, size: 40, color: AppColors.textPrimary),
            ],
          ),
          const SizedBox(height: 20),
          const TealDivider(),
          const SizedBox(height: 20),
          const Text(
            'This record is integrated with the National Immunization Registry.',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccineList(BuildContext context, {required bool completed}) {
    final vaccines = completed 
      ? [
          {'name': 'COVID-19 (Pfizer)', 'date': 'July 2024', 'dose': 'Dose 3', 'status': 'Final'},
          {'name': 'Hepatitis B', 'date': 'Jan 2024', 'dose': 'Dose 1/3', 'status': 'Partial'},
          {'name': 'Yellow Fever', 'date': 'March 2022', 'dose': 'Lifetime', 'status': 'Valid'},
        ]
      : [
          {'name': 'Tetanus (Tdap)', 'date': 'Due Dec 2026', 'dose': 'Booster', 'status': 'Upcoming'},
          {'name': 'Hepatitis B', 'date': 'Due Oct 2026', 'dose': 'Dose 2/3', 'status': 'Due'},
        ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vaccines.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final v = vaccines[index];
        final isDue = v['status'] == 'Due';
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (completed ? AppColors.success : (isDue ? AppColors.error : AppColors.primary)).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed ? Icons.check_rounded : Icons.pending_actions_rounded,
                  color: completed ? AppColors.success : (isDue ? AppColors.error : AppColors.primary),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(v['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${v['dose']} • ${v['date']}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        );
      },
    );
  }
}
