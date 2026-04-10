import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Settings',
      icon: Icons.settings_rounded,
    );
  }
}
