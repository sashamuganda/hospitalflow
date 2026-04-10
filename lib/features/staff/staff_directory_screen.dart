import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/shared_widgets.dart';

class StaffDirectoryScreen extends StatefulWidget {
  const StaffDirectoryScreen({super.key});

  @override
  State<StaffDirectoryScreen> createState() => _StaffDirectoryScreenState();
}

class _StaffDirectoryScreenState extends State<StaffDirectoryScreen> {
  String _searchQuery = '';
  StaffRole? _selectedRole;

  List<StaffMember> get _filtered {
    return mockStaffList.where((s) {
      final matchesSearch = s.fullName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesRole = _selectedRole == null || s.role == _selectedRole;
      return matchesSearch && matchesRole;
    }).toList();
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
                child: Text('Staff Directory', style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _FilterChip(label: 'All', isActive: _selectedRole == null, onTap: () => setState(() => _selectedRole = null)),
                    ...StaffRole.values.map((r) => _FilterChip(
                      label: r.displayName,
                      isActive: _selectedRole == r,
                      onTap: () => setState(() => _selectedRole = r),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final s = _filtered[i];
                    return GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          AvatarCircle(initials: s.avatarInitials, size: 50),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(s.displayName, style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(s.role.icon, size: 12, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text('${s.role.displayName} • ${s.department}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.email_rounded, color: AppColors.primary), onPressed: () {}),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
