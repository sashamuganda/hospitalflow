import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class TeleHomeStaff extends StatelessWidget {
  const TeleHomeStaff({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Telemedicine',
      icon: Icons.video_call_rounded,
    );
  }
}
