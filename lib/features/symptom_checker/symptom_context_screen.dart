import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SymptomContextScreen extends StatefulWidget {
  const SymptomContextScreen({super.key});

  @override
  State<SymptomContextScreen> createState() => _SymptomContextScreenState();
}

class _SymptomContextScreenState extends State<SymptomContextScreen> {
  final List<String> _contexts = [
    'Recent travel (past 30 days)',
    'Close contact with someone ill',
    'Known drug allergies',
    'Currently taking new medications',
    'Smoker / Tobacco use',
    'Under high stress recently',
  ];

  final List<String> _selectedContexts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Health Context'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'One last thing...',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Do any of the following apply to you? This helps the AI provide a more accurate triage.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.separated(
                itemCount: _contexts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ctx = _contexts[index];
                  final isSelected = _selectedContexts.contains(ctx);
                  return GlassCard(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedContexts.remove(ctx);
                        } else {
                          _selectedContexts.add(ctx);
                        }
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    borderColor: isSelected ? AppColors.primary : AppColors.divider,
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: (_) {
                            setState(() {
                              if (isSelected) {
                                _selectedContexts.remove(ctx);
                              } else {
                                _selectedContexts.add(ctx);
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(ctx, style: const TextStyle(fontWeight: FontWeight.w500))),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              label: 'See Triage Results',
              onPressed: () => context.push('/symptom-checker/results'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
