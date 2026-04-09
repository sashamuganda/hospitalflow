import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class HealthHomeScreen extends StatelessWidget {
  const HealthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Health Tracking',
        showBack: false,
        actions: [
          IconButton(
            onPressed: () => context.push('/health/insights'),
            icon: const Icon(Icons.analytics_outlined, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWellnessIndex(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Core Vitals'),
            const SizedBox(height: 12),
            _buildVitalsGrid(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Specialized Trackers'),
            const SizedBox(height: 12),
            _buildSpecializedTrackers(context),
            const SizedBox(height: 24),
            _buildPersonalModule(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWellnessIndex(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.primaryGradient.withOpacity(0.15) as Gradient?,
      borderColor: AppColors.primary.withOpacity(0.3),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.78,
                  strokeWidth: 8,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '78',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wellness Index',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your overall score has improved by 4% since last week.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.3),
                ),
                const SizedBox(height: 12),
                const Text(
                  'VIEW REPORTS',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        MetricCard(
          label: 'Blood Pressure',
          value: '118/76',
          unit: 'mmHg',
          icon: Icons.monitor_heart_rounded,
          color: AppColors.primary,
          onTap: () => context.push('/health/vitals'),
        ),
        MetricCard(
          label: 'Heart Rate',
          value: '72',
          unit: 'bpm',
          icon: Icons.favorite_rounded,
          color: AppColors.error,
          onTap: () => context.push('/health/vitals'),
        ),
        MetricCard(
          label: 'Body Weight',
          value: '68.2',
          unit: 'kg',
          icon: Icons.scale_rounded,
          color: AppColors.secondary,
          onTap: () => context.push('/health/body'),
        ),
        MetricCard(
          label: 'Blood Glucose',
          value: '88',
          unit: 'mg/dL',
          icon: Icons.water_drop_rounded,
          color: AppColors.warning,
          onTap: () => context.push('/health/vitals'),
        ),
      ],
    );
  }

  Widget _buildSpecializedTrackers(BuildContext context) {
    final trackers = [
      {'title': 'Sleep', 'icon': Icons.bedtime_rounded, 'color': Colors.indigo, 'route': '/health/sleep'},
      {'title': 'Mental Wellness', 'icon': Icons.self_improvement_rounded, 'color': Colors.teal, 'route': '/health/mental'},
      {'title': 'Nutrition', 'icon': Icons.restaurant_rounded, 'color': Colors.orange, 'route': '/health/nutrition'},
      {'title': 'Fitness', 'icon': Icons.directions_run_rounded, 'color': AppColors.success, 'route': '/health/fitness'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trackers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final t = trackers[index];
        final color = t['color'] as Color;
        return GlassCard(
          onTap: () => context.push(t['route'] as String),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(t['icon'] as IconData, color: color, size: 24),
              const SizedBox(width: 16),
              Text(t['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPersonalModule(BuildContext context) {
    // Show sex-specific module based on user profile
    final isFemale = MockUser.sex == BiologicalSex.female;

    return GlassCard(
      onTap: () => context.push(isFemale ? '/health/womens' : '/health/mens'),
      padding: const EdgeInsets.all(20),
      gradient: (isFemale ? AppColors.violetGradient : AppColors.tealGradient).withOpacity(0.15) as Gradient?,
      borderColor: (isFemale ? AppColors.secondary : AppColors.primary).withOpacity(0.3),
      child: Row(
        children: [
          Icon(
            isFemale ? Icons.female_rounded : Icons.male_rounded,
            color: isFemale ? AppColors.secondary : AppColors.primary,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFemale ? 'Women\'s Health Hub' : 'Men\'s Health Hub',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  isFemale ? 'Track your cycle, reproductive health, and symptoms.' : 'Monitor cardiovascular risk, hormonal health, and wellness.',
                  style: Theme.of(context).textTheme.bodySmall,
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
