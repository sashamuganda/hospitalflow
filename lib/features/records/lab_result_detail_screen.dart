import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class LabResultDetailScreen extends StatelessWidget {
  final String resultId;

  const LabResultDetailScreen({super.key, required this.resultId});

  @override
  Widget build(BuildContext context) {
    // Mock data fetch
    final result = mockLabResults.firstWhere((r) => r.id == resultId, orElse: () => mockLabResults[0]);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Test Details',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded, size: 20)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.file_download_outlined, size: 22)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.testName, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Requested by ${result.requestingDoctor} • Jan 15, 2026',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 32),
            _buildInterpretationCard(context, result),
            const SizedBox(height: 32),
            Text('Breakdown', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildMarkersTable(context, result),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Discuss with Doctor',
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInterpretationCard(BuildContext context, MockLabResult result) {
    String interpretation;
    if (result.status == 'borderline') {
      interpretation = 'Your hemoglobin is slightly below the normal range. This may be related to your reported fatigue. Your doctor may discuss iron supplementation with you at your next visit.';
    } else if (result.status == 'critical') {
      interpretation = 'Your results show values that require immediate medical attention. Please contact your doctor or visit the nearest emergency room.';
    } else {
      interpretation = 'All markers in this panel are within the normal reference range. No action is required at this time.';
    }

    final color = _getStatusColor(result.status);

    return GlassCard(
      borderColor: color.withOpacity(0.3),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_outlined, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                'Interpretation',
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            interpretation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkersTable(BuildContext context, MockLabResult result) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text('Marker', style: Theme.of(context).textTheme.labelSmall)),
              Expanded(child: Text('Result', style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center)),
              Expanded(flex: 2, child: Text('Ref. Range', style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.right)),
            ],
          ),
        ),
        const TealDivider(),
        const SizedBox(height: 8),
        ...result.markers.map((marker) => _buildMarkerRow(context, marker)),
      ],
    );
  }

  Widget _buildMarkerRow(BuildContext context, MockLabMarker marker) {
    final color = _getStatusColor(marker.status);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(marker.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                if (marker.status != 'normal')
                  Text(marker.status.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '${marker.value} ${marker.unit}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: marker.status == 'normal' ? AppColors.textPrimary : color),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              marker.referenceRange,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'normal': return AppColors.success;
      case 'borderline': return AppColors.warning;
      case 'critical': return AppColors.error;
      default: return AppColors.textMuted;
    }
  }
}
