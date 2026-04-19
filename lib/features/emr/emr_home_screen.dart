import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class EmrHomeScreen extends StatefulWidget {
  const EmrHomeScreen({super.key});
  @override
  State<EmrHomeScreen> createState() => _EmrHomeScreenState();
}

class _EmrHomeScreenState extends State<EmrHomeScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  List<PatientRecord> get _results {
    if (_query.isEmpty) return mockPatientRecords;
    final q = _query.toLowerCase();
    return mockPatientRecords
        .where((p) =>
            p.fullName.toLowerCase().contains(q) ||
            p.nationalId.contains(q) ||
            p.phone.contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Performance optimization: Cache filtered results in a local variable to avoid
    // redundant filtering and O(N*M) complexity during build and list rendering.
    final patients = _results;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.note_add_rounded),
        label: const Text('New Note',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text('EMR',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium)),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list_rounded,
                              color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search bar
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID, or phone...',
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: AppColors.textMuted),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded,
                                    size: 18, color: AppColors.textMuted),
                                onPressed: () => setState(() {
                                      _query = '';
                                      _searchCtrl.clear();
                                    }))
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_query.isEmpty) ...[
                // Today's patients header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: "Today's Patients",
                    actionLabel: 'All Records',
                    onAction: () {},
                  ),
                ),
                const SizedBox(height: 12),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('${patients.length} results for "$_query"',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: patients.isEmpty
                    ? const EmptyState(
                        icon: Icons.person_search_rounded,
                        title: 'No patients found',
                        message:
                            'Try searching by full name, national ID, or phone number.')
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        itemCount: patients.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, i) => _PatientRecordCard(
                          patient: patients[i],
                          onTap: () =>
                              context.push('/emr/patient/${patients[i].id}'),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatientRecordCard extends StatelessWidget {
  final PatientRecord patient;
  final VoidCallback onTap;
  const _PatientRecordCard({required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          AvatarCircle(initials: patient.avatarInitials, size: 50),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                      child: Text(patient.fullName,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(patient.bloodGroup,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.error,
                            fontFamily: 'Inter')),
                  ),
                ]),
                const SizedBox(height: 4),
                Text(
                    '${patient.age}y · ${patient.gender} · ID: ${patient.nationalId}',
                    style: Theme.of(context).textTheme.bodySmall),
                if (patient.activeConditions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: patient.activeConditions
                        .take(3)
                        .map((c) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        AppColors.secondary.withOpacity(0.2)),
                              ),
                              child: Text(c,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.secondary,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600)),
                            ))
                        .toList(),
                  ),
                ],
                if (patient.lastVisit != null) ...[
                  const SizedBox(height: 6),
                  Text('Last visit: ${_formatDate(patient.lastVisit!)}',
                      style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          fontFamily: 'Inter')),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    final diff = DateTime.now().difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${diff}d ago';
  }
}
