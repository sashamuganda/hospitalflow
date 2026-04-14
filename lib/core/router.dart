import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_state.dart';
import '../features/auth/splash_screen.dart';
import '../features/auth/role_select_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/shell/main_shell.dart';
import '../features/dashboard/home_screen.dart';
import '../features/dashboard/notifications_screen.dart';
import '../features/queue/queue_home_screen.dart';
import '../features/queue/triage_screen.dart';
import '../features/queue/patient_check_in_screen.dart';
import '../features/queue/waiting_times_screen.dart';
import '../features/emr/emr_home_screen.dart';
import '../features/emr/patient_summary_screen.dart';
import '../features/emr/clinical_note_editor.dart';
import '../features/emr/prescription_writer_screen.dart';
import '../features/emr/vitals_entry_staff.dart';
import '../features/emr/lab_order_screen.dart';
import '../features/appointments/staff_appointments_home.dart';
import '../features/ward/ward_overview_screen.dart';
import '../features/telemedicine/tele_home_staff.dart';
import '../features/pharmacy/pharmacy_home_screen.dart';
import '../features/lab/lab_home_screen.dart';
import '../features/analytics/analytics_home_screen.dart';
import '../features/staff/staff_directory_screen.dart';
import '../features/settings/settings_home_screen.dart';

final _rootNavKey = GlobalKey<NavigatorState>();
final _shellNavKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AppState appState) {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/splash',
    refreshListenable: appState,
    redirect: (context, state) {
      final bool isAuthenticated = appState.isAuthenticated;
      final String location = state.matchedLocation;

      // Define public routes that don't require authentication
      final bool isAuthRoute = location == '/splash' ||
          location == '/role-select' ||
          location == '/login' ||
          location == '/forgot-password';

      // Security Guard: Redirect unauthenticated users to role selection
      if (!isAuthenticated && !isAuthRoute) {
        return '/role-select';
      }

      // If authenticated and trying to access login/role-select, go home
      if (isAuthenticated && (location == '/login' || location == '/role-select')) {
        return '/home';
      }

      return null;
    },
    routes: [
    // ─── Auth ──────────────────────────────────────────────────────────────────
    GoRoute(path: '/splash',       builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/role-select',  builder: (_, __) => const RoleSelectScreen()),
    GoRoute(path: '/login',        builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),

    // ─── Main Shell (Bottom Nav / Sidebar) ─────────────────────────────────────
    ShellRoute(
      navigatorKey: _shellNavKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home',         builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/queue',        builder: (_, __) => const QueueHomeScreen()),
        GoRoute(path: '/emr',          builder: (_, __) => const EmrHomeScreen()),
        GoRoute(path: '/appointments', builder: (_, __) => const StaffAppointmentsHome()),
        GoRoute(path: '/ward',         builder: (_, __) => const WardOverviewScreen()),
        GoRoute(path: '/telemedicine', builder: (_, __) => const TeleHomeStaffScreen()),
        GoRoute(path: '/pharmacy',     builder: (_, __) => const PharmacyHomeScreen()),
        GoRoute(path: '/inventory',    builder: (_, __) => const PharmacyHomeScreen()),
        GoRoute(path: '/lab',          builder: (_, __) => const LabHomeScreen()),
        GoRoute(path: '/analytics',    builder: (_, __) => const AnalyticsHomeScreen()),
        GoRoute(path: '/staff',        builder: (_, __) => const StaffDirectoryScreen()),
        GoRoute(path: '/settings',     builder: (_, __) => const SettingsHomeScreen()),
      ],
    ),

    // ─── Notifications ─────────────────────────────────────────────────────────
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),

    // ─── Queue ─────────────────────────────────────────────────────────────────
    GoRoute(path: '/queue/check-in', builder: (_, __) => const PatientCheckInScreen()),
    GoRoute(path: '/queue/wait-times', builder: (_, __) => const WaitingTimesScreen()),
    GoRoute(
      path: '/queue/triage/:id',
      builder: (_, state) => TriageScreen(patientId: state.pathParameters['id'] ?? ''),
    ),

    // ─── EMR ───────────────────────────────────────────────────────────────────
    GoRoute(
      path: '/emr/patient/:id',
      builder: (_, state) => PatientSummaryScreen(patientId: state.pathParameters['id'] ?? ''),
    ),
    GoRoute(
      path: '/emr/note-editor/:patientId',
      builder: (_, state) => ClinicalNoteEditor(patientId: state.pathParameters['patientId'] ?? ''),
    ),
    GoRoute(
      path: '/emr/prescription/:patientId',
      builder: (_, state) => PrescriptionWriterScreen(patientId: state.pathParameters['patientId'] ?? ''),
    ),
    GoRoute(
      path: '/emr/vitals/:patientId',
      builder: (_, state) => VitalsEntryStaff(patientId: state.pathParameters['patientId'] ?? ''),
    ),
    GoRoute(
      path: '/emr/lab-order/:patientId',
      builder: (_, state) => LabOrderScreen(patientId: state.pathParameters['patientId'] ?? ''),
    ),
    // Convenience route without patient ID (for Quick Actions)
    GoRoute(path: '/emr/vitals',    builder: (_, __) => const VitalsEntryStaff(patientId: '')),
    GoRoute(path: '/emr/lab-order', builder: (_, __) => const LabOrderScreen(patientId: '')),
  ],
  );
}
