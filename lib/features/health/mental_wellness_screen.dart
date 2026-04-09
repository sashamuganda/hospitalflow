import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class MentalWellnessScreen extends StatefulWidget {
  const MentalWellnessScreen({super.key});

  @override
  State<MentalWellnessScreen> createState() => _MentalWellnessScreenState();
}

class _MentalWellnessScreenState extends State<MentalWellnessScreen> {
  int _selectedMood = -1;
  double _stressLevel = 3.0;

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😔', 'label': 'Sad'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '🙂', 'label': 'Good'},
    {'emoji': '😄', 'label': 'Great'},
    {'emoji': '🤩', 'label': 'Awesome'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Mental Wellness'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How are you feeling today?', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _moods.asMap().entries.map((e) {
                final index = e.key;
                final mood = e.value;
                final isSelected = _selectedMood == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = index),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(mood['emoji'], style: const TextStyle(fontSize: 28)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood['label'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Text('Stress Level', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'On a scale of 1 to 10, how stressed are you?',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Slider(
              value: _stressLevel,
              min: 1,
              max: 10,
              divisions: 9,
              label: _stressLevel.toInt().toString(),
              activeColor: _stressLevel > 7 ? AppColors.error : (_stressLevel > 4 ? AppColors.warning : AppColors.success),
              onChanged: (val) => setState(() => _stressLevel = val),
            ),
            const SizedBox(height: 40),
            Text('Gratitude Journal', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            const GlassCard(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are 3 things you are thankful for today?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: AppColors.secondary),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Start typing...',
                      border: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Save Wellness Log',
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
