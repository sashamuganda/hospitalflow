import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class TeleHomeStaffScreen extends StatefulWidget {
  const TeleHomeStaffScreen({super.key});

  @override
  State<TeleHomeStaffScreen> createState() => _TeleHomeStaffScreenState();
}

class _TeleHomeStaffScreenState extends State<TeleHomeStaffScreen> {
  List<StaffAppointment> get _teleAppointments => 
      mockStaffAppointments.where((a) => a.type == 'Telemedicine').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(child: Text('Telemedicine Console', style: Theme.of(context).textTheme.headlineMedium)),
                    IconButton(icon: const Icon(Icons.settings_rounded, color: AppColors.primary), onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Active Call Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.video_camera_front_rounded, color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Next Consultation', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontFamily: 'Inter')),
                            const SizedBox(height: 4),
                            Text('Sarah Ochieng', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primary)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Join Call'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Waiting Room
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Virtual Waiting Room', style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: _teleAppointments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final apt = _teleAppointments[i];
                    return GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          AvatarCircle(initials: apt.patientName.isNotEmpty ? apt.patientName[0] : '?', size: 48),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(apt.patientName, style: Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 4),
                                StatusBadge(label: apt.status.label, color: apt.status.color, fontSize: 10),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${apt.dateTime.hour}:${apt.dateTime.minute.toString().padLeft(2, '0')}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              const Icon(Icons.videocam_rounded, color: AppColors.primary, size: 20),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
