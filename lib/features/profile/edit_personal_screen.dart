import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class EditPersonalScreen extends StatelessWidget {
  const EditPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Personal Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Center(
              child: Stack(
                children: [
                  AvatarCircle(initials: 'JD', size: 100),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.camera_alt_rounded, color: AppColors.background, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildField(context, 'Full Name', 'John Doe'),
            const SizedBox(height: 20),
            _buildField(context, 'Date of Birth', '12 May 1984'),
            const SizedBox(height: 20),
            _buildField(context, 'Email Address', 'john.doe@example.com'),
            const SizedBox(height: 20),
            _buildField(context, 'Phone Number', '+234 802 345 6789'),
            const SizedBox(height: 20),
            _buildField(context, 'Residential Address', '12, Awolowo Way, Ikoyi, Lagos'),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Save Changes',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }
}
