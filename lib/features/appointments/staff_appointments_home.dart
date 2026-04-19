import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class StaffAppointmentsHome extends StatefulWidget {
  const StaffAppointmentsHome({super.key});

  @override
  State<StaffAppointmentsHome> createState() => _StaffAppointmentsHomeState();
}

class _StaffAppointmentsHomeState extends State<StaffAppointmentsHome> {
  String _activeFilter = 'All';

  List<StaffAppointment> get _filtered {
    if (_activeFilter == 'All') return mockStaffAppointments;
    return mockStaffAppointments.where((a) => a.type == _activeFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Performance optimization: Cache filtered results in a local variable to avoid
    // redundant filtering and O(N*M) complexity during build and list rendering.
    final appointments = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_rounded),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Appointments',
                            style: Theme.of(context).textTheme.headlineMedium)),
                    IconButton(
                      icon: const Icon(Icons.calendar_month_rounded,
                          color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Filters
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: ['All', 'OPD', 'Follow-up', 'Telemedicine']
                      .map((t) => _FilterChip(
                            label: t,
                            isActive: _activeFilter == t,
                            onTap: () => setState(() => _activeFilter = t),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  itemCount: appointments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      _AppointmentCard(appointment: appointments[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isActive ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final StaffAppointment appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: appointment.status.color.withOpacity(0.3),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(_formatTime(appointment.dateTime),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      fontFamily: 'Inter')),
              const SizedBox(width: 10),
              StatusBadge(
                  label: appointment.status.label,
                  color: appointment.status.color,
                  fontSize: 10),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(appointment.type,
                    style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        fontFamily: 'Inter')),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AvatarCircle(
                  initials: _getInitials(appointment.patientName), size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.patientName,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text('With: ${appointment.doctorName}',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (appointment.room != null) ...[
                const Icon(Icons.room_rounded,
                    size: 14, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(appointment.room!,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        fontFamily: 'Inter')),
              ] else ...[
                const Icon(Icons.video_camera_front_rounded,
                    size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                const Text('Online',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontFamily: 'Inter')),
              ],
              const Spacer(),
              if (appointment.status == AppointmentStatus.pending)
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('Confirm',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime d) {
    final h = d.hour == 0 ? 12 : (d.hour > 12 ? d.hour - 12 : d.hour);
    final m = d.minute.toString().padLeft(2, '0');
    final p = d.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $p';
  }

  String _getInitials(String name) {
    final p = name.split(' ');
    return p.length >= 2 ? '${p[0][0]}${p[1][0]}' : name[0];
  }
}
