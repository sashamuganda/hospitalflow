import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _waterGlasses = 5;
  final int _waterGoal = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Nutrition & Hydration'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalorieCard(context),
            const SizedBox(height: 24),
            Text('Hydration Tracker', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _buildWaterTracker(context),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Macro Breakdown'),
            const SizedBox(height: 12),
            _buildMacroGrid(context),
            const SizedBox(height: 32),
            _buildNutritionInsight(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Calories Remaining', style: TextStyle(fontSize: 14, color: AppColors.textMuted)),
                  Text('1,240', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text('Goal: 2,100 kcal', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
              CircularProgressIndicator(
                value: 0.4,
                strokeWidth: 8,
                color: AppColors.primary,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                strokeCap: StrokeCap.round,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const TealDivider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFoodStat('Breakfast', '420'),
              _buildFoodStat('Lunch', '580'),
              _buildFoodStat('Dinner', '0'),
              _buildFoodStat('Snacks', '120'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodStat(String label, String kcal) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(kcal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildWaterTracker(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$_waterGlasses / $_waterGoal glasses', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text('1.25 L of 2.0 L', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
              const Icon(Icons.water_drop_rounded, color: Colors.blue, size: 32),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (index) {
              final filled = index < _waterGlasses;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (filled && index == _waterGlasses - 1) {
                      _waterGlasses--;
                    } else {
                      _waterGlasses = index + 1;
                    }
                  });
                },
                child: Icon(
                  Icons.local_drink_rounded,
                  color: filled ? Colors.blue : AppColors.divider,
                  size: 28,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildMacroTile(context, 'Protein', '85g', 0.6, Colors.orange)),
        const SizedBox(width: 12),
        Expanded(child: _buildMacroTile(context, 'Carbs', '140g', 0.4, Colors.green)),
        const SizedBox(width: 12),
        Expanded(child: _buildMacroTile(context, 'Fats', '55g', 0.3, Colors.red)),
      ],
    );
  }

  Widget _buildMacroTile(BuildContext context, String label, String value, double percent, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: percent, minHeight: 4, color: color, backgroundColor: color.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
        ],
      ),
    );
  }

  Widget _buildNutritionInsight(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline_rounded, color: Colors.amber, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nutrition Hack', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Your fiber intake is low (12g). Try adding chia seeds or beans to your next meal.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
