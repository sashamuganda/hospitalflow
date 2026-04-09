import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _shareInsurance = true;
  bool _shareDoctors = true;
  bool _shareResearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Privacy & Data'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataExportCard(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Data Sharing Permissions'),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'Insurance Provider',
              'Allow AXA Mansard to view clinical summaries for claim processing.',
              _shareInsurance,
              (v) => setState(() => _shareInsurance = v),
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'All Treatment Doctors',
              'Allow any doctor assigned to you to view your full history.',
              _shareDoctors,
              (v) => setState(() => _shareDoctors = v),
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              context,
              'Anonymized Research',
              'Contribute your anonymized health patterns to help clinical studies.',
              _shareResearch,
              (v) => setState(() => _shareResearch = v),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Account Settings'),
            const SizedBox(height: 12),
            _buildActionCard(context, Icons.delete_forever_rounded, 'Delete Account', 'Permanently remove all your health records.', AppColors.error),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildDataExportCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cloud_download_rounded, color: AppColors.primary, size: 32),
          const SizedBox(height: 16),
          const Text('Download Your Health Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          const Text(
            'Get a full export of your medical records, including lab results and visits, in PDF or CSV format.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          GradientButton(
            label: 'Export My Health Data',
            icon: Icons.download_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile(BuildContext context, String title, String subtitle, bool state, Function(bool) onChanged) {
    return GlassCard(
      child: SwitchListTile(
        value: state,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    return GlassCard(
      onTap: () {},
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
