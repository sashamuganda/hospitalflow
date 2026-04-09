import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class BookConsultationScreen extends StatefulWidget {
  const BookConsultationScreen({super.key});

  @override
  State<BookConsultationScreen> createState() => _BookConsultationScreenState();
}

class _BookConsultationScreenState extends State<BookConsultationScreen> {
  String _selectedMethod = 'Wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Confirm Booking'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppointmentSummary(context),
            const SizedBox(height: 32),
            Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildPaymentOption(context, 'Wallet', 'Balance: ₦45,000', Icons.account_balance_wallet_rounded),
            const SizedBox(height: 12),
            _buildPaymentOption(context, 'Card', 'Ending in 4242', Icons.credit_card_rounded),
            const SizedBox(height: 12),
            _buildPaymentOption(context, 'Insurance', 'AXA Mansard (Verified)', Icons.verified_user_rounded),
            const SizedBox(height: 32),
            _buildPriceBreakdown(context),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Pay & Confirm',
              onPressed: () {
                _showSuccessDialog(context);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentSummary(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.videocam_rounded, color: AppColors.primary, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dr. Ngozi Adeyemi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Cardiovascular Consultation', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text('Today, 02:30 PM', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title, String subtitle, IconData icon) {
    final isSelected = _selectedMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = title),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderColor: isSelected ? AppColors.primary : AppColors.divider,
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textMuted),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildPriceRow('Consultation Fee', '₦15,000'),
          const SizedBox(height: 8),
          _buildPriceRow('Service Charge', '₦500'),
          const SizedBox(height: 12),
          const TealDivider(),
          const SizedBox(height: 12),
          _buildPriceRow('Total Amount', '₦15,500', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 16 : 14)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTotal ? 18 : 14, color: isTotal ? AppColors.primary : AppColors.textPrimary)),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 64),
             const SizedBox(height: 24),
             const Text('Payment Successful!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
             const SizedBox(height: 12),
             const Text('Your consultation is confirmed. Please join the waiting room 5 mins early.', textAlign: TextAlign.center),
             const SizedBox(height: 32),
             GradientButton(
               label: 'Go to Waiting Room',
               onPressed: () {
                 Navigator.pop(context); // Close dialog
                 context.push('/telemedicine/waiting-room');
               },
             ),
          ],
        ),
      ),
    );
  }
}
