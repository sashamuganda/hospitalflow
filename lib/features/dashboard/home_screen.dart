import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/app_state.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using context.select to only rebuild when currentUser or selectedRole changes.
    // This avoids unnecessary rebuilds when other parts of AppState (like navItems) change.
    final user = context.select<AppState, StaffMember?>((s) => s.currentUser);
    final role = context.select<AppState, StaffRole>((s) => s.selectedRole);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, user, role),
                  const SizedBox(height: 24),
                  if (role == StaffRole.admin) ...[
                    _buildAdminKPIs(context),
                    const SizedBox(height: 24),
                    _buildDepartmentStatus(context),
                    const SizedBox(height: 24),
                    _buildRecentActivity(context),
                  ] else ...[
                    _buildStaffKPIs(context, role),
                    const SizedBox(height: 24),
                    _buildUrgentAlerts(context),
                    const SizedBox(height: 24),
                    _buildTodaySchedule(context),
                    const SizedBox(height: 24),
                    _buildQuickActions(context, role),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StaffMember? user, StaffRole role) {
    final greeting = _greeting();
    final name = user?.displayName ?? role.displayName;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$greeting,', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(name, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 6),
              RoleBadge(label: role.displayName),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () => context.push('/notifications'),
              icon: const Icon(Icons.notifications_outlined, size: 28, color: AppColors.textPrimary),
            ),
            Positioned(
              right: 8, top: 8,
              child: Container(
                width: 18, height: 18,
                decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                child: const Center(
                  child: Text('3', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Inter')),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        AvatarCircle(initials: user?.avatarInitials ?? 'DR', size: 44),
      ],
    );
  }

  // Admin-specific KPIs
  Widget _buildAdminKPIs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Hospital Today'),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            KpiCard(label: 'OPD Patients', value: '${mockKPIs.todayOPDCount}',
              subtitle: '+12 from yesterday', icon: Icons.people_alt_rounded, color: AppColors.primary),
            KpiCard(label: 'IPD Occupancy', value: '${mockKPIs.currentIPDOccupancy}/${mockKPIs.totalBeds}',
              subtitle: '${mockKPIs.ipdOccupancyPercent.toInt()}% utilisation',
              icon: Icons.bed_rounded, color: AppColors.secondary),
            KpiCard(label: 'Staff On Duty', value: '${mockKPIs.staffOnDuty}',
              icon: Icons.groups_rounded, color: AppColors.success),
            KpiCard(label: 'Avg Wait Time', value: '${mockKPIs.avgWaitTimeMinutes.toInt()} min',
              icon: Icons.timer_outlined, color: AppColors.warning),
          ],
        ),
      ],
    );
  }

  // Staff-role KPIs
  Widget _buildStaffKPIs(BuildContext context, StaffRole role) {
    final queue = mockQueue.where((q) => q.status == QueueStatus.waiting).length;
    final immediate = mockQueue.where((q) => q.triageLevel == TriageLevel.immediate).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'At a Glance'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: KpiCard(
                label: 'Waiting Patients',
                value: '$queue',
                subtitle: '$immediate immediate',
                icon: Icons.people_alt_rounded,
                color: immediate > 0 ? AppColors.error : AppColors.primary,
                onTap: () => context.push('/queue'),
              ),
            ),
            const SizedBox(width: 12),
            if (role == StaffRole.doctor || role == StaffRole.receptionist)
              Expanded(
                child: KpiCard(
                  label: "Today's Schedule",
                  value: '${mockStaffAppointments.length}',
                  subtitle: '${mockStaffAppointments.where((a) => a.status == AppointmentStatus.confirmed).length} confirmed',
                  icon: Icons.calendar_today_rounded,
                  color: AppColors.secondary,
                  onTap: () => context.push('/appointments'),
                ),
              )
            else
              Expanded(
                child: KpiCard(
                  label: 'Pending Labs',
                  value: '${mockKPIs.pendingLabResults}',
                  icon: Icons.science_rounded,
                  color: AppColors.secondary,
                  onTap: () => context.push('/lab'),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildUrgentAlerts(BuildContext context) {
    final criticals = mockQueue.where((q) =>
      q.triageLevel == TriageLevel.immediate || q.triageLevel == TriageLevel.urgent).take(2).toList();
    if (criticals.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: '⚡ Urgent Alerts',
          actionLabel: 'View Queue',
          onAction: () => context.push('/queue'),
        ),
        const SizedBox(height: 12),
        ...criticals.map((p) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            borderColor: p.triageLevel.color.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: () => context.push('/queue/triage/${p.id}'),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: p.triageLevel.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('Q${p.queueNumber}',
                      style: TextStyle(color: p.triageLevel.color,
                        fontWeight: FontWeight.w800, fontSize: 13, fontFamily: 'Inter')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(p.patientName, style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(width: 8),
                        TriageChip(level: p.triageLevel, compact: true),
                      ]),
                      const SizedBox(height: 4),
                      Text(p.chiefComplaint, style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Text('${p.waitMinutes}m',
                  style: TextStyle(color: p.triageLevel.color,
                    fontWeight: FontWeight.w700, fontSize: 13, fontFamily: 'Inter')),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTodaySchedule(BuildContext context) {
    final apts = mockStaffAppointments.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Today's Schedule",
          actionLabel: 'Full Schedule',
          onAction: () => context.push('/appointments'),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: apts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final a = apts[i];
            final hour = a.dateTime.hour.toString().padLeft(2, '0');
            final min = a.dateTime.minute.toString().padLeft(2, '0');
            return GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    child: Text('$hour:$min',
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700,
                        fontSize: 14, fontFamily: 'Inter')),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.patientName, style: Theme.of(context).textTheme.titleSmall),
                        Text('${a.type}${a.room != null ? ' · ${a.room}' : ''}',
                          style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  StatusBadge(label: a.status.label, color: a.status.color, fontSize: 11),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, StaffRole role) {
    List<Map<String, dynamic>> actions = [];
    if (role == StaffRole.doctor) {
      actions = [
        {'icon': Icons.people_alt_rounded, 'label': 'Queue', 'route': '/queue'},
        {'icon': Icons.folder_shared_rounded, 'label': 'EMR', 'route': '/emr'},
        {'icon': Icons.video_call_rounded, 'label': 'Telemedicine', 'route': '/telemedicine'},
        {'icon': Icons.science_rounded, 'label': 'Lab Orders', 'route': '/emr/lab-order'},
      ];
    } else if (role == StaffRole.nurse) {
      actions = [
        {'icon': Icons.people_alt_rounded, 'label': 'Queue', 'route': '/queue'},
        {'icon': Icons.monitor_heart_rounded, 'label': 'Vitals', 'route': '/emr/vitals'},
        {'icon': Icons.bed_rounded, 'label': 'Ward', 'route': '/ward'},
        {'icon': Icons.science_rounded, 'label': 'Lab', 'route': '/lab'},
      ];
    } else {
      actions = [
        {'icon': Icons.people_alt_rounded, 'label': 'Queue', 'route': '/queue'},
        {'icon': Icons.calendar_month_rounded, 'label': 'Bookings', 'route': '/appointments'},
        {'icon': Icons.person_search_rounded, 'label': 'Patients', 'route': '/emr'},
        {'icon': Icons.bar_chart_rounded, 'label': 'Reports', 'route': '/analytics'},
      ];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Quick Actions'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.map((a) => GestureDetector(
            onTap: () => context.push(a['route'] as String),
            child: Column(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Icon(a['icon'] as IconData, color: AppColors.primary, size: 28),
                ),
                const SizedBox(height: 8),
                Text(a['label'] as String,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary, fontFamily: 'Inter')),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDepartmentStatus(BuildContext context) {
    const depts = [
      {'dept': 'Emergency', 'patients': 4, 'color': AppColors.error},
      {'dept': 'OPD - Internal Med', 'patients': 18, 'color': AppColors.primary},
      {'dept': 'Pediatrics', 'patients': 9, 'color': AppColors.secondary},
      {'dept': 'Maternity', 'patients': 6, 'color': AppColors.success},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Department Load'),
        const SizedBox(height: 12),
        ...depts.map((d) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(width: 8, height: 8,
                  decoration: BoxDecoration(color: d['color'] as Color, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Expanded(child: Text(d['dept'] as String, style: Theme.of(context).textTheme.bodyMedium)),
                Text('${d['patients']} patients',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primary, fontFamily: 'Inter')),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Recent Activity',
          actionLabel: 'All Alerts',
          onAction: () => context.push('/notifications'),
        ),
        const SizedBox(height: 12),
        ...mockNotifications.take(3).map((n) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            borderColor: n.isRead ? null : n.typeColor.withOpacity(0.3),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: n.typeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(n.typeIcon, color: n.typeColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.title, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 2),
                      Text(n.message, style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
