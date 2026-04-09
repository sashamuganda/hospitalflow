import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometrics = true;
  bool _twoFactor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Security Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Access Control'),
            const SizedBox(height: 12),
            _buildSecurityTile(
              'Biometric Login',
              'Use FaceID or Fingerprint to unlock the app.',
              Icons.fingerprint_rounded,
              _biometrics,
              (v) => setState(() => _biometrics = v),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              'Two-Factor Auth',
              'Verify logins via SMS or Email code.',
              Icons.vibration_rounded,
              _twoFactor,
              (v) => setState(() => _twoFactor = v),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Password Management'),
            const SizedBox(height: 12),
            _buildActionTile(Icons.lock_reset_rounded, 'Change Password', 'Last changed 3 months ago'),
            const SizedBox(height: 12),
            _buildActionTile(Icons.devices_other_rounded, 'Active Sessions', 'Manage devices where you are logged in'),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                'Encryption: AES-256 Bit verified.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTile(String title, String subtitle, IconData icon, bool state, Function(bool) onChanged) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SwitchListTile(
        value: state,
        onChanged: onChanged,
        secondary: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle) {
    return GlassCard(
      onTap: () {},
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
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
