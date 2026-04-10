import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class PatientSummaryScreen extends StatefulWidget {
  final String patientId;
  const PatientSummaryScreen({super.key, required this.patientId});
  @override
  State<PatientSummaryScreen> createState() => _PatientSummaryScreenState();
}

class _PatientSummaryScreenState extends State<PatientSummaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  PatientRecord? get _patient =>
      mockPatientRecords.where((p) => p.id == widget.patientId).firstOrNull;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final p = _patient;
    if (p == null) return const Scaffold(body: Center(child: Text('Patient not found')));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, p),
              // Patient hero card
              _buildHeroCard(context, p),
              // Tabs
              Container(
                color: AppColors.surface,
                child: TabBar(
                  controller: _tabs,
                  tabs: const [
                    Tab(text: 'Summary'), Tab(text: 'Vitals'),
                    Tab(text: 'Notes'), Tab(text: 'Labs'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: [
                    _buildSummaryTab(context, p),
                    _buildVitalsTab(context),
                    _buildNotesTab(context),
                    _buildLabsTab(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/emr/note-editor/${p.id}'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        icon: const Icon(Icons.note_add_rounded),
        label: const Text('New Note', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PatientRecord p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text('Patient Summary', style: Theme.of(context).textTheme.headlineSmall)),
          IconButton(
            onPressed: () => context.push('/emr/prescription/${p.id}'),
            icon: const Icon(Icons.medication_outlined, color: AppColors.secondary),
            tooltip: 'Write Prescription',
          ),
          IconButton(
            onPressed: () => context.push('/emr/vitals/${p.id}'),
            icon: const Icon(Icons.monitor_heart_rounded, color: AppColors.primary),
            tooltip: 'Enter Vitals',
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, PatientRecord p) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.15), AppColors.secondary.withOpacity(0.08)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          AvatarCircle(initials: p.avatarInitials, size: 60),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.fullName, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text('${p.age}y · ${p.gender} · DOB: ${_fmtDate(p.dateOfBirth)}',
                  style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.error.withOpacity(0.3))),
                    child: Text(p.bloodGroup, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.error, fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 8),
                  if (p.insuranceProvider != null)
                    RoleBadge(label: p.insuranceProvider!, color: AppColors.success),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTab(BuildContext context, PatientRecord p) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Active Conditions'),
          const SizedBox(height: 10),
          p.activeConditions.isEmpty
              ? _emptyChip('No active conditions')
              : Wrap(spacing: 8, runSpacing: 8, children: p.activeConditions.map((c) =>
                  StatusBadge(label: c, color: AppColors.secondary)).toList()),
          const SizedBox(height: 20),
          _sectionTitle('Allergies'),
          const SizedBox(height: 10),
          p.allergies.isEmpty
              ? _emptyChip('NKDA — No known drug allergies')
              : Wrap(spacing: 8, runSpacing: 8, children: p.allergies.map((a) =>
                  StatusBadge(label: '⚠ $a', color: AppColors.error)).toList()),
          const SizedBox(height: 20),
          _sectionTitle('Current Medications'),
          const SizedBox(height: 10),
          p.currentMedications.isEmpty
              ? _emptyChip('No current medications')
              : Column(
                  children: p.currentMedications.map((m) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(children: [
                        const Icon(Icons.medication_outlined, color: AppColors.secondary, size: 20),
                        const SizedBox(width: 10),
                        Text(m, style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                    ),
                  )).toList()),
          const SizedBox(height: 20),
          _sectionTitle('Contact Information'),
          const SizedBox(height: 10),
          InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: p.phone),
          InfoRow(icon: Icons.badge_outlined, label: 'National ID', value: p.nationalId),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildVitalsTab(BuildContext context) {
    final vitalsList = mockVitals.where((v) => v.patientId == widget.patientId).toList();
    return vitalsList.isEmpty
        ? EmptyState(
            icon: Icons.monitor_heart_outlined,
            title: 'No Vitals Recorded',
            message: 'Tap the vitals icon or button to enter vitals.',
            actionLabel: 'Enter Vitals',
            onAction: () => context.push('/emr/vitals/${widget.patientId}'))
        : ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: vitalsList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) => _VitalsCard(vitals: vitalsList[i]),
          );
  }

  Widget _buildNotesTab(BuildContext context) {
    final notes = mockClinicalNotes.where((n) => n.patientId == widget.patientId).toList();
    return notes.isEmpty
        ? EmptyState(
            icon: Icons.notes_rounded,
            title: 'No Clinical Notes',
            message: 'Tap the + button to create the first note.',
            actionLabel: 'New SOAP Note',
            onAction: () => context.push('/emr/note-editor/${widget.patientId}'))
        : ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) => _NoteCard(note: notes[i]),
          );
  }

  Widget _buildLabsTab(BuildContext context) {
    final orders = mockLabOrders.where((l) => l.patientId == widget.patientId).toList();
    return orders.isEmpty
        ? EmptyState(
            icon: Icons.science_outlined,
            title: 'No Lab Orders',
            message: 'No lab/investigation orders for this patient.',
            actionLabel: 'Order Lab Tests',
            onAction: () => context.push('/emr/lab-order/${widget.patientId}'))
        : ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final o = orders[i];
              return GlassCard(
                borderColor: o.priorityColor.withOpacity(0.3),
                padding: const EdgeInsets.all(14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    StatusBadge(label: o.priority.toUpperCase(), color: o.priorityColor, fontSize: 10),
                    const Spacer(),
                    StatusBadge(label: o.status, color: AppColors.primary, fontSize: 10),
                  ]),
                  const SizedBox(height: 10),
                  Wrap(spacing: 6, runSpacing: 6, children: o.tests.map((t) =>
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
                      child: Text(t, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontFamily: 'Inter')),
                    )).toList()),
                  const SizedBox(height: 8),
                  Text('Ordered by: ${o.orderedByName}', style: Theme.of(context).textTheme.bodySmall),
                  Text('Specimen: ${o.specimenType ?? "—"}', style: Theme.of(context).textTheme.bodySmall),
                ]),
              );
            });
  }

  Widget _sectionTitle(String t) => Text(t,
    style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary));

  Widget _emptyChip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
    child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textMuted, fontFamily: 'Inter')));

  String _fmtDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
}

