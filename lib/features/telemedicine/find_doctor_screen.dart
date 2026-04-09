import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  String _searchQuery = '';
  String? _selectedSpecialty;

  final List<String> _specialties = [
    'General Practice', 'Cardiology', 'Pediatrics', 'Dermatology', 'Mental Health', 'Gynecology'
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = mockDoctors.where((doc) {
      final matchesSearch = doc.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                            doc.specialty.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSpecialty = _selectedSpecialty == null || doc.specialty == _selectedSpecialty;
      return matchesSearch && matchesSpecialty;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Find a Specialist'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    hintText: 'Search by doctor or specialty...',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _specialties.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final s = _specialties[index];
                      final isSelected = _selectedSpecialty == s;
                      return ChoiceChip(
                        label: Text(s),
                        selected: isSelected,
                        onSelected: (val) => setState(() => _selectedSpecialty = val ? s : null),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredDoctors.isEmpty 
              ? const EmptyState(icon: Icons.search_off_rounded, title: 'No doctors found', message: 'Try adjusting your filters.')
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredDoctors.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final doc = filteredDoctors[index];
                    return _DoctorResultCard(doctor: doc);
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _DoctorResultCard extends StatelessWidget {
  final MockDoctor doctor;

  const _DoctorResultCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () => context.push('/telemedicine/doctor/${doctor.id}'),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              AvatarCircle(initials: doctor.avatar, size: 60),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name, style: Theme.of(context).textTheme.titleLarge),
                    Text(doctor.qualifications, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 4),
                    StatusBadge(label: 'ONLINE', color: AppColors.success, fontSize: 9),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline_rounded, color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 16),
          const TealDivider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDocInfo(context, 'Consultation', doctor.consultationFee, Icons.payments_outlined),
              _buildDocInfo(context, 'Rating', doctor.rating.toString(), Icons.star_rounded),
              _buildDocInfo(context, 'Next Slot', doctor.nextSlot, Icons.access_time_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocInfo(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
