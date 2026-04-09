import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  bool _cameraOn = true;
  bool _micOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Waiting Room'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildVideoPreview(context),
            const SizedBox(height: 32),
            _buildInfoCard(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Pre-Consultation Checklist'),
            const SizedBox(height: 12),
            _buildChecklist(context),
            const Spacer(),
            GradientButton(
              label: 'Join Consultation',
              onPressed: () => context.push('/telemedicine/call'),
            ),
            const SizedBox(height: 12),
            const Text(
              'The doctor will join as soon as they are ready.',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_cameraOn)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_rounded, size: 80, color: AppColors.textMuted),
                SizedBox(height: 8),
                Text('Camera Preview Active', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            )
          else
            const Icon(Icons.videocam_off_rounded, size: 64, color: AppColors.error),
          Positioned(
            bottom: 16,
            child: Row(
              children: [
                _buildControl(Icons.videocam_rounded, Icons.videocam_off_rounded, _cameraOn, () => setState(() => _cameraOn = !_cameraOn)),
                const SizedBox(width: 16),
                _buildControl(Icons.mic_rounded, Icons.mic_off_rounded, _micOn, () => setState(() => _micOn = !_micOn)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControl(IconData onIcon, IconData offIcon, bool state, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: state ? AppColors.primary.withOpacity(0.8) : AppColors.error.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(state ? onIcon : offIcon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation(AppColors.primary)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Connecting to Provider...', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Avg. wait time: 3 mins', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist(BuildContext context) {
    return Column(
      children: [
        _buildCheckItem(context, 'Stable internet connection', true),
        _buildCheckItem(context, 'Camera & Microphone access', true),
        _buildCheckItem(context, 'Quiet environment', false),
      ],
    );
  }

  Widget _buildCheckItem(BuildContext context, String label, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(checked ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: checked ? AppColors.success : AppColors.divider, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
