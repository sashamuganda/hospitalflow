import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../core/app_state.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚡ PERFORMANCE: Use context.select to only rebuild when currentUser changes
    final user = context.select<AppState, StaffMember?>((s) => s.currentUser);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              Text('Settings',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              // Profile Card
              if (user != null)
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      AvatarCircle(initials: user.avatarInitials, size: 64),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.displayName,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(user.email,
                                style: const TextStyle(
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              const Text('Preferences',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const _SettingsTile(
                        icon: Icons.notifications_rounded,
                        title: 'Notifications',
                        isSwitch: true,
                        switchValue: true),
                    const Divider(color: AppColors.divider, height: 1),
                    const _SettingsTile(
                        icon: Icons.dark_mode_rounded,
                        title: 'Dark Mode',
                        isSwitch: true,
                        switchValue: true),
                    const Divider(color: AppColors.divider, height: 1),
                    const _SettingsTile(
                        icon: Icons.language_rounded,
                        title: 'Language',
                        subtitle: 'English'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text('Account',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const _SettingsTile(
                        icon: Icons.lock_rounded, title: 'Change Password'),
                    const Divider(color: AppColors.divider, height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout_rounded,
                          color: AppColors.error),
                      title: const Text('Log Out',
                          style: TextStyle(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        context.read<AppState>().logout();
                        context.go('/role-select');
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isSwitch;
  final bool switchValue;

  const _SettingsTile(
      {required this.icon,
      required this.title,
      this.subtitle,
      this.isSwitch = false,
      this.switchValue = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(color: AppColors.textMuted))
          : null,
      trailing: isSwitch
          ? Switch(
              value: switchValue,
              onChanged: (v) {},
              activeColor: AppColors.primary,
            )
          : const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
      onTap: isSwitch ? null : () {},
    );
  }
}
