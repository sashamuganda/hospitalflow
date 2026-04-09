import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class TriageResultsScreen extends StatelessWidget {
  const TriageResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Triage Results'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildUrgencyIndicator(context),
            const SizedBox(height: 32),
            _buildActionSummary(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Potential Causes'),
            const SizedBox(height: 12),
            _buildCausesList(context),
            const SizedBox(height: 32),
            _buildDisclaimer(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Book Specialist Consultation',
              onPressed: () => context.push('/telemedicine/find-doctor'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Return Home'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildUrgencyIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 48),
          const SizedBox(height: 16),
          Text(
            'Urgent Consultation Recommended',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.warning),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Your symptoms suggest you should seek medical attention within the next 24 hours.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSummary(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildActionRow(context, Icons.medical_services_outlined, 'Next Steps', 'Consult a Cardiologist for a physical exam and ECG.'),
          const SizedBox(height: 12),
          const TealDivider(),
          const SizedBox(height: 12),
          _buildActionRow(context, Icons.info_outline_rounded, 'Self-Care', 'Rest and avoid strenuous activity until seen by a professional.'),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCausesList(BuildContext context) {
    final causes = [
      {'title': 'Costochondritis', 'desc': 'Inflammation of the cartilage that connects a rib to the breastbone.', 'conf': 'High'},
      {'title': 'Angina', 'desc': 'Chest pain caused by reduced blood flow to the heart muscles.', 'conf': 'Moderate'},
      {'title': 'Acid Reflux', 'desc': 'Heartburn or GERD can often mimic cardiac chest pain.', 'conf': 'Possible'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: causes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cause = causes[index];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cause['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  StatusBadge(
                    label: cause['conf']!.toUpperCase(),
                    color: cause['conf'] == 'High' ? AppColors.success : (cause['conf'] == 'Moderate' ? AppColors.warning : AppColors.info),
                    fontSize: 10,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(cause['desc']!, style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.3)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDisclaimer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'DISCLAIMER: This is an AI-generated triage and does not constitute a formal diagnosis. If you are experiencing a life-threatening emergency, call emergency services immediately.',
              style: TextStyle(fontSize: 10, color: AppColors.error.withOpacity(0.8), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
