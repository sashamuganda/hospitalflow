import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({super.key});

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  String? _selectedReason;

  final List<String> _reasons = [
    'Work conflict',
    'Personal emergency',
    'Feeling better',
    'Found another provider',
    'Traveling',
    'Cost of consultation',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Cancel Appointment'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Are you sure?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Please let us know why you\'re cancelling. This helps us improve our service.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Text('Reason for Cancellation', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _reasons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final reason = _reasons[index];
                  final isSelected = _selectedReason == reason;
                  return GlassCard(
                    onTap: () => setState(() => _selectedReason = reason),
                    borderColor: isSelected ? AppColors.error : AppColors.divider,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          reason,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? AppColors.error : AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(Icons.check_circle_rounded, color: AppColors.error, size: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.error.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, size: 18, color: AppColors.error),
                      SizedBox(width: 8),
                      Text(
                        'Cancellation Policy',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.error),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cancellations made within 24 hours of the appointment may incur a late fee of 50% of the consultation price.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              label: 'Confirm Cancellation',
              gradient: const LinearGradient(colors: [AppColors.error, Color(0xFFD32F2F)]),
              onPressed: _selectedReason != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Appointment successfully cancelled.')),
                      );
                      context.go('/appointments');
                    }
                  : () {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => context.pop(),
                child: const Text('Keep Appointment'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
