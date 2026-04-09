import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class BookStep4Screen extends StatefulWidget {
  const BookStep4Screen({super.key});

  @override
  State<BookStep4Screen> createState() => _BookStep4ScreenState();
}

class _BookStep4ScreenState extends State<BookStep4Screen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;

  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Select Date & Time'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Step 4 of 5',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Pick a Slot',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(8),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 90)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedTime = null; // Reset time when date changes
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  markerDecoration: BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                  defaultTextStyle: TextStyle(color: AppColors.textPrimary),
                  weekendTextStyle: TextStyle(color: AppColors.textSecondary),
                  outsideTextStyle: TextStyle(color: AppColors.textMuted),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primary),
                  rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Available Times',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _timeSlots.map((time) {
                final isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = time),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 72) / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.divider,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Continue',
              onPressed: _selectedTime != null
                  ? () => context.push('/appointments/book/step5')
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a time slot.')),
                      );
                    },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
