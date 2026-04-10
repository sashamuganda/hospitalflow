import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class AppState extends ChangeNotifier {
  StaffRole _selectedRole = StaffRole.doctor;
  StaffMember? _currentUser;
  bool _isAuthenticated = false;

  StaffRole get selectedRole => _selectedRole;
  StaffMember? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  String get roleDisplayName => _selectedRole.displayName;

  List<NavItem> get navItems {
    switch (_selectedRole) {
      case StaffRole.doctor:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(icon: Icons.folder_shared_rounded, label: 'EMR', route: '/emr'),
          NavItem(icon: Icons.video_call_rounded, label: 'Telemedicine', route: '/telemedicine'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
      case StaffRole.nurse:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(icon: Icons.bed_rounded, label: 'Ward', route: '/ward'),
          NavItem(icon: Icons.science_rounded, label: 'Lab', route: '/lab'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
      case StaffRole.admin:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.bar_chart_rounded, label: 'Analytics', route: '/analytics'),
          NavItem(icon: Icons.calendar_month_rounded, label: 'Schedule', route: '/appointments'),
          NavItem(icon: Icons.groups_rounded, label: 'Staff', route: '/staff'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
      case StaffRole.receptionist:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(icon: Icons.calendar_month_rounded, label: 'Bookings', route: '/appointments'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
      case StaffRole.pharmacist:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.receipt_long_rounded, label: 'Dispense', route: '/pharmacy'),
          NavItem(icon: Icons.inventory_2_rounded, label: 'Inventory', route: '/inventory'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
      case StaffRole.labTech:
        return [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(icon: Icons.science_rounded, label: 'Lab Orders', route: '/lab'),
          NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
    }
  }

  void selectRole(StaffRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  void login(StaffMember user) {
    _currentUser = user;
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final String route;
  const NavItem({required this.icon, required this.label, required this.route});
}
