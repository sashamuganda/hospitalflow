import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class AppState extends ChangeNotifier {
  StaffRole _selectedRole = StaffRole.doctor;
  StaffMember? _currentUser;
  bool _isAuthenticated = false;
  late List<NavItem> _navItems;

  AppState() {
    _updateNavItems();
  }

  StaffRole get selectedRole => _selectedRole;
  StaffMember? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  String get roleDisplayName => _selectedRole.displayName;

  /// Returns the memoized list of navigation items for the current role.
  /// Memoization prevents unnecessary rebuilds of widgets that select this property.
  List<NavItem> get navItems => _navItems;

  void _updateNavItems() {
    switch (_selectedRole) {
      case StaffRole.doctor:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(
              icon: Icons.folder_shared_rounded, label: 'EMR', route: '/emr'),
          NavItem(
              icon: Icons.video_call_rounded,
              label: 'Telemedicine',
              route: '/telemedicine'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
      case StaffRole.nurse:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(icon: Icons.bed_rounded, label: 'Ward', route: '/ward'),
          NavItem(icon: Icons.science_rounded, label: 'Lab', route: '/lab'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
      case StaffRole.admin:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.bar_chart_rounded,
              label: 'Analytics',
              route: '/analytics'),
          NavItem(
              icon: Icons.calendar_month_rounded,
              label: 'Schedule',
              route: '/appointments'),
          NavItem(icon: Icons.groups_rounded, label: 'Staff', route: '/staff'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
      case StaffRole.receptionist:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.people_alt_rounded, label: 'Queue', route: '/queue'),
          NavItem(
              icon: Icons.calendar_month_rounded,
              label: 'Bookings',
              route: '/appointments'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
      case StaffRole.pharmacist:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.receipt_long_rounded,
              label: 'Dispense',
              route: '/pharmacy'),
          NavItem(
              icon: Icons.inventory_2_rounded,
              label: 'Inventory',
              route: '/inventory'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
      case StaffRole.labTech:
        _navItems = const [
          NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
          NavItem(
              icon: Icons.science_rounded, label: 'Lab Orders', route: '/lab'),
          NavItem(
              icon: Icons.person_rounded, label: 'Profile', route: '/settings'),
        ];
        break;
    }
  }

  void selectRole(StaffRole role) {
    if (_selectedRole == role) return;
    _selectedRole = role;
    _updateNavItems();
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
