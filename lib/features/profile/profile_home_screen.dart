import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'My Profile', showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildProfileHero(context),
            const SizedBox(height: 32),
            _buildSettingsGroup(context, 'Health Profile', [
              _buildSettingsTile(context, Icons.person_outline_rounded, 'Personal Information', 'Edit your basic details', '/profile/edit'),
              _buildSettingsTile(context, Icons.monitor_heart_rounded, 'Health Dashboard', 'Vitals, conditions and records', '/profile/health'),
              _buildSettingsTile(context, Icons.sos_rounded, 'Emergency Contacts', 'Manage your SOS alerts', '/profile/emergency-contacts'),
            ]),
            const SizedBox(height: 24),
            _buildSettingsGroup(context, 'Account & Privacy', [
              _buildSettingsTile(context, Icons.devices_rounded, 'Linked Devices', 'Apple Health, Wearables', '/profile/linked-devices'),
              _buildSettingsTile(context, Icons.lock_outline_rounded, 'Privacy & Data', 'Manage sharing and exports', '/profile/privacy'),
              _buildSettingsTile(context, Icons.notifications_none_rounded, 'Notifications', 'Alert preferences', '/profile/notifications'),
            ]),
            const SizedBox(height: 24),
            _buildSettingsGroup(context, 'App Settings', [
              _buildSettingsTile(context, Icons.language_rounded, 'Language', 'English (UK)', '/profile/language'),
              _buildSettingsTile(context, Icons.security_rounded, 'Security', 'FaceID, Passcode', '/profile/security'),
              _buildSettingsTile(context, Icons.help_outline_rounded, 'Help & Support', 'FAQs, Contact us', '/profile/help'),
              _buildSettingsTile(context, Icons.info_outline_rounded, 'About PatientFlow', 'v2.4.0', '/profile/about'),
            ]),
            const SizedBox(height: 40),
            _buildLogoutButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHero(BuildContext context) {
    return Column(
      children: [
        const AvatarCircle(initials: 'AO', size: 90),
        const SizedBox(height: 16),
        const Text('Amara Okonkwo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const Text('patient_001 • O+', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 14),
              SizedBox(width: 6),
              Text('Identity Verified', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted, letterSpacing: 1.2)),
        ),
        GlassCard(
          padding: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, String subtitle, String route) {
    return ListTile(
      onTap: () => context.push(route),
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () {},
      child: const Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
    );
  }
}