class _VitalsCard extends StatelessWidget {
  final VitalSigns vitals;
  const _VitalsCard({required this.vitals});
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.monitor_heart_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          Text('Vitals — ${_fmt(vitals.timestamp)}', style: Theme.of(context).textTheme.titleSmall),
          const Spacer(),
          Text(vitals.recordedBy, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontFamily: 'Inter')),
        ]),
        const SizedBox(height: 12),
        Wrap(spacing: 16, runSpacing: 8, children: [
          if (vitals.systolicBP != null) _vItem('BP', vitals.bpDisplay, 'mmHg'),
          if (vitals.heartRate != null) _vItem('HR', '${vitals.heartRate!.toInt()}', 'bpm'),
          if (vitals.spO2 != null) _vItem('SpO₂', '${vitals.spO2!.toInt()}', '%'),
          if (vitals.temperature != null) _vItem('Temp', '${vitals.temperature}', '°C'),
          if (vitals.weight != null) _vItem('Weight', '${vitals.weight}', 'kg'),
        ]),
      ]),
    );
  }

  Widget _vItem(String l, String v, String u) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(l, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontFamily: 'Inter')),
    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontFamily: 'Inter')),
      const SizedBox(width: 2),
      Text(u, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: 'Inter')),
    ]),
  ]);

  String _fmt(DateTime d) => '${d.day}/${d.month} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}

class _NoteCard extends StatelessWidget {
  final ClinicalNote note;
  const _NoteCard({required this.note});
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: note.isSigned ? AppColors.success.withOpacity(0.3) : AppColors.warning.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(note.doctorName, style: Theme.of(context).textTheme.titleSmall)),
          StatusBadge(label: note.isSigned ? 'Signed' : 'Draft',
            color: note.isSigned ? AppColors.success : AppColors.warning, fontSize: 10),
        ]),
        Text(_fmt(note.createdAt), style: Theme.of(context).textTheme.bodySmall),
        if (note.diagnoses.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 4, children: note.diagnoses.map((d) =>
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(6)),
              child: Text(d, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontFamily: 'Inter')),
            )).toList()),
        ],
        const SizedBox(height: 10),
        Text('A: ${note.assessment}', style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
          maxLines: 2, overflow: TextOverflow.ellipsis),
      ]),
    );
  }
  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
