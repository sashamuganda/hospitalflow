import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class ShareRecordsScreen extends StatefulWidget {
  const ShareRecordsScreen({super.key});

  @override
  State<ShareRecordsScreen> createState() => _ShareRecordsScreenState();
}

class _ShareRecordsScreenState extends State<ShareRecordsScreen> {
  final List<String> _selectedItems = [];
  String? _selectedDuration = '7 Days';

  final List<Map<String, String>> _shareableItems = [
    {'id': '1', 'title': 'Full Visit History', 'category': 'Visits'},
    {'id': '2', 'title': 'All Lab Results', 'category': 'Labs'},
    {'id': '3', 'title': 'Current Prescriptions', 'category': 'Meds'},
    {'id': '4', 'title': 'Chronic Conditions', 'category': 'Diagnoses'},
    {'id': '5', 'title': 'Imaging Reports', 'category': 'Imaging'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Share Records'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Control Your Data',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Select the records you want to share and choose how long the recipient has access.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Text('1. Select Records to Share', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            ..._shareableItems.map((item) {
              final isSelected = _selectedItems.contains(item['id']);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedItems.remove(item['id']);
                      } else {
                        _selectedItems.add(item['id']!);
                      }
                    });
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderColor: isSelected ? AppColors.primary : AppColors.divider,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (_) {
                          setState(() {
                            if (isSelected) {
                              _selectedItems.remove(item['id']);
                            } else {
                              _selectedItems.add(item['id']!);
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text(item['category']!, style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 32),
            Text('2. Recipient', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search doctor or facility name...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: 32),
            Text('3. Access Duration', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: ['One-time', '7 Days', '30 Days', 'Indefinite'].map((d) {
                final isSelected = _selectedDuration == d;
                return ChoiceChip(
                  label: Text(d),
                  selected: isSelected,
                  onSelected: (val) => setState(() => _selectedDuration = val ? d : null),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.background : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Generate Sharing Link',
              onPressed: _selectedItems.isNotEmpty ? () {} : () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
