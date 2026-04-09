import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    // In a real app, we'd fetch the appointment by ID.
    final appt = mockAppointments[0];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Appointment Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildDoctorHero(context, appt),
            const SizedBox(height: 32),
            _buildDetailSection(context, appt),
            const SizedBox(height: 32),
            if (appt.notes != null) ...[
              const SectionHeader(title: 'Pre-visit Notes'),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Text(
                  appt.notes!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 32),
            ],
            const SectionHeader(title: 'Facility Location'),
            const SizedBox(height: 12),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: AppColors.primary),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Lagos State University Teaching Hospital, Ikeja',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    label: 'Get Directions',
                    icon: Icons.map_rounded,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reschedule'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                    child: const Text('Cancel Visit'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHero(BuildContext context, MockAppointment appt) {
    return Column(
      children: [
        const AvatarCircle(initials: 'NA', size: 80),
        const SizedBox(height: 16),
        Text(appt.doctorName, style: Theme.of(context).textTheme.headlineSmall),
        Text(appt.doctorSpecialty, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        StatusBadge(label: appt.status.toUpperCase(), color: AppColors.primary),
      ],
    );
  }

  Widget _buildDetailSection(BuildContext context, MockAppointment appt) {
    return Column(
      children: [
        _buildDetailRow(context, Icons.calendar_month_rounded, 'Date', 'Wednesday, July 15, 2026'),
        const SizedBox(height: 20),
        _buildDetailRow(context, Icons.access_time_rounded, 'Time', '09:00 AM (45 mins)'),
        const SizedBox(height: 20),
        _buildDetailRow(
          context,
          Icons.payment_rounded,
          'Payment Status',
          'Confirmed via Insurance',
          subtitle: 'Policy: #PF-99283-X',
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value, {String? subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
