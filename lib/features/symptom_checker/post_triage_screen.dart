import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PostTriageScreen extends StatelessWidget {
  const PostTriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Triage Summary'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.description_rounded, color: AppColors.primary, size: 48),
            ),
            const SizedBox(height: 32),
            Text(
              'Report Saved!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'Your triage report has been saved to your medical records. You can share this with your doctor during your consultation.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 48),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildOption(context, Icons.share_rounded, 'Share Report', 'Send as PDF to your provider'),
                  const TealDivider(),
                  _buildOption(context, Icons.calendar_today_rounded, 'Book Follow-up', 'Schedule with a specialist'),
                  const TealDivider(),
                  _buildOption(context, Icons.history_rounded, 'Related Records', 'View your cardiology history'),
                ],
              ),
            ),
            const Spacer(),
            GradientButton(
              label: 'Return Home',
              onPressed: () => context.go('/home'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
