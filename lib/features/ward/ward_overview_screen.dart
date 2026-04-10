import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class WardOverviewScreen extends StatelessWidget {
  const WardOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Ward Management',
      icon: Icons.bed_rounded,
    );
  }
}
