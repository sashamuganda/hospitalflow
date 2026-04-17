import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ClinicalNoteEditor extends StatefulWidget {
  final String patientId;
  const ClinicalNoteEditor({super.key, required this.patientId});
  @override
  State<ClinicalNoteEditor> createState() => _ClinicalNoteEditorState();
}

class _ClinicalNoteEditorState extends State<ClinicalNoteEditor> {
  final _sCtrl = TextEditingController();
  final _oCtrl = TextEditingController();
  final _aCtrl = TextEditingController();
  final _pCtrl = TextEditingController();
  final _diagCtrl = TextEditingController();
  bool _isSaving = false;
  bool _isSigning = false;
  String? _template;

  final _templates = [
    'General SOAP',
    'Follow-up',
    'Emergency',
    'Pre-op',
    'Discharge'
  ];

  @override
  void dispose() {
    _sCtrl.dispose();
    _oCtrl.dispose();
    _aCtrl.dispose();
    _pCtrl.dispose();
    _diagCtrl.dispose();
    super.dispose();
  }

  Future<void> _save(bool sign) async {
    setState(() {
      _isSaving = !sign;
      _isSigning = sign;
    });
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      _isSigning = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(sign ? 'Note signed & saved successfully' : 'Draft saved'),
        backgroundColor: sign ? AppColors.success : AppColors.primary));
    if (sign) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Template picker
                      const SizedBox(height: 16),
                      _sectionTitle('Template'),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: _templates.length,
                          itemBuilder: (context, i) {
                            final t = _templates[i];
                            final isActive = _template == t;
                            return GestureDetector(
                              onTap: () => setState(() => _template = t),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.primary.withOpacity(0.15)
                                        : AppColors.surfaceLight,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: isActive
                                            ? AppColors.primary
                                            : AppColors.divider)),
                                child: Text(t,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                        color: isActive
                                            ? AppColors.primary
                                            : AppColors.textSecondary)),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // SOAP sections
                      _buildSoapSection(
                          'S',
                          'Subjective',
                          'Patient-reported symptoms, history, and concerns...',
                          _sCtrl,
                          const Color(0xFF00D4FF)),
                      _buildSoapSection(
                          'O',
                          'Objective',
                          'Examination findings, observations, measurements...',
                          _oCtrl,
                          const Color(0xFF00E5A0)),
                      _buildSoapSection(
                          'A',
                          'Assessment',
                          'Clinical impression, diagnoses, differential...',
                          _aCtrl,
                          const Color(0xFFFFB830)),
                      _buildSoapSection(
                          'P',
                          'Plan',
                          'Treatment plan, medications, follow-up, referrals...',
                          _pCtrl,
                          const Color(0xFF9D67F5)),
                      const SizedBox(height: 20),
                      // Diagnoses
                      _sectionTitle('ICD-10 Diagnoses (optional)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _diagCtrl,
                        maxLength: 200,
                        decoration: const InputDecoration(
                            hintText: 'e.g. I10 - Essential Hypertension',
                            counterText: '',
                            prefixIcon: Icon(Icons.local_hospital_outlined,
                                color: AppColors.textMuted)),
                      ),
                      const SizedBox(height: 32),
                      // Action buttons
                      Row(children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _save(false),
                            icon: _isSaving
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary))
                                : const Icon(Icons.save_outlined),
                            label: const Text('Save Draft'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: GradientButton(
                            label: 'Sign & Submit',
                            icon: Icons.verified_outlined,
                            isLoading: _isSigning,
                            onPressed: () => _save(true),
                          ),
                        ),
                      ]),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
            child: Text('SOAP Note',
                style: Theme.of(context).textTheme.headlineSmall)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8)),
          child: const Text('DRAFT',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.warning,
                  fontFamily: 'Inter')),
        ),
      ]),
    );
  }

  Widget _buildSoapSection(String letter, String title, String hint,
      TextEditingController ctrl, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withOpacity(0.4))),
            child: Center(
                child: Text(letter,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: color))),
          ),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
        ]),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          maxLines: 4,
          maxLength: 2000,
          decoration: InputDecoration(
            hintText: hint,
            counterText: '',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: color, width: 1.5)),
          ),
        ),
      ]),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary));
}
