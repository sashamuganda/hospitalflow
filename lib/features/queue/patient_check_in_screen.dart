import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PatientCheckInScreen extends StatefulWidget {
  const PatientCheckInScreen({super.key});
  @override
  State<PatientCheckInScreen> createState() => _PatientCheckInScreenState();
}

class _PatientCheckInScreenState extends State<PatientCheckInScreen> {
  final _nameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  String _gender = 'Male';
  String _department = 'OPD';
  bool _isLoading = false;
  int _step = 0;

  @override
  void dispose() {
    _nameCtrl.dispose(); _idCtrl.dispose();
    _phoneCtrl.dispose(); _ageCtrl.dispose();
    super.dispose();
  }

  Future<void> _onCheckIn() async {
    if (_nameCtrl.text.isEmpty || _ageCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() { _isLoading = false; _step = 1; });
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Patient Check-In', style: Theme.of(context).textTheme.headlineSmall),
                ]),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _step == 0
                    ? _buildCheckInForm(context)
                    : _buildSuccessState(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckInForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step indicator
          Row(
            children: [
              Container(width: 28, height: 28,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Center(child: Text('1', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textOnPrimary, fontFamily: 'Inter')))),
              const SizedBox(width: 8),
              const Text('Patient Details', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
              const Expanded(child: Divider(color: AppColors.divider, indent: 8, endIndent: 8)),
              Container(width: 28, height: 28,
                decoration: BoxDecoration(color: AppColors.surfaceLight, shape: BoxShape.circle, border: Border.all(color: AppColors.divider)),
                child: const Center(child: Text('2', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textMuted, fontFamily: 'Inter')))),
              const SizedBox(width: 8),
              const Text('Triage', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            ],
          ),
          const SizedBox(height: 28),
          _fieldLabel('Full Name'),
          const SizedBox(height: 8),
          TextField(controller: _nameCtrl, decoration: const InputDecoration(
            hintText: 'Patient full name', prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted))),
          const SizedBox(height: 16),
          _fieldLabel('National ID / Passport'),
          const SizedBox(height: 8),
          TextField(controller: _idCtrl, decoration: const InputDecoration(
            hintText: 'ID number (optional)', prefixIcon: Icon(Icons.badge_outlined, color: AppColors.textMuted))),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _fieldLabel('Age'),
              const SizedBox(height: 8),
              TextField(controller: _ageCtrl, keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '0', prefixIcon: Icon(Icons.cake_outlined, color: AppColors.textMuted))),
            ])),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _fieldLabel('Gender'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _gender, isExpanded: true,
                    dropdownColor: AppColors.surface,
                    style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.textPrimary),
                    items: ['Male','Female','Other'].map((g) =>
                      DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _gender = v!),
                  ),
                ),
              ),
            ])),
          ]),
          const SizedBox(height: 16),
          _fieldLabel('Phone Number'),
          const SizedBox(height: 8),
          TextField(controller: _phoneCtrl, keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: '+254 7XX XXX XXX',
              prefixIcon: Icon(Icons.phone_outlined, color: AppColors.textMuted))),
          const SizedBox(height: 16),
          _fieldLabel('Department / Clinic'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _department, isExpanded: true,
                dropdownColor: AppColors.surface,
                style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.textPrimary),
                items: ['OPD', 'Emergency', 'Pediatrics', 'Maternity', 'Surgical', 'Dental']
                  .map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (v) => setState(() => _department = v!),
              ),
            ),
          ),
          const SizedBox(height: 36),
          GradientButton(
            label: 'Check In & Proceed to Triage',
            icon: Icons.arrow_forward_rounded,
            isLoading: _isLoading,
            onPressed: _onCheckIn,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90, height: 90,
            decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 52),
          ),
          const SizedBox(height: 24),
          Text(_nameCtrl.text, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Successfully checked in!',
            style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _confirmRow('Queue Number', 'Q${DateTime.now().second % 10 + 8}'),
              _confirmRow('Department', _department),
              _confirmRow('Age / Gender', '${_ageCtrl.text}y · $_gender'),
            ]),
          ),
          const SizedBox(height: 32),
          GradientButton(
            label: 'Proceed to Triage',
            icon: Icons.assignment_ind_rounded,
            onPressed: () {
              context.go('/queue');
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => setState(() { _step = 0; _nameCtrl.clear(); }),
            child: const Text('Check In Another Patient'),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) => Text(text,
    style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary));

  Widget _confirmRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      Text(label, style: const TextStyle(color: AppColors.textSecondary, fontFamily: 'Inter', fontSize: 13)),
      const Spacer(),
      Text(value, style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w700)),
    ]),
  );
}
