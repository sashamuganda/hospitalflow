import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class BookStep2Screen extends StatefulWidget {
  const BookStep2Screen({super.key});

  @override
  State<BookStep2Screen> createState() => _BookStep2ScreenState();
}

class _BookStep2ScreenState extends State<BookStep2Screen> {
  final List<String> _specialties = [
    'General Practice', 'Cardiology', 'Gynecology', 'Dermatology',
    'Mental Health', 'Pediatrics', 'Neurology', 'Oncology',
    'Orthopedics', 'Ophthalmology', 'Pulmonology', 'Urology',
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredSpecialties = _specialties
        .where((s) => s.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Reason for Visit'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Step 2 of 5',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Select Specialty',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              'What area of medicine does your concern relate to?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: const InputDecoration(
                hintText: 'Search specialties...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: filteredSpecialties.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final specialty = filteredSpecialties[index];
                  return GlassCard(
                    onTap: () => context.push('/appointments/book/step3'),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          specialty,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Or describe your symptoms in your own words:',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            const TextField(
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'e.g. I have a persistent cough and fever...',
              ),
            ),
            const SizedBox(height: 24),
            GradientButton(
              label: 'Continue',
              onPressed: () => context.push('/appointments/book/step3'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
