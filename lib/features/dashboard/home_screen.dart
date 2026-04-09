import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildQuickActions(context),
                  const SizedBox(height: 32),
                  _buildUpcomingAppointment(context),
                  const SizedBox(height: 24),
                  _buildHealthSnapshot(context),
                  const SizedBox(height: 24),
                  _buildActiveMedications(context),
                  const SizedBox(height: 24),
                  _buildHealthTipBanner(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning, ${MockUser.firstName}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'You have an appointment tomorrow',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => context.push('/notifications'),
          icon: Badge(
            label: const Text('2'),
            child: const Icon(Icons.notifications_outlined, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.calendar_month_rounded, 'label': 'Book Visit', 'route': '/appointments/book/step1'},
      {'icon': Icons.medical_services_rounded, 'label': 'Symptom AI', 'route': '/symptom-checker'},
      {'icon': Icons.video_call_rounded, 'label': 'Talk to Doc', 'route': '/telemedicine'},
      {'icon': Icons.location_on_rounded, 'label': 'Find Clinic', 'route': '/facilities'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return GestureDetector(
          onTap: () => context.push(action['route'] as String),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.tealGradient.withOpacity(0.15) as Gradient?,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Icon(action['icon'] as IconData, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                action['label'] as String,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingAppointment(BuildContext context) {
    final appointment = mockAppointments.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Upcoming Appointment', actionLabel: 'View All'),
        const SizedBox(height: 12),
        GlassCard(
          onTap: () => context.push('/appointments/detail/${appointment.id}'),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              AvatarCircle(initials: appointment.doctorAvatar, size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.doctorName, style: Theme.of(context).textTheme.titleLarge),
                    Text(appointment.doctorSpecialty, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Text('Tomorrow, 9:00 AM', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textPrimary)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthSnapshot(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Health Snapshot'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Blood Pressure',
                value: '${MockVitals.latestBP.toInt()}/${MockVitals.latestBPDiastolic.toInt()}',
                unit: 'mmHg',
                icon: Icons.monitor_heart_rounded,
                color: AppColors.primary,
                onTap: () => context.push('/health/vitals'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MetricCard(
                label: 'Wellness Score',
                value: MockUser.healthScore,
                unit: '/100',
                icon: Icons.bolt_rounded,
                color: AppColors.success,
                onTap: () => context.push('/health/insights'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveMedications(BuildContext context) {
    final meds = mockMedications.where((m) => m.isActive).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Active Medications',
          actionLabel: 'See All',
          onAction: () => context.push('/medications'),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meds.take(2).length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final med = meds[index];
            return GlassCard(
              onTap: () => context.push('/medications/detail/${med.id}'),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.medication_outlined, color: AppColors.secondary, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(med.name, style: Theme.of(context).textTheme.titleMedium),
                        Text('${med.dosage} • ${med.frequency}', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Next Dose', style: Theme.of(context).textTheme.labelSmall),
                      const Text('9:00 PM', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHealthTipBanner(BuildContext context) {
    return GlassCard(
      gradient: AppColors.violetGradient.withOpacity(0.2) as Gradient?,
      borderColor: AppColors.secondary.withOpacity(0.3),
      onTap: () => context.push('/health-tips'),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: AppColors.secondary, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Health Tip of the Day',
                  style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  'Small sleep improvements have outsized cardiovascular benefits.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
