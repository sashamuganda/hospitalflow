import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class QueueHomeScreen extends StatefulWidget {
  const QueueHomeScreen({super.key});
  @override
  State<QueueHomeScreen> createState() => _QueueHomeScreenState();
}

class _QueueHomeScreenState extends State<QueueHomeScreen> {
  TriageLevel? _filterLevel;
  String _filterStatus = 'All';

  List<PatientInQueue> get _filtered {
    var list = mockQueue;
    if (_filterLevel != null) list = list.where((q) => q.triageLevel == _filterLevel).toList();
    if (_filterStatus != 'All') {
      list = list.where((q) {
        switch (_filterStatus) {
          case 'Waiting': return q.status == QueueStatus.waiting;
          case 'In Consult': return q.status == QueueStatus.inConsultation;
          default: return true;
        }
      }).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // ⚡ Bolt: Cache filtered list to avoid O(N^2) complexity in build()
    final filtered = _filtered;
    final waiting = mockQueue.where((q) => q.status == QueueStatus.waiting).length;
    final immediate = mockQueue.where((q) => q.triageLevel == TriageLevel.immediate).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/queue/check-in'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Check In Patient',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Patient Queue', style: Theme.of(context).textTheme.headlineMedium)),
                        StatusBadge(
                          label: immediate > 0 ? '$immediate IMMEDIATE' : '$waiting waiting',
                          color: immediate > 0 ? AppColors.error : AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Triage legend
                    _buildTriageLegend(),
                    const SizedBox(height: 16),
                    // Status filters
                    _buildStatusFilters(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Queue list
              Expanded(
                child: filtered.isEmpty
                    ? const EmptyState(
                        icon: Icons.people_alt_outlined,
                        title: 'Queue is clear',
                        message: 'No patients match the current filter.')
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, i) {
                          final patient = filtered[i];
                          return _QueueCard(
                            patient: patient,
                            onTap: () => context.push('/queue/triage/${patient.id}'),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTriageLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: TriageLevel.values.map((level) {
        final isActive = _filterLevel == level;
        return GestureDetector(
          onTap: () => setState(() => _filterLevel = _filterLevel == level ? null : level),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? level.color.withOpacity(0.2) : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isActive ? level.color : AppColors.divider),
            ),
            child: Column(
              children: [
                Container(width: 10, height: 10,
                  decoration: BoxDecoration(color: level.color, shape: BoxShape.circle)),
                const SizedBox(height: 4),
                Text(level.shortCode,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800,
                    color: isActive ? level.color : AppColors.textMuted, fontFamily: 'Inter')),
                Text('${mockQueue.where((q) => q.triageLevel == level).length}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                    color: isActive ? level.color : AppColors.textSecondary, fontFamily: 'Inter')),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusFilters() {
    const statuses = ['All', 'Waiting', 'In Consult'];
    return Row(
      children: statuses.map((s) {
        final isActive = _filterStatus == s;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _filterStatus = s),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isActive ? AppColors.primary : AppColors.divider),
              ),
              child: Text(s,
                style: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.textOnPrimary : AppColors.textSecondary)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QueueCard extends StatelessWidget {
  final PatientInQueue patient;
  final VoidCallback onTap;
  const _QueueCard({required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isInConsult = patient.status == QueueStatus.inConsultation;
    return GlassCard(
      onTap: onTap,
      borderColor: patient.triageLevel.color.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              // Queue number
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: patient.triageLevel.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: patient.triageLevel.color.withOpacity(0.4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Q', style: TextStyle(fontSize: 10, color: patient.triageLevel.color, fontFamily: 'Inter')),
                    Text('${patient.queueNumber}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,
                        color: patient.triageLevel.color, fontFamily: 'Inter')),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(patient.patientName,
                            style: Theme.of(context).textTheme.titleMedium),
                        ),
                        TriageChip(level: patient.triageLevel, compact: true),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${patient.age}y · ${patient.gender} · ${patient.department}',
                      style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.medical_information_outlined, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(patient.chiefComplaint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text('${patient.waitMinutes} min wait',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontFamily: 'Inter')),
              const Spacer(),
              if (isInConsult) ...[
                const Icon(Icons.circle, size: 8, color: AppColors.success),
                const SizedBox(width: 4),
                Text('In Consultation${patient.assignedDoctorName != null ? ' · ${patient.assignedDoctorName}' : ''}',
                  style: const TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              ] else
                StatusBadge(label: 'Waiting', color: AppColors.warning, fontSize: 11),
            ],
          ),
          if (patient.vitals != null) ...[
            const SizedBox(height: 10),
            const TealDivider(),
            const SizedBox(height: 10),
            Row(
              children: patient.vitals!.entries.take(3).map((e) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontFamily: 'Inter')),
                    Text(e.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary, fontFamily: 'Inter')),
                  ],
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
