import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class RecordsHomeScreen extends StatelessWidget {
  const RecordsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Medical Records',
        showBack: false,
        actions: [
          IconButton(
            onPressed: () => context.push('/records/share'),
            icon: const Icon(Icons.share_rounded, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search records, labs, or doctors...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded, size: 20),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionsGrid(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Recent Activity'),
            const SizedBox(height: 12),
            _buildRecentActivity(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionsGrid(BuildContext context) {
    final sections = [
      {'title': 'Visit History', 'icon': Icons.history_rounded, 'color': AppColors.primary, 'route': '/records/visits', 'count': '12'},
      {'title': 'Lab Results', 'icon': Icons.biotech_rounded, 'color': AppColors.success, 'route': '/records/labs', 'count': '03'},
      {'title': 'Prescriptions', 'icon': Icons.medication_rounded, 'color': AppColors.secondary, 'route': '/records/prescriptions', 'count': '04'},
      {'title': 'Diagnoses', 'icon': Icons.assignment_rounded, 'color': AppColors.warning, 'route': '/records/diagnoses', 'count': '03'},
      {'title': 'Imaging', 'icon': Icons.visibility_rounded, 'color': Colors.blue, 'route': '/records/imaging', 'count': '02'},
      {'title': 'Discharge', 'icon': Icons.description_rounded, 'color': AppColors.error, 'route': '/records/discharge', 'count': '01'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        final color = section['color'] as Color;
        return GlassCard(
          onTap: () => context.push(section['route'] as String),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(section['icon'] as IconData, color: color, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section['count'] as String,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    section['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.file_present_rounded, color: AppColors.textMuted),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CBC Blood Test Results', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Yesterday • Dr. Ngozi Adeyemi', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const StatusBadge(label: 'Normal', color: AppColors.success, fontSize: 10),
            ],
          ),
        );
      },
    );
  }
}
