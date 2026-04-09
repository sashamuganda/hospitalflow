import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class LinkedDevicesScreen extends StatefulWidget {
  const LinkedDevicesScreen({super.key});

  @override
  State<LinkedDevicesScreen> createState() => _LinkedDevicesScreenState();
}

class _LinkedDevicesScreenState extends State<LinkedDevicesScreen> {
  bool _appleHealth = true;
  bool _googleFit = false;
  bool _strava = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Linked Devices'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sync your health data automatically from your favorite devices and platforms.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Health Platforms'),
            const SizedBox(height: 12),
            _buildDeviceTile(
              context,
              'Apple Health',
              'Steps, Sleep, Vitals',
              Icons.apple_rounded,
              _appleHealth,
              (v) => setState(() => _appleHealth = v),
            ),
            const SizedBox(height: 12),
            _buildDeviceTile(
              context,
              'Google Fit',
              'Activity, Heart Rate',
              Icons.fitbit_rounded,
              _googleFit,
              (v) => setState(() => _googleFit = v),
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Third-party Apps'),
            const SizedBox(height: 12),
            _buildDeviceTile(
              context,
              'Strava',
              'Runs, Cycles, Workouts',
              Icons.directions_run_rounded,
              _strava,
              (v) => setState(() => _strava = v),
              color: Colors.orange,
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Wearables'),
            const SizedBox(height: 12),
            _buildEmptyWearable(context),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                'Data is encrypted and synced once every hour.',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTile(BuildContext context, String title, String subtitle, IconData icon, bool state, Function(bool) onChanged, {Color? color}) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderColor: state ? AppColors.primary : AppColors.divider,
      child: SwitchListTile(
        value: state,
        onChanged: onChanged,
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: (color ?? AppColors.primary).withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color ?? AppColors.primary, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildEmptyWearable(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.watch_off_rounded, size: 48, color: AppColors.textMuted),
          const SizedBox(height: 16),
          const Text('No Wearables Detected', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Connect your Oura, Whoop, or Fitbit directly via our partner integration.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          OutlinedButton(onPressed: () {}, child: const Text('Search Devices')),
        ],
      ),
    );
  }
}
