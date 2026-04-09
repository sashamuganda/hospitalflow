import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class FacilityDetailScreen extends StatelessWidget {
  final String facilityId;

  const FacilityDetailScreen({super.key, required this.facilityId});
  // Note: router might pass doctorId if it was in params, but here we just need facilityId.
  // Actually, router for facility detail is: GoRoute(path: '/facilities/detail/:id', builder: (_, state) => FacilityDetailScreen(facilityId: state.pathParameters['id'] ?? '')),
  // Wait, I need to check the router again to be sure of the constructor.

  // Constructor in router: FacilityDetailScreen(facilityId: state.pathParameters['id'] ?? '')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.surface,
                child: const Icon(Icons.business_rounded, size: 80, color: AppColors.textMuted),
              ),
              title: const Text('St. Nicholas Hospital', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                          const Text('General Hospital', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          Text('Lagos Island, Lagos', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      const StatusBadge(label: 'OPEN NOW', color: AppColors.success),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem(Icons.star_rounded, '4.8', 'Rating', Colors.amber),
                      _buildInfoItem(Icons.directions_rounded, '1.2 km', 'Distance', AppColors.primary),
                      _buildInfoItem(Icons.phone_rounded, 'Call', 'Contact', AppColors.secondary),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const SectionHeader(title: 'Departments'),
                  const SizedBox(height: 12),
                  _buildDepartmentList(),
                  const SizedBox(height: 32),
                  const SectionHeader(title: 'Insurance Accepted'),
                  const SizedBox(height: 12),
                  _buildInsuranceList(),
                  const SizedBox(height: 32),
                  const SectionHeader(title: 'Overview'),
                  const SizedBox(height: 12),
                  const Text(
                    'Established in 1968, St. Nicholas Hospital is a leading multi-specialty healthcare provider in Nigeria. We are renowned for our excellence in kidney transplants and critical care.',
                    style: TextStyle(height: 1.5, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 48),
                  GradientButton(
                    label: 'Book an Appointment',
                    onPressed: () {},
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

  Widget _buildInfoItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildDepartmentList() {
    final depts = ['Cardiology', 'Surgery', 'Pediatrics', 'Obstetrics & Gynecology', 'Radiology', 'Dialysis'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: depts.map((d) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
        child: Text(d, style: const TextStyle(fontSize: 12)),
      )).toList(),
    );
  }

  Widget _buildInsuranceList() {
    final insurance = ['AXA Mansard', 'Reliance HMO', 'Hygeia', 'Leadway Health', 'AIICO'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: insurance.map((i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
        child: Text(i, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
      )).toList(),
    );
  }
}
