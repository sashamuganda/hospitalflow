import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class TelemedicineHomeScreen extends StatelessWidget {
  const TelemedicineHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Virtual Consultation',
        actions: [
          IconButton(
            onPressed: () => context.push('/telemedicine/history'),
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActionHero(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Active / Upcoming'),
            const SizedBox(height: 12),
            _buildActiveWaitlist(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Available Specialists'),
            const SizedBox(height: 12),
            _buildSpecialistsPreview(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActionHero(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.tealGradient.withOpacity(0.15) as Gradient?,
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connect with a Doctor\nin minutes.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, height: 1.2),
          ),
          const SizedBox(height: 12),
          const Text(
            'Skip the travel. Get verified medical advice from the comfort of your home.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          GradientButton(
            label: 'Instant Consultation',
            icon: Icons.flash_on_rounded,
            onPressed: () => context.push('/telemedicine/find-doctor'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveWaitlist(BuildContext context) {
    // Simulated active session
    return GlassCard(
      onTap: () => context.push('/telemedicine/waiting-room'),
      padding: const EdgeInsets.all(16),
      borderColor: AppColors.warning.withOpacity(0.3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.videocam_rounded, color: AppColors.warning),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Waiting Room Entry', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Dr. Ngozi Adeyemi • Starts in 5 mins', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const StatusBadge(label: 'READY', color: AppColors.success, fontSize: 10),
        ],
      ),
    );
  }

  Widget _buildSpecialistsPreview(BuildContext context) {
    final doctors = mockDoctors.take(3).toList();
    return Column(
      children: doctors.map((doc) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GlassCard(
          onTap: () => context.push('/telemedicine/doctor/${doc.id}'),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AvatarCircle(initials: doc.avatar, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doc.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(doc.specialty, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 4),
                    StarRating(rating: doc.rating, count: doc.reviewCount, size: 12),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      )).toList(),
    );
  }
}
