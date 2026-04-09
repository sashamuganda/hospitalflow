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
  bool _isSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Forgot Password'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              _isSent ? 'Check Your Inbox' : 'Reset Your Password',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12),
            Text(
              _isSent
                  ? 'We\'ve sent a password reset link to amara.okonkwo@gmail.com. Please check your email and follow the instructions.'
                  : 'Enter your registered email or phone number. We\'ll send you a link to reset your password.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),
            if (!_isSent) ...[
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email or Phone Number',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const Spacer(),
              GradientButton(
                label: 'Send Reset Link',
                onPressed: () => setState(() => _isSent = true),
              ),
            ] else ...[
              const Spacer(),
              GradientButton(
                label: 'Go to Reset Password',
                onPressed: () => context.push('/reset-password'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => setState(() => _isSent = false),
                  child: const Text('Resend Link'),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
