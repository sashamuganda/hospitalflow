import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English (UK)';

  final List<Map<String, String>> _languages = [
    {'name': 'English (UK)', 'native': 'English'},
    {'name': 'English (US)', 'native': 'English'},
    {'name': 'Yoruba', 'native': 'èdè Yorùbá'},
    {'name': 'Igbo', 'native': 'Asụsụ Igbo'},
    {'name': 'Hausa', 'native': 'Harshen Hausa'},
    {'name': 'Pidgin', 'native': 'Naija Pidgin'},
    {'name': 'French', 'native': 'Français'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'App Language'),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: _languages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = _selectedLanguage == lang['name'];
          return GlassCard(
            onTap: () => setState(() => _selectedLanguage = lang['name']!),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            borderColor: isSelected ? AppColors.primary : AppColors.divider,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(lang['native']!, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
