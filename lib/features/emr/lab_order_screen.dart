import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class LabOrderScreen extends StatefulWidget {
  final String patientId;
  const LabOrderScreen({super.key, required this.patientId});
  @override
  State<LabOrderScreen> createState() => _LabOrderScreenState();
}

class _LabOrderScreenState extends State<LabOrderScreen> {
  final _selectedTests = <String>{};
  String _priority = 'routine';
  String _specimen = 'Blood';
  final _notesCtrl = TextEditingController();
  bool _isOrdering = false;

  final _testCategories = {
    'Haematology': ['CBC / FBC', 'Blood Film', 'Coagulation Profile (PT/INR/aPTT)', 'ESR', 'Reticulocyte Count'],
    'Biochemistry': ['Renal Function Tests (Urea/Creatinine)', 'Liver Function Tests', 'Lipid Profile', 'Blood Glucose (RBS/FBS)', 'HbA1c', 'Electrolytes (Na/K)', 'Thyroid Function (TSH/T4)', 'PSA'],
    'Microbiology': ['Blood Culture', 'Urine Culture (MCS)', 'Wound Swab', 'Stool MCS', 'Sputum AAFB'],
    'Serology': ['Malaria RDT', 'Widal Test', 'HIV Screen', 'Hepatitis B (HBsAg)', 'Hepatitis C', 'VDRL/RPR', 'CRP', 'ANA/Anti-dsDNA'],
    'Urine': ['Urinalysis (UA)', 'Urine Pregnancy Test (UPT)', 'Urine Protein:Creatinine'],
  };

  PatientRecord? get _patient =>
      mockPatientRecords.where((p) => p.id == widget.patientId).firstOrNull;

  @override
  void dispose() { _notesCtrl.dispose(); super.dispose(); }

  Future<void> _onOrder() async {
    if (_selectedTests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select at least one test'), backgroundColor: AppColors.error));
      return;
    }
    setState(() => _isOrdering = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isOrdering = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Lab order sent — ${_selectedTests.length} test(s) ordered'),
      backgroundColor: AppColors.success));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final patient = _patient;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Text('Order Lab Tests', style: Theme.of(context).textTheme.headlineSmall)),
                  if (_selectedTests.isNotEmpty)
                    StatusBadge(label: '${_selectedTests.length} selected', color: AppColors.primary),
                ]),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient header
                      if (patient != null)
                        GlassCard(
                          borderColor: AppColors.primary.withOpacity(0.3),
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [
                            AvatarCircle(initials: patient.avatarInitials, size: 40),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(patient.fullName, style: Theme.of(context).textTheme.titleSmall),
                              Text('${patient.age}y · ${patient.gender}', style: Theme.of(context).textTheme.bodySmall),
                            ])),
                          ]),
                        ),
                      const SizedBox(height: 20),
                      // Priority
                      const Text('Priority', style: TextStyle(fontFamily: 'Inter', fontSize: 13,
                        fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      Row(children: [
                        for (final pr in [
                          ('Routine', 'routine', AppColors.primary),
                          ('Urgent', 'urgent', AppColors.warning),
                          ('STAT', 'stat', AppColors.error),
                        ]) ...[
                          Expanded(child: GestureDetector(
                            onTap: () => setState(() => _priority = pr.$2),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _priority == pr.$2 ? pr.$3.withOpacity(0.15) : AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _priority == pr.$2 ? pr.$3 : AppColors.divider)),
                              child: Center(child: Text(pr.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                                fontFamily: 'Inter', color: _priority == pr.$2 ? pr.$3 : AppColors.textMuted))),
                            ),
                          )),
                          const SizedBox(width: 8),
                        ],
                      ]),
                      const SizedBox(height: 20),
                      // Test categories
                      ..._testCategories.entries.map((cat) => _TestCategory(
                        category: cat.key,
                        tests: cat.value,
                        selected: _selectedTests,
                        onToggle: (t) => setState(() =>
                          _selectedTests.contains(t) ? _selectedTests.remove(t) : _selectedTests.add(t)),
                      )),
                      const SizedBox(height: 20),
                      const Text('Clinical Notes (optional)', style: TextStyle(fontFamily: 'Inter', fontSize: 13,
                        fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      TextField(controller: _notesCtrl, maxLines: 2,
                        decoration: const InputDecoration(hintText: 'Relevant clinical information for lab...')),
                      const SizedBox(height: 32),
                      GradientButton(
                        label: 'Send Lab Order',
                        icon: Icons.science_rounded,
                        isLoading: _isOrdering,
                        onPressed: _onOrder,
                      ),
                      const SizedBox(height: 40),
                    ],
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

class _TestCategory extends StatefulWidget {
  final String category;
  final List<String> tests;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  const _TestCategory({required this.category, required this.tests, required this.selected, required this.onToggle});
  @override
  State<_TestCategory> createState() => _TestCategoryState();
}

class _TestCategoryState extends State<_TestCategory> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final selectedCount = widget.tests.where((t) => widget.selected.contains(t)).length;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selectedCount > 0 ? AppColors.primary.withOpacity(0.3) : AppColors.divider)),
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.science_outlined,
            color: selectedCount > 0 ? AppColors.primary : AppColors.textMuted, size: 20),
          title: Text(widget.category, style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (selectedCount > 0)
              StatusBadge(label: '$selectedCount', color: AppColors.primary, fontSize: 10),
            const SizedBox(width: 4),
            Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: AppColors.textMuted),
          ]),
          onTap: () => setState(() => _expanded = !_expanded),
          dense: true,
        ),
        if (_expanded) ...[
          const Divider(color: AppColors.divider, height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: widget.tests.map((t) => GestureDetector(
                onTap: () => widget.onToggle(t),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: widget.selected.contains(t) ? AppColors.primary.withOpacity(0.1) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.selected.contains(t) ? AppColors.primary.withOpacity(0.4) : AppColors.divider)),
                  child: Row(children: [
                    Expanded(child: Text(t, style: TextStyle(fontSize: 13, fontFamily: 'Inter',
                      color: widget.selected.contains(t) ? AppColors.textPrimary : AppColors.textSecondary))),
                    if (widget.selected.contains(t))
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
                  ]),
                ),
              )).toList(),
            ),
          ),
        ],
      ]),
    );
  }
}
