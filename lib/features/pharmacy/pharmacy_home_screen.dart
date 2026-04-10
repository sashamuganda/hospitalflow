import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class PharmacyHomeScreen extends StatelessWidget {
  const PharmacyHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Pharmacy',
      icon: Icons.medication_rounded,
    );
  }
}
