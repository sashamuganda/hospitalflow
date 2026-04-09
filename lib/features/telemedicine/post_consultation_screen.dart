import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PostConsultationScreen extends StatelessWidget {
  const PostConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Consultation Summary'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSuccessHero(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Medical Advice'),
            const SizedBox(height: 12),
            _buildAdviceCard(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Prescribed Medications'),
            const SizedBox(height: 12),
            _buildMedicationShortcuts(context),
            const SizedBox(height: 32),
            _buildFollowUp(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Download PDF Report',
              icon: Icons.picture_as_pdf_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Back to Home'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHero(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 64),
        ),
        const SizedBox(height: 24),
        const Text('Consultation Completed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        const Text('Finalized by Dr. Ngozi Adeyemi', style: TextStyle(color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildAdviceCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Primary Diagnosis', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const Text('Stable Angina (Likely)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
          const SizedBox(height: 16),
          const TealDivider(),
          const SizedBox(height: 16),
          _buildAdviceRow('1', 'Begin low-dose Aspirin daily.'),
          _buildAdviceRow('2', 'Schedule a physical ECG within 48 hours.'),
          _buildAdviceRow('3', 'Monitor heart rate daily through the Health app.'),
        ],
      ),
    );
  }

  Widget _buildAdviceRow(String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$num.', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4))),
        ],
      ),
    );
  }

  Widget _buildMedicationShortcuts(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            onTap: () => context.push('/medications'),
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                 Icon(Icons.medication_rounded, color: AppColors.primary),
                 SizedBox(height: 8),
                 Text('View Rx', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassCard(
            onTap: () => context.push('/medications/refill'),
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                 Icon(Icons.shopping_cart_rounded, color: AppColors.secondary),
                 SizedBox(height: 8),
                 Text('Order Meds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUp(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_rounded, color: AppColors.warning, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Follow-up Session', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Recommended in 2 weeks', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Schedule')),
        ],
      ),
    );
  }
}
