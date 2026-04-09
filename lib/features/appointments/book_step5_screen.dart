import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class BookStep5Screen extends StatelessWidget {
  const BookStep5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = mockDoctors[0]; // Dr. Ngozi Adeyemi

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Review Appointment'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Step 5 of 5',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Final Confirmation',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Please review your appointment details and add any notes for your doctor.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                   Row(
                    children: [
                      AvatarCircle(initials: doctor.avatar, size: 48),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctor.name, style: Theme.of(context).textTheme.titleMedium),
                            Text(doctor.specialty, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const TealDivider(),
                  const SizedBox(height: 20),
                  _buildSummaryRow(context, Icons.calendar_today_rounded, 'Date', 'Tuesday, July 15, 2026'),
                  const SizedBox(height: 16),
                  _buildSummaryRow(context, Icons.access_time_rounded, 'Time', '09:00 AM'),
                  const SizedBox(height: 16),
                  _buildSummaryRow(context, Icons.location_on_rounded, 'Facility', doctor.hospital),
                  const SizedBox(height: 16),
                  _buildSummaryRow(context, Icons.videocam_rounded, 'Type', 'In-Person Visit'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Notes for the Doctor (Optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add any specific symptoms, concerns, or context for this visit...',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You can reschedule or cancel this appointment up to 24 hours before the scheduled time.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Confirm Booking',
              onPressed: () => context.go('/appointments/confirmation'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          ],
        ),
      ],
    );
  }
}
