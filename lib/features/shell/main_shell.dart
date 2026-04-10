import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/app_state.dart';

import '../../widgets/shared_widgets.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 720) {
              return _DesktopLayout(child: child, appState: appState);
            }
            return _MobileLayout(child: child, appState: appState);
          },
        );
      },
    );
  }
}

// ─── Desktop Sidebar Layout ───────────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final Widget child;
  final AppState appState;
  const _DesktopLayout({required this.child, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _Sidebar(appState: appState),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final AppState appState;
  const _Sidebar({required this.appState});

  @override
  Widget build(BuildContext context) {
    final user = appState.currentUser;
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.tealGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text('MedFlow Staff',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 15,
                    fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ],
            ),
          ),
          // User card
          if (user != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  AvatarCircle(initials: user.avatarInitials, size: 38),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.displayName,
                          style: const TextStyle(fontFamily: 'Inter', fontSize: 13,
                            fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                          overflow: TextOverflow.ellipsis),
                        Text(user.department,
                          style: const TextStyle(fontFamily: 'Inter', fontSize: 11,
                            color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          // Nav items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: appState.navItems.map((item) {
                final isActive = location.startsWith(item.route);
                return _SideNavItem(item: item, isActive: isActive);
              }).toList(),
            ),
          ),
          // Logout
          const Divider(color: AppColors.divider, height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: GestureDetector(
              onTap: () {
                context.read<AppState>().logout();
                context.go('/role-select');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.error.withOpacity(0.15)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                    SizedBox(width: 12),
                    Text('Sign Out',
                      style: TextStyle(fontFamily: 'Inter', fontSize: 14,
                        color: AppColors.error, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  final NavItem item;
  final bool isActive;
  const _SideNavItem({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(item.route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primary.withOpacity(0.25) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(item.icon,
              color: isActive ? AppColors.primary : AppColors.textMuted, size: 20),
            const SizedBox(width: 12),
            Text(item.label,
              style: TextStyle(fontFamily: 'Inter', fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.textPrimary : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

// ─── Mobile Bottom Nav Layout ─────────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final Widget child;
  final AppState appState;
  const _MobileLayout({required this.child, required this.appState});

  @override
  Widget build(BuildContext context) {
    final items = appState.navItems;
    final location = GoRouterState.of(context).matchedLocation;
    int selectedIndex = 0;
    for (int i = 0; i < items.length; i++) {
      if (location.startsWith(items[i].route)) { selectedIndex = i; break; }
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (i) => context.go(items[i].route),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: items.map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          )).toList(),
        ),
      ),
    );
  }
}
