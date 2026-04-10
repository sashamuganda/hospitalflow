import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class WardOverviewScreen extends StatefulWidget {
  const WardOverviewScreen({super.key});

  @override
  State<WardOverviewScreen> createState() => _WardOverviewScreenState();
}

class _WardOverviewScreenState extends State<WardOverviewScreen> {
  Ward _selectedWard = mockWards.first;

  List<InpatientBed> get _beds => mockBeds.where((b) => b.wardId == _selectedWard.id).toList();

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
                    Expanded(child: Text('Ward Management', style: Theme.of(context).textTheme.headlineMedium)),
                    IconButton(
                      icon: const Icon(Icons.person_add_rounded, color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // KPIs
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _KpiSummaryCard(title: 'Total Capacity', value: '${_selectedWard.totalBeds}', icon: Icons.bed_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    _KpiSummaryCard(title: 'Occupancy', value: '${_selectedWard.occupancyPercent.toInt()}%', icon: Icons.pie_chart_rounded, color: AppColors.secondary),
                    const SizedBox(width: 12),
                    _KpiSummaryCard(title: 'Available', value: '${_selectedWard.totalBeds - _selectedWard.occupiedBeds}', icon: Icons.check_circle_outline_rounded, color: AppColors.success),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Ward Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: mockWards.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final w = mockWards[i];
                      final isActive = w.id == _selectedWard.id;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedWard = w),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.surfaceLight : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isActive ? AppColors.primary : AppColors.divider),
                          ),
                          child: Text(w.name,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter',
                              color: isActive ? AppColors.textPrimary : AppColors.textSecondary)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Legend
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LegendItem(label: 'Occupied', color: BedStatus.occupied.color),
                    const SizedBox(width: 16),
                    _LegendItem(label: 'Empty', color: BedStatus.empty.color),
                    const SizedBox(width: 16),
                    _LegendItem(label: 'Cleaning', color: BedStatus.cleaning.color),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Bed Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _beds.length,
                  itemBuilder: (context, i) => _BedCard(bed: _beds[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiSummaryCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontFamily: 'Inter')),
            ],
          ),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: 'Inter')),
      ],
    );
  }
}

class _BedCard extends StatelessWidget {
  final InpatientBed bed;
  const _BedCard({required this.bed});

  @override
  Widget build(BuildContext context) {
    final isOccupied = bed.status == BedStatus.occupied;
    final isCleaning = bed.status == BedStatus.cleaning;
    
    return GestureDetector(
      onTap: () {
        if (!isOccupied) return;
        _showBedOptions(context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isOccupied ? bed.status.color.withOpacity(0.15) : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isOccupied ? bed.status.color : (isCleaning ? bed.status.color.withOpacity(0.5) : AppColors.divider),
            width: isOccupied ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8, left: 8,
              child: Text(bed.bedNumber,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary, fontFamily: 'Inter')),
            ),
            Center(
              child: isOccupied 
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvatarCircle(initials: bed.patientInitials, size: 40),
                        const SizedBox(height: 6),
                        Text(bed.patientName ?? '', 
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                          textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    )
                  : Icon(Icons.bed_rounded, size: 36, 
                      color: isCleaning ? bed.status.color : AppColors.textMuted.withOpacity(0.3)),
            ),
            if (isCleaning)
              const Positioned(
                bottom: 8, right: 8,
                child: Icon(Icons.cleaning_services_rounded, size: 14, color: AppColors.warning),
              ),
          ],
        ),
      ),
    );
  }

  void _showBedOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarCircle(initials: bed.patientInitials, size: 50),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bed.patientName ?? '', style: Theme.of(context).textTheme.titleMedium),
                      Text('Bed ${bed.bedNumber}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.monitor_heart_rounded, color: AppColors.secondary),
              title: const Text('Add Vitals', style: TextStyle(color: AppColors.textPrimary)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: AppColors.surfaceLight,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.note_add_rounded, color: AppColors.primary),
              title: const Text('Ward Round Note', style: TextStyle(color: AppColors.textPrimary)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: AppColors.surfaceLight,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.transfer_within_a_station_rounded, color: AppColors.warning),
              title: const Text('Transfer / Discharge', style: TextStyle(color: AppColors.textPrimary)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: AppColors.surfaceLight,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
