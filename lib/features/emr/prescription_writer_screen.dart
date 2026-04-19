import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class PrescriptionWriterScreen extends StatefulWidget {
  final String patientId;
  const PrescriptionWriterScreen({super.key, required this.patientId});
  @override
  State<PrescriptionWriterScreen> createState() =>
      _PrescriptionWriterScreenState();
}

class _PrescriptionWriterScreenState extends State<PrescriptionWriterScreen> {
  final List<_RxItem> _items = [_RxItem()];
  bool _isSigning = false;
  final _notesCtrl = TextEditingController();

  final _commonDrugs = [
    'Amoxicillin',
    'Metformin',
    'Enalapril',
    'Amlodipine',
    'Metoprolol',
    'Atorvastatin',
    'Omeprazole',
    'Paracetamol',
    'Ibuprofen',
    'Amoxiclav'
  ];

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSign() async {
    setState(() => _isSigning = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _isSigning = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Prescription signed & sent to Pharmacy'),
        backgroundColor: AppColors.success));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Text('Write Prescription',
                          style: Theme.of(context).textTheme.headlineSmall)),
                ]),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Common drugs quick select
                      const Text('Common Drugs',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: _commonDrugs.length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              final last = _items.last;
                              if (last.nameCtrl.text.isEmpty) {
                                last.nameCtrl.text = _commonDrugs[i];
                              } else {
                                setState(() => _items.add(_RxItem()
                                  ..nameCtrl.text = _commonDrugs[i]));
                              }
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.divider)),
                              child: Text(_commonDrugs[i],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                      fontFamily: 'Inter')),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SectionHeader(title: 'Medications'),
                      const SizedBox(height: 12),
                      ..._items.asMap().entries.map((e) => _RxItemCard(
                            item: e.value,
                            index: e.key,
                            onRemove: _items.length > 1
                                ? () => setState(() => _items.removeAt(e.key))
                                : null,
                          )),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () => setState(() => _items.add(_RxItem())),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add Another Drug'),
                      ),
                      const SizedBox(height: 24),
                      const Text('Additional Instructions',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _notesCtrl,
                        maxLines: 3,
                        maxLength: 1000,
                        decoration: const InputDecoration(
                          hintText: 'e.g. Take with food. Avoid alcohol. Return if symptoms worsen...',
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Interaction warning UI
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.warning.withOpacity(0.3))),
                        child: Row(children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: AppColors.warning, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(
                                  'Drug interaction checking is active. Always verify for allergies before signing.',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                      fontFamily: 'Inter'))),
                        ]),
                      ),
                      const SizedBox(height: 28),
                      GradientButton(
                        label: 'Sign & Send to Pharmacy',
                        icon: Icons.send_rounded,
                        isLoading: _isSigning,
                        gradient: AppColors.violetGradient,
                        onPressed: _onSign,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RxItem {
  final nameCtrl = TextEditingController();
  final doseCtrl = TextEditingController();
  String route = 'Oral';
  String frequency = 'Once daily';
  String duration = '7 days';
}

class _RxItemCard extends StatelessWidget {
  final _RxItem item;
  final int index;
  final VoidCallback? onRemove;
  const _RxItemCard({required this.item, required this.index, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(children: [
            Text('Rx ${index + 1}',
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary)),
            const Spacer(),
            if (onRemove != null)
              GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.remove_circle_outline_rounded,
                      color: AppColors.error, size: 20)),
          ]),
          const SizedBox(height: 10),
          TextField(
            controller: item.nameCtrl,
            maxLength: 100,
            decoration: const InputDecoration(
                hintText: 'Drug name',
                counterText: '',
                prefixIcon: Icon(Icons.medication_outlined,
                    color: AppColors.textMuted)),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
                child: TextField(
              controller: item.doseCtrl,
              maxLength: 50,
              decoration: const InputDecoration(
                hintText: 'Dose (e.g. 500mg)',
                counterText: '',
              ),
            )),
            const SizedBox(width: 10),
            Expanded(
                child: _DropdownField(
              value: item.route,
              items: ['Oral', 'IV', 'IM', 'SC', 'Topical', 'Inhaled'],
              label: 'Route',
              onChanged: (_) {},
            )),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
                child: _DropdownField(
              value: item.frequency,
              items: [
                'Once daily',
                'Twice daily',
                'Three times daily',
                'Four times daily',
                'PRN',
                'Weekly'
              ],
              label: 'Frequency',
              onChanged: (_) {},
            )),
            const SizedBox(width: 10),
            Expanded(
                child: _DropdownField(
              value: item.duration,
              items: [
                '3 days',
                '5 days',
                '7 days',
                '10 days',
                '14 days',
                '30 days',
                'Ongoing'
              ],
              label: 'Duration',
              onChanged: (_) {},
            )),
          ]),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final String label;
  final ValueChanged<String?> onChanged;
  const _DropdownField(
      {required this.value,
      required this.items,
      required this.label,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.divider)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: AppColors.surface,
            style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: AppColors.textPrimary),
            items: items
                .map((i) => DropdownMenuItem(
                    value: i, child: Text(i, overflow: TextOverflow.ellipsis)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ]);
  }
}
