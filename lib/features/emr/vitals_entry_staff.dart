import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class VitalsEntryStaff extends StatefulWidget {
  final String patientId;
  const VitalsEntryStaff({super.key, required this.patientId});
  @override
  State<VitalsEntryStaff> createState() => _VitalsEntryStaffState();
}

class _VitalsEntryStaffState extends State<VitalsEntryStaff> {
  final _controllers = <String, TextEditingController>{
    'systolicBP': TextEditingController(),
    'diastolicBP': TextEditingController(),
    'heartRate': TextEditingController(),
    'spO2': TextEditingController(),
    'temperature': TextEditingController(),
    'respiratoryRate': TextEditingController(),
    'weight': TextEditingController(),
    'height': TextEditingController(),
  };
  bool _isSaving = false;

  PatientRecord? get _patient =>
      mockPatientRecords.where((p) => p.id == widget.patientId).firstOrNull;

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Vitals saved to patient record'),
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
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Text('Enter Vitals',
                          style: Theme.of(context).textTheme.headlineSmall)),
                  const Icon(Icons.monitor_heart_rounded,
                      color: AppColors.primary, size: 28),
                ]),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient mini-header
                      if (patient != null)
                        GlassCard(
                          borderColor: AppColors.primary.withOpacity(0.3),
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [
                            AvatarCircle(
                                initials: patient.avatarInitials, size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(patient.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  Text('${patient.age}y · ${patient.gender}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ])),
                          ]),
                        ),
                      const SizedBox(height: 24),
                      // Vitals grid
                      _buildVitalsSection(context),
                      const SizedBox(height: 24),
                      // Timestamp
                      GlassCard(
                        padding: const EdgeInsets.all(12),
                        child: Row(children: [
                          const Icon(Icons.access_time_rounded,
                              color: AppColors.primary, size: 18),
                          const SizedBox(width: 10),
                          Text('Timestamp: ${_nowFormatted()}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  color: AppColors.textSecondary)),
                          const Spacer(),
                          const Text('Auto-set',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  fontFamily: 'Inter')),
                        ]),
                      ),
                      const SizedBox(height: 32),
                      GradientButton(
                        label: 'Save Vitals',
                        icon: Icons.save_rounded,
                        isLoading: _isSaving,
                        onPressed: _onSave,
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

  Widget _buildVitalsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blood Pressure
        _groupTitle('Blood Pressure'),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: _vField('Systolic', 'mmHg', _controllers['systolicBP']!,
                  AppColors.error)),
          const SizedBox(width: 16),
          Expanded(
              child: _vField('Diastolic', 'mmHg', _controllers['diastolicBP']!,
                  AppColors.error)),
        ]),
        const SizedBox(height: 20),
        _groupTitle('Cardiac & Respiratory'),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: _vField('Heart Rate', 'bpm', _controllers['heartRate']!,
                  AppColors.primary)),
          const SizedBox(width: 16),
          Expanded(
              child: _vField(
                  'SpO₂', '%', _controllers['spO2']!, const Color(0xFF00D4FF))),
          const SizedBox(width: 16),
          Expanded(
              child: _vField('Resp. Rate', '/min',
                  _controllers['respiratoryRate']!, AppColors.secondary)),
        ]),
        const SizedBox(height: 20),
        _groupTitle('Temperature & Anthropometric'),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: _vField('Temperature', '°C', _controllers['temperature']!,
                  AppColors.warning)),
          const SizedBox(width: 16),
          Expanded(
              child: _vField(
                  'Weight', 'kg', _controllers['weight']!, AppColors.success)),
          const SizedBox(width: 16),
          Expanded(
              child: _vField(
                  'Height', 'cm', _controllers['height']!, AppColors.success)),
        ]),
      ],
    );
  }

  Widget _groupTitle(String t) => Text(t,
      style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary));

  Widget _vField(
      String label, String unit, TextEditingController ctrl, Color accent) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.2))),
        child: Column(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: accent.withOpacity(0.15), shape: BoxShape.circle),
            child: Center(
                child: Text(unit.length <= 3 ? unit : unit.substring(0, 3),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: accent,
                        fontFamily: 'Inter'))),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '—',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: Colors.transparent,
              filled: false,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: accent,
                fontFamily: 'Inter'),
          ),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                  fontFamily: 'Inter')),
        ]),
      ),
    ]);
  }

  String _nowFormatted() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
