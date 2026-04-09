import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SymptomEntryScreen extends StatefulWidget {
  const SymptomEntryScreen({super.key});

  @override
  State<SymptomEntryScreen> createState() => _SymptomEntryScreenState();
}

class _SymptomEntryScreenState extends State<SymptomEntryScreen> {
  final List<String> _selectedRegions = [];

  final List<Map<String, dynamic>> _regions = [
    {'id': 'head', 'label': 'Head', 'top': 0.05, 'left': 0.42, 'width': 0.16, 'height': 0.12},
    {'id': 'chest', 'label': 'Chest', 'top': 0.22, 'left': 0.35, 'width': 0.3, 'height': 0.15},
    {'id': 'abdomen', 'label': 'Abdomen', 'top': 0.38, 'left': 0.35, 'width': 0.3, 'height': 0.12},
    {'id': 'arms', 'label': 'Arms', 'top': 0.25, 'left': 0.15, 'width': 0.15, 'height': 0.3},
    {'id': 'arms_r', 'label': 'Arms', 'top': 0.25, 'left': 0.7, 'width': 0.15, 'height': 0.3},
    {'id': 'legs', 'label': 'Legs', 'top': 0.55, 'left': 0.3, 'width': 0.18, 'height': 0.4},
    {'id': 'legs_r', 'label': 'Legs', 'top': 0.55, 'left': 0.52, 'width': 0.18, 'height': 0.4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Symptom Checker'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Where is the discomfort?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Select the affected body areas to start the AI triage.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 0.6,
                  child: Stack(
                    children: [
                      // Simple Human Silhouette Placeholder (Custom Painter or Image)
                      Center(
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.person_rounded, size: 400, color: AppColors.textPrimary),
                        ),
                      ),
                      // Hotspots
                      ..._regions.map((region) => _buildHotspot(region)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_selectedRegions.isNotEmpty)
              Text(
                'Selected: ${_selectedRegions.join(", ")}',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Or search symptoms (e.g. Fever, Cough)',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              label: 'Continue to AI Chat',
              onPressed: _selectedRegions.isNotEmpty
                  ? () => context.push('/symptom-checker/input')
                  : () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHotspot(Map<String, dynamic> region) {
    final bool isSelected = _selectedRegions.contains(region['label']);

    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final top = region['top'] * constraints.maxHeight;
          final left = region['left'] * constraints.maxWidth;
          final width = region['width'] * constraints.maxWidth;
          final height = region['height'] * constraints.maxHeight;

          return Stack(
            children: [
              Positioned(
                top: top,
                left: left,
                width: width,
                height: height,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedRegions.remove(region['label']);
                      } else {
                        if (!_selectedRegions.contains(region['label'])) {
                          _selectedRegions.add(region['label']);
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.4) : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.primary.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: isSelected ? const Icon(Icons.check_rounded, color: Colors.white, size: 16) : null,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
