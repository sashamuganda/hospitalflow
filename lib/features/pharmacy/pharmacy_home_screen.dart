import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({super.key});

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  String _activeTab = 'Pending';

  @override
  Widget build(BuildContext context) {
    // ⚡ Bolt: Cache filtered prescriptions in local variable to avoid O(N^2) complexity in ListView
    final filtered = _activeTab == 'Pending'
        ? mockPharmacyPrescriptions
            .where((p) => p.status == PrescriptionStatus.pending)
            .toList()
        : mockPharmacyPrescriptions
            .where((p) => p.status != PrescriptionStatus.pending)
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text('Pharmacy Queue',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 16),
              // KPI row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: const _KpiCard(
                            title: 'Pending',
                            count: '12',
                            color: AppColors.warning)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: const _KpiCard(
                            title: 'Ready',
                            count: '5',
                            color: AppColors.success)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _TabBtn(
                        label: 'Pending',
                        isActive: _activeTab == 'Pending',
                        onTap: () => setState(() => _activeTab = 'Pending')),
                    const SizedBox(width: 12),
                    _TabBtn(
                        label: 'Processing & Ready',
                        isActive: _activeTab != 'Pending',
                        onTap: () => setState(() => _activeTab = 'Ready')),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      _PrescriptionCard(rx: filtered[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const _KpiCard(
      {required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontFamily: 'Inter')),
          const SizedBox(height: 8),
          Text(count,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontFamily: 'Inter')),
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabBtn(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isActive ? AppColors.primary : AppColors.divider),
          ),
          alignment: Alignment.center,
          child: Text(label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                color:
                    isActive ? AppColors.textPrimary : AppColors.textSecondary,
              )),
        ),
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  final PharmacyPrescription rx;

  const _PrescriptionCard({required this.rx});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(rx.id,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary)),
              const Spacer(),
              StatusBadge(
                  label: rx.status.label, color: rx.status.color, fontSize: 10),
            ],
          ),
          const SizedBox(height: 12),
          Text(rx.patientName, style: Theme.of(context).textTheme.titleMedium),
          Text('Prescribed by ${rx.doctorName}',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 12),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 8),
          ...rx.medications.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.medication_rounded,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(m,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.textPrimary))),
                  ],
                ),
              )),
          if (rx.notes != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      size: 14, color: AppColors.warning),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(rx.notes!,
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.warning))),
                ],
              ),
            ),
          ],
          if (rx.status == PrescriptionStatus.pending) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Start Processing'),
              ),
            ),
          ] else if (rx.status == PrescriptionStatus.processing) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Mark as Dispensed'),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
