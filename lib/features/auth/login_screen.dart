import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/app_state.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _staffIdCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _facilityCtrl = TextEditingController(text: 'MFH-001');
  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _staffIdCtrl.dispose(); _passwordCtrl.dispose(); _facilityCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_staffIdCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both Staff ID and Password')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    final appState = context.read<AppState>();
    final user = MockCurrentUser.forRole(appState.selectedRole);
    appState.login(user);
    setState(() => _isLoading = false);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AppState>().selectedRole;
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
                  onTap: () => context.go('/role-select'),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 36),
                // Role indicator
                RoleBadge(label: role.displayName),
                const SizedBox(height: 16),
                Text('Welcome Back',
                  style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 8),
                Text('Sign in to access the clinical dashboard.',
                  style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 40),
                // Staff ID
                _buildLabel('Staff ID'),
                const SizedBox(height: 8),
                TextField(
                  controller: _staffIdCtrl,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLength: 32,
                  decoration: const InputDecoration(
                    hintText: 'e.g. DOC-2024-001',
                    prefixIcon: Icon(Icons.badge_outlined, color: AppColors.textMuted),
                    counterText: "",
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordCtrl,
                  obscureText: _obscure,
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onLogin(),
                  maxLength: 64,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted),
                    counterText: "",
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.textMuted, size: 20),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot-password'),
                    child: const Text('Forgot Password?',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ),
                const SizedBox(height: 32),
                GradientButton(
                  label: 'Sign In',
                  icon: Icons.login_rounded,
                  isLoading: _isLoading,
                  onPressed: _onLogin,
                ),
                const SizedBox(height: 40),
                // Facility divider
                const TealDivider(),
                const SizedBox(height: 20),
                _buildLabel('Facility Code'),
                const SizedBox(height: 8),
                TextField(
                  controller: _facilityCtrl,
                  maxLength: 12,
                  decoration: const InputDecoration(
                    hintText: 'MFH-001',
                    prefixIcon: Icon(Icons.business_rounded, color: AppColors.textMuted),
                    counterText: "",
                    helperText: 'Contact your administrator for your facility code.',
                    helperStyle: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 40),
                // Demo hint
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Demo: use any Staff ID and password to sign in.',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: 'Inter')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
      style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600,
        color: AppColors.textSecondary));
  }
}
