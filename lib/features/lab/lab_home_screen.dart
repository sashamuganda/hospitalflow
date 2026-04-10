import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class LabHomeScreen extends StatelessWidget {
  const LabHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Laboratory',
      icon: Icons.science_rounded,
    );
  }
}
