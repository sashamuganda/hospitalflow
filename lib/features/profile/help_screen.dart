import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Help & Support'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSupportHero(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Popular FAQs'),
            const SizedBox(height: 12),
            _buildFaqItem('How do I book a consultation?', 'Go to the Telemedicine tab and select "Find a Doctor" to browse available specialists.'),
            _buildFaqItem('When will my lab results arrive?', 'Most results are available within 24-48 hours and will trigger a notification.'),
            _buildFaqItem('How do I sync my Apple Watch?', 'Go to Profile > Linked Devices and toggle the Apple Health switch.'),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Still need help?'),
            const SizedBox(height: 12),
            _buildContactCard(Icons.chat_bubble_outline_rounded, 'Live Chat', 'Average response: 2 mins', AppColors.primary),
            const SizedBox(height: 12),
            _buildContactCard(Icons.mail_outline_rounded, 'Email Support', 'support@patientflow.com', AppColors.secondary),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportHero(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.support_agent_rounded, size: 64, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('How can we help you today?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for articles or help...',
              prefixIcon: const Icon(Icons.search_rounded),
              fillColor: AppColors.background.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.textSecondary)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: AppColors.divider)),
        backgroundColor: AppColors.surface,
        collapsedBackgroundColor: AppColors.surface,
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
