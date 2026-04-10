import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/app_state.dart';
import '../../data/mock_data.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});
  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen> {
  StaffRole? _selected;

  void _onContinue() {
    if (_selected == null) return;
    context.read<AppState>().selectRole(_selected!);
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            gradient: AppColors.tealGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Text('MedFlow Staff',
                          style: TextStyle(fontFamily: 'Inter', fontSize: 20,
                            fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text('Select Your Role',
                      style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 8),
                    Text('Choose how you use MedFlow Staff to see the right tools.',
                      style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 32),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 2;
                          double aspectRatio = 1.05;

                          if (constraints.maxWidth > 1000) {
                            crossAxisCount = 6;
                            aspectRatio = 0.85; // Slightly taller for narrow columns
                          } else if (constraints.maxWidth > 800) {
                            crossAxisCount = 3;
                            aspectRatio = 1.1;
                          } else if (constraints.maxWidth > 600) {
                            crossAxisCount = 2;
                            aspectRatio = 1.2;
                          }

                          return GridView.count(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: aspectRatio,
                            children: StaffRole.values.map((role) => _RoleCard(
                              role: role,
                              isSelected: _selected == role,
                              onTap: () => setState(() => _selected = role),
                            )).toList(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedOpacity(
                      opacity: _selected != null ? 1.0 : 0.4,
                      duration: const Duration(milliseconds: 250),
                      child: GestureDetector(
                        onTap: _selected != null ? _onContinue : null,
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            gradient: _selected != null ? AppColors.tealGradient : null,
                            color: _selected != null ? null : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _selected != null ? [
                              BoxShadow(color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 16, offset: const Offset(0, 6)),
                            ] : null,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Continue as ${_selected?.displayName ?? 'Staff'}',
                                  style: const TextStyle(fontFamily: 'Inter', fontSize: 16,
                                    fontWeight: FontWeight.w600, color: AppColors.textOnPrimary)),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded, color: AppColors.textOnPrimary, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final StaffRole role;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({required this.role, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.2), AppColors.secondary.withOpacity(0.1)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight)
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(color: AppColors.primary.withOpacity(0.15),
              blurRadius: 12, offset: const Offset(0, 4))
          ] : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.2)
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(role.icon,
                color: isSelected ? AppColors.primary : AppColors.textMuted, size: 24),
            ),
            const Spacer(),
            Text(role.displayName,
              style: TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary)),
            const SizedBox(height: 4),
            Text(role.description,
              style: TextStyle(fontFamily: 'Inter', fontSize: 11,
                color: isSelected ? AppColors.textSecondary : AppColors.textMuted),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
