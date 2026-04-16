import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/colors.dart';
import '../data/mock_data.dart';

// ─── Glass Card ────────────────────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.borderColor,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.cardGradient,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? AppColors.divider, width: 1),
        ),
        child: child,
      ),
    );
  }
}

// ─── App Bar ───────────────────────────────────────────────────────────────────
class MedFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Widget? leading;

  const MedFlowAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back',
            )
          : leading,
      title: Text(title),
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ─── Gradient Button ───────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final IconData? icon;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              HapticFeedback.lightImpact();
              onPressed();
            },
      child: Semantics(
        button: true,
        label: label,
        enabled: !isLoading,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 54,
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.tealGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(width: 22, height: 22,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: AppColors.textOnPrimary, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(label,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 16,
                        fontWeight: FontWeight.w600, color: AppColors.textOnPrimary)),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

// ─── Section Header ────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel!, style: const TextStyle(fontSize: 14)),
          ),
      ],
    );
  }
}

// ─── Status Badge ──────────────────────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;

  const StatusBadge({super.key, required this.label, required this.color, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label,
        style: TextStyle(color: color, fontSize: fontSize,
          fontWeight: FontWeight.w600, fontFamily: 'Inter')),
    );
  }
}

// ─── Avatar Circle ────────────────────────────────────────────────────────────
class AvatarCircle extends StatelessWidget {
  final String initials;
  final double size;
  final Gradient? gradient;
  final Color? backgroundColor;

  const AvatarCircle({super.key, required this.initials, this.size = 44, this.gradient, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.primaryGradient,
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(initials,
          style: TextStyle(color: Colors.white, fontSize: size * 0.35,
            fontWeight: FontWeight.w700, fontFamily: 'Inter')),
      ),
    );
  }
}

// ─── Info Row ─────────────────────────────────────────────────────────────────
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoRow({super.key, required this.icon, required this.label, required this.value, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── KPI Card ─────────────────────────────────────────────────────────────────
class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const KpiCard({super.key, required this.label, required this.value,
    this.subtitle, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary, fontFamily: 'Inter')),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(subtitle!,
                style: const TextStyle(color: AppColors.success, fontSize: 11,
                  fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 4),
            Text(label,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

// ─── Metric Card ──────────────────────────────────────────────────────────────
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const MetricCard({super.key, required this.label, required this.value,
    required this.unit, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary, fontFamily: 'Inter')),
            Text(unit, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontFamily: 'Inter')),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({super.key, required this.icon, required this.title,
    required this.message, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.surfaceLight, shape: BoxShape.circle),
              child: Icon(icon, size: 40, color: AppColors.textMuted),
            ),
            const SizedBox(height: 20),
            Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            if (actionLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Star Rating ──────────────────────────────────────────────────────────────
class StarRating extends StatelessWidget {
  final double rating;
  final int count;
  final double size;

  const StarRating({super.key, required this.rating, required this.count, this.size = 13});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: size + 3, color: const Color(0xFFFFB830)),
        const SizedBox(width: 3),
        Text(rating.toStringAsFixed(1),
          style: TextStyle(fontSize: size, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary, fontFamily: 'Inter')),
        const SizedBox(width: 4),
        Text('($count)', style: TextStyle(fontSize: size - 1, color: AppColors.textMuted, fontFamily: 'Inter')),
      ],
    );
  }
}

// ─── Teal Divider ─────────────────────────────────────────────────────────────
class TealDivider extends StatelessWidget {
  const TealDivider({super.key});
  @override
  Widget build(BuildContext context) => Container(height: 1, color: AppColors.divider);
}

// ─── Triage Chip ──────────────────────────────────────────────────────────────
class TriageChip extends StatelessWidget {
  final TriageLevel level;
  final bool compact;

  const TriageChip({super.key, required this.level, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final color = level.color;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 10, vertical: compact ? 2 : 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: compact ? 6 : 8, height: compact ? 6 : 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: compact ? 4 : 5),
          Text(compact ? level.shortCode : level.label,
            style: TextStyle(color: color, fontSize: compact ? 10 : 12,
              fontWeight: FontWeight.w700, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}

// ─── Role Badge ───────────────────────────────────────────────────────────────
class RoleBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const RoleBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withOpacity(0.3)),
      ),
      child: Text(label,
        style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
    );
  }
}

// ─── Coming Soon Placeholder ──────────────────────────────────────────────────
class ComingSoonScreen extends StatelessWidget {
  final String moduleName;
  final IconData icon;

  const ComingSoonScreen({super.key, required this.moduleName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 48),
                ),
                const SizedBox(height: 24),
                Text(moduleName, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                const RoleBadge(label: 'Phase 2 — Coming Soon'),
                const SizedBox(height: 12),
                Text('This module is under active development.\nCheck back in the next release.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
