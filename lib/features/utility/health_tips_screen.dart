import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class HealthTipsScreen extends StatelessWidget {
  const HealthTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      {'title': '10 Ways to Lower Your Blood Pressure Naturally', 'cat': 'Heart Health', 'time': '5 min read', 'img': '❤️'},
      {'title': 'The Importance of Mental Health in a Digital Age', 'cat': 'Wellness', 'time': '8 min read', 'img': '🧠'},
      {'title': 'Nutrition 101: Understanding Your Macros', 'cat': 'Nutrition', 'time': '6 min read', 'img': '🥦'},
      {'title': 'Better Sleep: Tips for an Improved Circadian Rhythm', 'cat': 'Sleep', 'time': '4 min read', 'img': '🌙'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Health Education'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildFeaturedArticle(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Trending Articles'),
            const SizedBox(height: 12),
            ...articles.map((art) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildArticleCard(context, art),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: const Icon(Icons.star_rounded, size: 64, color: AppColors.background),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StatusBadge(label: 'FEATURED', color: AppColors.primary, fontSize: 10),
                const SizedBox(height: 12),
                const Text(
                  'Managing Chronic Stress: A Comprehensive Scientific Guide',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 1.3),
                ),
                const SizedBox(height: 8),
                Text(
                  'Learn how to identify chronic stress symptoms and implement daily management routines.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Map<String, String> art) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(art['img']!, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(art['cat']!, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 10)),
                const SizedBox(height: 4),
                Text(art['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.3)),
                const SizedBox(height: 4),
                Text(art['time']!, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
