import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _staffIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() { _staffIdCtrl.dispose(); _emailCtrl.dispose(); super.dispose(); }

  Future<void> _onSubmit() async {
    if (_staffIdCtrl.text.isEmpty || _emailCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() { _isLoading = false; _sent = true; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.lock_reset_rounded, color: AppColors.secondary, size: 36),
                ),
                const SizedBox(height: 24),
                Text('Reset Password', style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 8),
                Text('Enter your Staff ID and registered email. We\'ll send a reset link.',
                  style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 40),
                if (_sent) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.success.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 48),
                        const SizedBox(height: 16),
                        Text('Reset Link Sent!',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.success)),
                        const SizedBox(height: 8),
                        Text('Check your registered email for the password reset instructions.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        GradientButton(
                          label: 'Back to Login',
                          onPressed: () => context.go('/login'),
                          gradient: AppColors.violetGradient,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const _FieldLabel(text: 'Staff ID'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _staffIdCtrl,
                    decoration: const InputDecoration(
                      hintText: 'e.g. DOC-2024-001',
                      prefixIcon: Icon(Icons.badge_outlined, color: AppColors.textMuted),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const _FieldLabel(text: 'Registered Email'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'staff@medflow.hospital',
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.textMuted),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GradientButton(
                    label: 'Send Reset Link',
                    icon: Icons.send_rounded,
                    isLoading: _isLoading,
                    onPressed: _onSubmit,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});
  @override
  Widget build(BuildContext context) => Text(text,
    style: const TextStyle(fontFamily: 'Inter', fontSize: 13,
      fontWeight: FontWeight.w600, color: AppColors.textSecondary));
}
