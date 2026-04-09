import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class AppointmentsHomeScreen extends StatefulWidget {
  const AppointmentsHomeScreen({super.key});

  @override
  State<AppointmentsHomeScreen> createState() => _AppointmentsHomeScreenState();
}

class _AppointmentsHomeScreenState extends State<AppointmentsHomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Your Appointments',
        showBack: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: GradientButton(
              label: 'Book New Appointment',
              icon: Icons.add_rounded,
              onPressed: () => context.push('/appointments/book/step1'),
            ),
          ),
          const SizedBox(height: 12),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAppointmentList('upcoming'),
                _buildAppointmentList('past'),
                _buildAppointmentList('cancelled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(String status) {
    final appointments = mockAppointments.where((a) => a.status == status).toList();

    if (appointments.isEmpty) {
      return EmptyState(
        icon: _getEmptyIcon(status),
        title: 'No ${status.capitalize()} Visits',
        message: 'You don\'t have any ${status} appointments at the moment.',
        actionLabel: status == 'upcoming' ? 'Book Now' : null,
        onAction: status == 'upcoming' ? () => context.push('/appointments/book/step1') : null,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final appt = appointments[index];
        return _AppointmentCard(appointment: appt);
      },
    );
  }

  IconData _getEmptyIcon(String status) {
    switch (status) {
      case 'upcoming': return Icons.calendar_today_rounded;
      case 'past': return Icons.history_rounded;
      case 'cancelled': return Icons.event_busy_rounded;
      default: return Icons.event_rounded;
    }
  }
}

class _AppointmentCard extends StatelessWidget {
  final MockAppointment appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final isUpcoming = appointment.status == 'upcoming';

    return GlassCard(
      onTap: () => context.push('/appointments/detail/${appointment.id}'),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarCircle(initials: appointment.doctorAvatar, size: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.doctorName, style: Theme.of(context).textTheme.titleMedium),
                    Text(appointment.doctorSpecialty, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              StatusBadge(
                label: appointment.type == 'in-person' ? 'In-Person' : 'Telemedicine',
                color: appointment.type == 'in-person' ? AppColors.primary : AppColors.secondary,
                fontSize: 10,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const TealDivider(),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoColumn(context, 'Date & Time', '${_formatDate(appointment.dateTime)} • ${_formatTime(appointment.dateTime)}'),
              const SizedBox(width: 16),
              _buildInfoColumn(context, 'Facility', appointment.facility),
            ],
          ),
          if (isUpcoming) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.push('/appointments/reschedule'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: Size.zero,
                      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Reschedule'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.push('/appointments/detail/${appointment.id}'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: Size.zero,
                      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    child: Text(appointment.type == 'telemedicine' ? 'Join Call' : 'Details'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    // Simplified formatter
    return '${dt.day} ${_getMonth(dt.month)} ${dt.year}';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:00 $ampm';
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

extension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
