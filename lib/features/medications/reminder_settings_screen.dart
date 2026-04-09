import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ReminderSettingsScreen extends StatefulWidget {
  const ReminderSettingsScreen({super.key});

  @override
  State<ReminderSettingsScreen> createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  bool _allReminders = true;
  bool _pushNotifications = true;
  bool _smsAlerts = false;

  final List<Map<String, dynamic>> _reminders = [
    {'time': '09:00 AM', 'enabled': true, 'label': 'Morning Dose'},
    {'time': '02:00 PM', 'enabled': false, 'label': 'Afternoon Dose'},
    {'time': '09:00 PM', 'enabled': true, 'label': 'Evening Dose'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Reminder Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active_rounded, color: AppColors.primary),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Master Reminders Toggle',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Switch(
                    value: _allReminders,
                    onChanged: (val) => setState(() => _allReminders = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Scheduled Reminders', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ..._reminders.map((reminder) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          reminder['time'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            reminder['label'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Switch(
                          value: reminder['enabled'] && _allReminders,
                          onChanged: _allReminders
                              ? (val) => setState(() => reminder['enabled'] = val)
                              : null,
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Reminder Time'),
            ),
            const SizedBox(height: 32),
            Text('Notification Channels', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildToggleRow('Push Notifications', _pushNotifications, (v) => setState(() => _pushNotifications = v)),
                  const TealDivider(),
                  _buildToggleRow('SMS Alerts', _smsAlerts, (v) => setState(() => _smsAlerts = v)),
                ],
              ),
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Save Preferences',
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
