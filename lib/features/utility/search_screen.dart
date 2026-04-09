import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          autofocus: true,
          onChanged: (val) => setState(() => _query = val),
          decoration: const InputDecoration(
            hintText: 'Search anything...',
            border: InputBorder.none,
            filled: false,
          ),
        ),
      ),
      body: _query.isEmpty ? _buildSuggestions() : _buildSearchResults(),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildRecentItem('Dr. Ngozi Adeyemi'),
          _buildRecentItem('Amoxicillin'),
          _buildRecentItem('Lab results from Jan'),
          const SizedBox(height: 32),
          const Text('Trending', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: [
              _buildTag('Malaria symptoms'),
              _buildTag('Cardiologists nearby'),
              _buildTag('Health insurance tips'),
              _buildTag('Weight loss'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, size: 18, color: AppColors.textMuted),
          const SizedBox(width: 12),
          Text(text),
          const Spacer(),
          const Icon(Icons.close_rounded, size: 16, color: AppColors.textMuted),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildSearchResults() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildResultCategory('Specialists', [
          _buildResultItem(Icons.person_rounded, 'Dr. Ngozi Adeyemi', 'Cardiology', '/telemedicine/doctor/1'),
        ]),
        const SizedBox(height: 24),
        _buildResultCategory('Medications', [
          _buildResultItem(Icons.medication_rounded, 'Amoxicillin 500mg', 'Antibiotic', '/drugs/detail/1'),
          _buildResultItem(Icons.medication_rounded, 'Augmentin 625mg', 'Antibiotic', '/drugs/detail/2'),
        ]),
        const SizedBox(height: 24),
        _buildResultCategory('Medical Records', [
          _buildResultItem(Icons.description_rounded, 'Lab Result - Jan 22', 'Hematology', '/records/lab/1'),
        ]),
      ],
    );
  }

  Widget _buildResultCategory(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildResultItem(IconData icon, String title, String subtitle, String route) {
    return GlassCard(
      onTap: () => context.push(route),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
