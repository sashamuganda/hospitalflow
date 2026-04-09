import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class WomensHealthScreen extends StatefulWidget {
  const WomensHealthScreen({super.key});

  @override
  State<WomensHealthScreen> createState() => _WomensHealthScreenState();
}

class _WomensHealthScreenState extends State<WomensHealthScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Women\'s Health'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCycleStatus(context),
            const SizedBox(height: 24),
            Text('Cycle Calendar', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildCalendar(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Hormonal Symptoms'),
            const SizedBox(height: 12),
            _buildSymptomLog(context),
            const SizedBox(height: 32),
            _buildFertilityInsight(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleStatus(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      gradient: AppColors.violetGradient.withOpacity(0.15) as Gradient?,
      borderColor: AppColors.secondary.withOpacity(0.3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.water_drop_rounded, color: AppColors.secondary, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Period in 4 days', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.secondary)),
                Text('Cycle Day 24 • Follicular Phase', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                const LinearProgressIndicator(
                  value: 0.85,
                  color: AppColors.secondary,
                  backgroundColor: AppColors.divider,
                  minHeight: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(8),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 60)),
        lastDay: DateTime.now().add(const Duration(days: 60)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
          markerDecoration: BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
          rangeHighlightColor: AppColors.secondary,
        ),
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      ),
    );
  }

  Widget _buildSymptomLog(BuildContext context) {
    final symptoms = ['Cramps', 'Bloating', 'Mood Swings', 'Headache', 'Acne', 'Fatigue'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: symptoms.map((s) => FilterChip(
        label: Text(s, style: const TextStyle(fontSize: 12)),
        selected: false,
        onSelected: (val) {},
        backgroundColor: AppColors.surface,
        side: BorderSide(color: AppColors.divider),
      )).toList(),
    );
  }

  Widget _buildFertilityInsight(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: Colors.amber, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fertility Window', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Your high-fertility window is estimated to begin in 10 days.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
