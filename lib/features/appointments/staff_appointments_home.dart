import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class StaffAppointmentsHome extends StatelessWidget {
  const StaffAppointmentsHome({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      moduleName: 'Appointments',
      icon: Icons.calendar_month_rounded,
    );
  }
}
