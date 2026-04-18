import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class TriageScreen extends StatefulWidget {
  final String patientId;
  const TriageScreen({super.key, required this.patientId});
  @override
  State<TriageScreen> createState() => _TriageScreenState();
}

class _TriageScreenState extends State<TriageScreen> {
  final _complaintCtrl = TextEditingController();
  TriageLevel? _selectedTriage;
  double _painScore = 0;
  final _bpSystolicCtrl = TextEditingController();
  final _bpDiastolicCtrl = TextEditingController();
  final _hrCtrl = TextEditingController();
  final _spo2Ctrl = TextEditingController();
  final _tempCtrl = TextEditingController();
  bool _isSaving = false;

  final _quickComplaints = [
    'Chest Pain',
    'Difficulty Breathing',
    'High Fever',
    'Trauma/Injury',
    'Abdominal Pain',
    'Headache',
    'Loss of Consciousness',
    'Allergic Reaction',
  ];

  PatientInQueue? get _patient =>
      mockQueue.where((q) => q.id == widget.patientId).firstOrNull;

  @override
  void dispose() {
    _complaintCtrl.dispose();
    _bpSystolicCtrl.dispose();
    _bpDiastolicCtrl.dispose();
    _hrCtrl.dispose();
    _spo2Ctrl.dispose();
    _tempCtrl.dispose();
    super.dispose();
  }

  Future<void> _onConfirm() async {
    if (_selectedTriage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a triage level'),
          backgroundColor: AppColors.error));
      return;
    }
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Triage saved — ${_selectedTriage!.label}'),
        backgroundColor: _selectedTriage!.color));
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
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Text('Triage Assessment',
                            style: Theme.of(context).textTheme.headlineSmall)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient mini-card
                      if (patient != null)
                        _buildPatientHeader(context, patient),
                      const SizedBox(height: 24),
                      // Chief complaint
                      _buildSectionTitle('Chief Complaint'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _complaintCtrl,
                        maxLines: 2,
                        maxLength: 500,
                        decoration: const InputDecoration(
                            hintText:
                                'Describe the patient\'s main complaint...',
                            counterText: ''),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _quickComplaints
                            .map((c) => GestureDetector(
                                  onTap: () {
                                    setState(() => _complaintCtrl.text =
                                        _complaintCtrl.text.isEmpty
                                            ? c
                                            : '${_complaintCtrl.text}, $c');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceLight,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: AppColors.divider),
                                    ),
                                    child: Text(c,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                            fontFamily: 'Inter')),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      // Vitals
                      _buildSectionTitle('Vital Signs'),
                      const SizedBox(height: 12),
                      _buildVitalsGrid(),
                      const SizedBox(height: 24),
                      // Pain score
                      _buildSectionTitle(
                          'Pain Score: ${_painScore.toInt()}/10'),
                      const SizedBox(height: 8),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 6,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10),
                        ),
                        child: Slider(
                          value: _painScore,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          activeColor: _painColor(_painScore),
                          inactiveColor: AppColors.divider,
                          onChanged: (v) => setState(() => _painScore = v),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['No Pain', 'Moderate', 'Severe']
                            .map((l) => Text(l,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                    fontFamily: 'Inter')))
                            .toList(),
                      ),
                      const SizedBox(height: 28),
                      // Triage level
                      _buildSectionTitle('Assign Triage Level'),
                      const SizedBox(height: 12),
                      _buildTriageSelector(),
                      const SizedBox(height: 32),
                      // Confirm button
                      GradientButton(
                        label: 'Confirm Triage',
                        icon: Icons.check_circle_outlined,
                        isLoading: _isSaving,
                        gradient: _selectedTriage != null
                            ? LinearGradient(colors: [
                                _selectedTriage!.color,
                                _selectedTriage!.color.withOpacity(0.7)
                              ])
                            : AppColors.tealGradient,
                        onPressed: _onConfirm,
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

  Widget _buildPatientHeader(BuildContext context, PatientInQueue p) {
    return GlassCard(
      borderColor: AppColors.primary.withOpacity(0.3),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          AvatarCircle(initials: p.initials, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.patientName,
                  style: Theme.of(context).textTheme.titleMedium),
              Text('${p.age}y · ${p.gender} · Queue #${p.queueNumber}',
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
          StatusBadge(label: 'Q${p.queueNumber}', color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary));
  }

  Widget _buildVitalsGrid() {
    return Row(
      children: [
        Expanded(
            child: _VitalField(
                label: 'Systolic BP',
                hint: '120',
                unit: 'mmHg',
                controller: _bpSystolicCtrl)),
        const SizedBox(width: 10),
        Expanded(
            child: _VitalField(
                label: 'Diastolic BP',
                hint: '80',
                unit: 'mmHg',
                controller: _bpDiastolicCtrl)),
        const SizedBox(width: 10),
        Expanded(
            child: _VitalField(
                label: 'Heart Rate',
                hint: '72',
                unit: 'bpm',
                controller: _hrCtrl)),
      ],
    );
  }

  Widget _buildTriageSelector() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: TriageLevel.values.map((level) {
        final isSelected = _selectedTriage == level;
        return GestureDetector(
          onTap: () => setState(() => _selectedTriage = level),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? level.color.withOpacity(0.2)
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isSelected ? level.color : AppColors.divider,
                  width: isSelected ? 1.5 : 1),
            ),
            child: Row(
              children: [
                Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: level.color, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text(level.label,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? level.color
                            : AppColors.textSecondary)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _painColor(double score) {
    if (score <= 3) return AppColors.success;
    if (score <= 6) return AppColors.warning;
    return AppColors.error;
  }
}

class _VitalField extends StatelessWidget {
  final String label;
  final String hint;
  final String unit;
  final TextEditingController controller;
  const _VitalField(
      {required this.label,
      required this.hint,
      required this.unit,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 8,
          decoration: InputDecoration(
              hintText: hint,
              counterText: '',
              suffix: Text(unit,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMuted))),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
