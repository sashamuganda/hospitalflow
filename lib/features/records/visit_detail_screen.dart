import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class VisitDetailScreen extends StatelessWidget {
  final String visitId;

  const VisitDetailScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Clinic Visit Detail'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVisitHeader(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Diagnosis'),
            const SizedBox(height: 12),
            const GlassCard(
              padding: EdgeInsets.all(16),
              child: Text(
                'Acute Pharyngitis (J02.9)\nPatient presented with sore throat, fever (101.4F), and difficulty swallowing for 3 days.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Treatment Plan'),
            const SizedBox(height: 12),
            _buildTreatmentPlan(),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Prescribed Medications'),
            const SizedBox(height: 12),
            _buildPrescriptionItem('Amoxicillin 500mg', '1 caps 3x daily for 7 days'),
            const SizedBox(height: 12),
            _buildPrescriptionItem('Paracetamol 500mg', '2 tabs as needed for pain'),
            const SizedBox(height: 40),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text('Export Visit Summary'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitHeader(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.local_hospital_rounded, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('General Consultation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Text('Sept 12, 2025 • Dr. Yusuf Ahmed', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentPlan() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPlanStep(Icons.check_circle_outline_rounded, 'Rest for 48 hours'),
          const TealDivider(),
          _buildPlanStep(Icons.check_circle_outline_rounded, 'Increase fluid intake'),
          const TealDivider(),
          _buildPlanStep(Icons.check_circle_outline_rounded, 'Warm salt water gargles'),
          const TealDivider(),
          _buildPlanStep(Icons.event_note_rounded, 'Follow up if symptoms persist after 5 days'),
        ],
      ),
    );
  }

  Widget _buildPlanStep(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildPrescriptionItem(String name, String dosage) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.medication_rounded, color: AppColors.secondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(dosage, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
