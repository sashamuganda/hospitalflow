import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    // Mock fetch
    final doc = mockDoctors.firstWhere((d) => d.id == doctorId, orElse: () => mockDoctors[0]);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.tealGradient),
                child: Center(
                  child: Hero(
                    tag: 'avatar_${doc.id}',
                    child: AvatarCircle(initials: doc.avatar, size: 80),
                  ),
                ),
              ),
              title: Text(doc.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc.specialty, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary)),
                          Text(doc.qualifications, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const StatusBadge(label: 'ONLINE', color: AppColors.success),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(context, 'Exp.', '12 yrs'),
                      _buildStat(context, 'Patients', '4.8k+'),
                      _buildStat(context, 'Reviews', doc.reviewCount.toString()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('About', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text(
                    'Dr. Ngozi Adeyemi is a board-certified Cardiologist with over 12 years of clinical experience. She specializes in non-invasive cardiology and cardiovascular disease prevention. She is committed to providing compassionate, evidence-based care to her patients.',
                    style: TextStyle(height: 1.5, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  Text('Availability', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _buildAvailabilityGrid(context),
                  const SizedBox(height: 48),
                  GradientButton(
                    label: 'Book Consultation (${doc.consultationFee})',
                    onPressed: () => context.push('/telemedicine/book'),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildAvailabilityGrid(BuildContext context) {
    final slots = ['09:00 AM', '10:30 AM', '01:00 PM', '02:30 PM', '04:00 PM', '05:30 PM'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: slots.map((time) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Text(time, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      )).toList(),
    );
  }
}
