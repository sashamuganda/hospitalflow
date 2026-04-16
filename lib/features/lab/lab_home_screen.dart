import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class LabHomeScreen extends StatefulWidget {
  const LabHomeScreen({super.key});

  @override
  State<LabHomeScreen> createState() => _LabHomeScreenState();
}

class _LabHomeScreenState extends State<LabHomeScreen> {
  // Simple order sorting by priority
  List<LabOrder> get _sortedOrders {
    final list = List<LabOrder>.from(mockLabOrders);
    list.sort((a, b) {
      final wA = a.priority.toLowerCase() == 'stat'
          ? 0
          : (a.priority.toLowerCase() == 'urgent' ? 1 : 2);
      final wB = b.priority.toLowerCase() == 'stat'
          ? 0
          : (b.priority.toLowerCase() == 'urgent' ? 1 : 2);
      return wA.compareTo(wB);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text('Laboratory Processing',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: _sortedOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      _LabOrderCard(order: _sortedOrders[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabOrderCard extends StatelessWidget {
  final LabOrder order;

  const _LabOrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: order.priorityColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: order.priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(order.priority.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: order.priorityColor)),
              ),
              const Spacer(),
              Text(order.id,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(order.patientName,
              style: Theme.of(context).textTheme.titleMedium),
          Text('Ordered by ${order.orderedByName}',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: order.tests
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(t,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textPrimary)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceLight,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Process'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Enter Results'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
