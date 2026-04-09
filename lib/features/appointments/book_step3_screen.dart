import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class BookStep3Screen extends StatelessWidget {
  const BookStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, logic here would filter based on previous selections
    final doctors = mockDoctors.where((d) => d.specialty == 'Cardiology').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Select Professional'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Step 3 of 5',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose Your Doctor',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Based on your selection (Cardiology), here are available specialists.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: doctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return GlassCard(
                    onTap: () => context.push('/appointments/book/step4'),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AvatarCircle(initials: doctor.avatar, size: 56),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor.name, style: Theme.of(context).textTheme.titleLarge),
                                  Text(doctor.qualifications, style: Theme.of(context).textTheme.bodySmall),
                                  const SizedBox(height: 4),
                                  StarRating(rating: doctor.rating, count: doctor.reviewCount),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const TealDivider(),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDocInfo(context, 'Consultation Fee', doctor.consultationFee, Icons.payments_outlined),
                            _buildDocInfo(context, 'Next Available', doctor.nextSlot, Icons.access_time_rounded),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDocInfo(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          ],
        ),
      ],
    );
  }
}
