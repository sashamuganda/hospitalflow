import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class NotificationPrefsScreen extends StatefulWidget {
  const NotificationPrefsScreen({super.key});

  @override
  State<NotificationPrefsScreen> createState() => _NotificationPrefsScreenState();
}

class _NotificationPrefsScreenState extends State<NotificationPrefsScreen> {
  bool _appointments = true;
  bool _medications = true;
  bool _results = true;
  bool _promotions = false;
  bool _wellness = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Notifications'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Medical Alerts'),
            const SizedBox(height: 12),
            _buildPrefTile('Appointments', 'Reminders for upcoming visits and check-ins.', _appointments, (v) => setState(() => _appointments = v)),
            const SizedBox(height: 12),
            _buildPrefTile('Medications', 'Alerts for scheduled doses and refills.', _medications, (v) => setState(() => _medications = v)),
            const SizedBox(height: 12),
            _buildPrefTile('Lab Results', 'Notifications when new results are available.', _results, (v) => setState(() => _results = v)),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Activity & Wellness'),
            const SizedBox(height: 12),
            _buildPrefTile('Wellness Tips', 'Daily insights and hydration reminders.', _wellness, (v) => setState(() => _wellness = v)),
            const SizedBox(height: 12),
            _buildPrefTile('Newsletter & Updates', 'Latest health news and app improvements.', _promotions, (v) => setState(() => _promotions = v)),
            const SizedBox(height: 48),
            const Text(
               'Emergency alerts will always be sent via SMS and Push even if other notifications are disabled.',
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPrefTile(String title, String subtitle, bool state, Function(bool) onChanged) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SwitchListTile(
        value: state,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
