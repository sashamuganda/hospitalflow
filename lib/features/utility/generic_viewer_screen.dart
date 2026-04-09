import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class GenericViewerScreen extends StatelessWidget {
  final String title;
  final String content;

  const GenericViewerScreen({
    super.key,
    this.title = 'Document Viewer',
    this.content = 'Loading content...',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: GlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                 'Last Updated: April 9, 2026',
                 style: TextStyle(fontSize: 12, color: AppColors.textMuted, fontStyle: FontStyle.italic),
               ),
               const SizedBox(height: 24),
               Text(
                 content,
                 style: const TextStyle(height: 1.6, fontSize: 14, color: AppColors.textPrimary),
               ),
               const SizedBox(height: 48),
               Center(
                 child: OutlinedButton(
                   onPressed: () => Navigator.pop(context),
                   child: const Text('Close Document'),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
