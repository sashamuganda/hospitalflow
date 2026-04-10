import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class AnalyticsHomeScreen extends StatelessWidget {
  const AnalyticsHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Analytics',
      icon: Icons.bar_chart_rounded,
    );
  }
}
