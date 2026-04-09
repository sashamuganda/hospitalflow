import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'Jane Doe', 'rel': 'Spouse', 'phone': '+234 802 345 6780', 'primary': true},
      {'name': 'Dr. Marcus Okoro', 'rel': 'Family Physician', 'phone': '+234 803 111 2222', 'primary': false},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Emergency Contacts'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSOSCard(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Contact List'),
            const SizedBox(height: 12),
            ...contacts.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildContactCard(context, c),
            )),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add New Contact'),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.error.withOpacity(0.2), AppColors.error.withOpacity(0.05)],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.emergency_rounded, color: AppColors.error, size: 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick SOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.error)),
                Text(
                  'Holding down the SOS button on home will notify these contacts and share your location.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, Map<String, dynamic> contact) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.surface,
                child: Icon(Icons.person_rounded, color: AppColors.textMuted),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(contact['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        if (contact['primary'] as bool) ...[
                          const SizedBox(width: 8),
                          StatusBadge(label: 'PRIMARY', color: AppColors.primary, fontSize: 8),
                        ],
                      ],
                    ),
                    Text(contact['rel'] as String, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit_rounded, size: 20, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 12),
          const TealDivider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contact['phone'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              const Row(
                children: [
                   Icon(Icons.phone_rounded, color: AppColors.primary, size: 20),
                   SizedBox(width: 16),
                   Icon(Icons.message_rounded, color: AppColors.secondary, size: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
