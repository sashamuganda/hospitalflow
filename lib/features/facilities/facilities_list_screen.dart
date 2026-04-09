import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class FacilitiesListScreen extends StatefulWidget {
  const FacilitiesListScreen({super.key});

  @override
  State<FacilitiesListScreen> createState() => _FacilitiesListScreenState();
}

class _FacilitiesListScreenState extends State<FacilitiesListScreen> {
  final List<Map<String, dynamic>> _facilities = [
    {'name': 'St. Nicholas Hospital', 'type': 'General Hospital', 'dist': '1.2 km', 'rating': '4.8', 'open': true},
    {'name': 'Reddington Hospital', 'type': 'Specialist Hospital', 'dist': '2.4 km', 'rating': '4.6', 'open': true},
    {'name': 'Clinix Healthcare', 'type': 'Diagnostic Center', 'dist': '0.8 km', 'rating': '4.9', 'open': true},
    {'name': 'First Cardiology', 'type': 'Cardiology Clinic', 'dist': '3.1 km', 'rating': '4.7', 'open': false},
    {'name': 'Lagoon Hospital', 'type': 'General Hospital', 'dist': '4.5 km', 'rating': '4.5', 'open': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Nearby Facilities'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search facilities...',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.divider)),
                  child: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _facilities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final fac = _facilities[index];
                return GlassCard(
                  onTap: () => context.push('/facilities/detail/1'),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                            child: Icon(
                              fac['type'].contains('Hospital') ? Icons.local_hospital_rounded : Icons.medical_services_rounded,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(fac['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(fac['type'], style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                                    const SizedBox(width: 4),
                                    Text(fac['rating'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 12),
                                    Text(fac['dist'], style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              StatusBadge(
                                label: fac['open'] ? 'OPEN' : 'CLOSED',
                                color: fac['open'] ? AppColors.success : AppColors.error,
                                fontSize: 9,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const TealDivider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           _buildQuickAction(Icons.phone_rounded, 'Call'),
                           _buildQuickAction(Icons.directions_rounded, 'Directions'),
                           _buildQuickAction(Icons.calendar_today_rounded, 'Book'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
