import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'About PatientFlow'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAppLogo(context),
            const SizedBox(height: 32),
            const Text(
              'PatientFlow Healthcare',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Text(
              'Version 2.4.0 (Build 984)',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 32),
            const Text(
              'PatientFlow is a comprehensive digital health platform designed to bring premium medical services to your fingertips. Our mission is to democratize healthcare access through technology.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5, fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            _buildLegalMenu(context),
            const SizedBox(height: 60),
            const Text(
              '© 2026 PatientFlow Technologies Ltd.',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            const Text(
              'Made with ♥ for your wellness.',
              style: TextStyle(fontSize: 11, color: AppColors.primary),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20)],
      ),
      child: const Icon(Icons.waves_rounded, color: AppColors.background, size: 48),
    );
  }

  Widget _buildLegalMenu(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildLegalItem('Privacy Policy'),
          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColors.divider),
          _buildLegalItem('Terms of Service'),
          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColors.divider),
          _buildLegalItem('Cookie Policy'),
          const Divider(height: 1, indent: 20, endIndent: 20, color: AppColors.divider),
          _buildLegalItem('Open Source Licenses'),
        ],
      ),
    );
  }

  Widget _buildLegalItem(String title) {
    return ListTile(
      onTap: () {},
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.textMuted),
      dense: true,
    );
  }
}
