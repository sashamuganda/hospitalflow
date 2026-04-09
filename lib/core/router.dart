import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/splash_screen.dart';
import '../features/auth/welcome_screen.dart';
import '../features/auth/signup_step1_screen.dart';
import '../features/auth/signup_step2_screen.dart';
import '../features/auth/signup_step3_screen.dart';
import '../features/auth/signup_step4_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/auth/reset_password_screen.dart';
import '../features/shell/main_shell.dart';
import '../features/dashboard/home_screen.dart';
import '../features/dashboard/notifications_screen.dart';
import '../features/appointments/appointments_home_screen.dart';
import '../features/appointments/book_step1_screen.dart';
import '../features/appointments/book_step2_screen.dart';
import '../features/appointments/book_step3_screen.dart';
import '../features/appointments/book_step4_screen.dart';
import '../features/appointments/book_step5_screen.dart';
import '../features/appointments/booking_confirmation_screen.dart';
import '../features/appointments/appointment_detail_screen.dart';
import '../features/appointments/reschedule_screen.dart';
import '../features/appointments/cancel_screen.dart';
import '../features/records/records_home_screen.dart';
import '../features/records/visit_history_screen.dart';
import '../features/records/visit_detail_screen.dart';
import '../features/records/lab_results_screen.dart';
import '../features/records/lab_result_detail_screen.dart';
import '../features/records/prescriptions_screen.dart';
import '../features/records/diagnoses_screen.dart';
import '../features/records/imaging_screen.dart';
import '../features/records/discharge_summaries_screen.dart';
import '../features/records/share_records_screen.dart';
import '../features/medications/medications_home_screen.dart';
import '../features/medications/medication_detail_screen.dart';
import '../features/medications/reminder_settings_screen.dart';
import '../features/medications/refill_finder_screen.dart';
import '../features/health/health_home_screen.dart';
import '../features/health/vitals_screen.dart';
import '../features/health/vitals_entry_screen.dart';
import '../features/health/body_metrics_screen.dart';
import '../features/health/chronic_tracker_screen.dart';
import '../features/health/mental_wellness_screen.dart';
import '../features/health/sleep_tracker_screen.dart';
import '../features/health/womens_health_screen.dart';
import '../features/health/mens_health_screen.dart';
import '../features/health/fitness_screen.dart';
import '../features/health/nutrition_screen.dart';
import '../features/health/vaccination_screen.dart';
import '../features/health/health_history_insights_screen.dart';
import '../features/symptom_checker/symptom_entry_screen.dart';
import '../features/symptom_checker/symptom_input_screen.dart';
import '../features/symptom_checker/symptom_context_screen.dart';
import '../features/symptom_checker/triage_results_screen.dart';
import '../features/symptom_checker/post_triage_screen.dart';
import '../features/telemedicine/telemedicine_home_screen.dart';
import '../features/telemedicine/find_doctor_screen.dart';
import '../features/telemedicine/doctor_profile_screen.dart';
import '../features/telemedicine/book_consultation_screen.dart';
import '../features/telemedicine/waiting_room_screen.dart';
import '../features/telemedicine/active_consultation_screen.dart';
import '../features/telemedicine/post_consultation_screen.dart';
import '../features/telemedicine/consultation_history_screen.dart';
import '../features/facilities/facilities_map_screen.dart';
import '../features/facilities/facilities_list_screen.dart';
import '../features/facilities/facility_detail_screen.dart';
import '../features/facilities/pharmacy_locator_screen.dart';
import '../features/drugs/drug_finder_home_screen.dart';
import '../features/drugs/drug_search_results_screen.dart';
import '../features/drugs/drug_detail_screen.dart';
import '../features/drugs/affordable_alternatives_screen.dart';
import '../features/profile/profile_home_screen.dart';
import '../features/profile/edit_personal_screen.dart';
import '../features/profile/health_profile_screen.dart';
import '../features/profile/emergency_contacts_screen.dart';
import '../features/profile/linked_devices_screen.dart';
import '../features/profile/privacy_screen.dart';
import '../features/profile/notification_prefs_screen.dart';
import '../features/profile/language_screen.dart';
import '../features/profile/security_screen.dart';
import '../features/profile/help_screen.dart';
import '../features/profile/about_screen.dart';
import '../features/utility/search_screen.dart';
import '../features/utility/health_tips_screen.dart';
import '../features/utility/generic_viewer_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // Auth Routes
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/signup/step1', builder: (_, __) => const SignupStep1Screen()),
    GoRoute(path: '/signup/step2', builder: (_, __) => const SignupStep2Screen()),
    GoRoute(path: '/signup/step3', builder: (_, __) => const SignupStep3Screen()),
    GoRoute(path: '/signup/step4', builder: (_, __) => const SignupStep4Screen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(path: '/reset-password', builder: (_, __) => const ResetPasswordScreen()),

    // Main Shell with Bottom Nav
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/appointments', builder: (_, __) => const AppointmentsHomeScreen()),
        GoRoute(path: '/records', builder: (_, __) => const RecordsHomeScreen()),
        GoRoute(path: '/health', builder: (_, __) => const HealthHomeScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileHomeScreen()),
      ],
    ),

    // Notifications
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),

    // Appointments
    GoRoute(path: '/appointments/book/step1', builder: (_, __) => const BookStep1Screen()),
    GoRoute(path: '/appointments/book/step2', builder: (_, __) => const BookStep2Screen()),
    GoRoute(path: '/appointments/book/step3', builder: (_, __) => const BookStep3Screen()),
    GoRoute(path: '/appointments/book/step4', builder: (_, __) => const BookStep4Screen()),
    GoRoute(path: '/appointments/book/step5', builder: (_, __) => const BookStep5Screen()),
    GoRoute(path: '/appointments/confirmation', builder: (_, __) => const BookingConfirmationScreen()),
    GoRoute(
      path: '/appointments/detail/:id',
      builder: (_, state) => AppointmentDetailScreen(appointmentId: state.pathParameters['id'] ?? ''),
    ),
    GoRoute(path: '/appointments/reschedule', builder: (_, __) => const RescheduleScreen()),
    GoRoute(path: '/appointments/cancel', builder: (_, __) => const CancelScreen()),

    // Medical Records
    GoRoute(path: '/records/visits', builder: (_, __) => const VisitHistoryScreen()),
    GoRoute(path: '/records/visit/:id', builder: (_, state) => VisitDetailScreen(visitId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/records/labs', builder: (_, __) => const LabResultsScreen()),
    GoRoute(path: '/records/lab/:id', builder: (_, state) => LabResultDetailScreen(resultId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/records/prescriptions', builder: (_, __) => const PrescriptionsScreen()),
    GoRoute(path: '/records/diagnoses', builder: (_, __) => const DiagnosesScreen()),
    GoRoute(path: '/records/imaging', builder: (_, __) => const ImagingScreen()),
    GoRoute(path: '/records/discharge', builder: (_, __) => const DischargeSummariesScreen()),
    GoRoute(path: '/records/share', builder: (_, __) => const ShareRecordsScreen()),

    // Medications
    GoRoute(path: '/medications', builder: (_, __) => const MedicationsHomeScreen()),
    GoRoute(path: '/medications/detail/:id', builder: (_, state) => MedicationDetailScreen(medicationId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/medications/reminders', builder: (_, __) => const ReminderSettingsScreen()),
    GoRoute(path: '/medications/refill', builder: (_, __) => const RefillFinderScreen()),

    // Health Metrics
    GoRoute(path: '/health/vitals', builder: (_, __) => const VitalsScreen()),
    GoRoute(path: '/health/vitals/entry', builder: (_, __) => const VitalsEntryScreen()),
    GoRoute(path: '/health/body', builder: (_, __) => const BodyMetricsScreen()),
    GoRoute(path: '/health/chronic', builder: (_, __) => const ChronicTrackerScreen()),
    GoRoute(path: '/health/mental', builder: (_, __) => const MentalWellnessScreen()),
    GoRoute(path: '/health/sleep', builder: (_, __) => const SleepTrackerScreen()),
    GoRoute(path: '/health/womens', builder: (_, __) => const WomensHealthScreen()),
    GoRoute(path: '/health/mens', builder: (_, __) => const MensHealthScreen()),
    GoRoute(path: '/health/fitness', builder: (_, __) => const FitnessScreen()),
    GoRoute(path: '/health/nutrition', builder: (_, __) => const NutritionScreen()),
    GoRoute(path: '/health/vaccination', builder: (_, __) => const VaccinationScreen()),
    GoRoute(path: '/health/insights', builder: (_, __) => const HealthInsightsScreen()),

    // Symptom Checker
    GoRoute(path: '/symptom-checker', builder: (_, __) => const SymptomEntryScreen()),
    GoRoute(path: '/symptom-checker/input', builder: (_, __) => const SymptomInputScreen()),
    GoRoute(path: '/symptom-checker/context', builder: (_, __) => const SymptomContextScreen()),
    GoRoute(path: '/symptom-checker/results', builder: (_, __) => const TriageResultsScreen()),
    GoRoute(path: '/symptom-checker/action', builder: (_, __) => const PostTriageScreen()),

    // Telemedicine
    GoRoute(path: '/telemedicine', builder: (_, __) => const TelemedicineHomeScreen()),
    GoRoute(path: '/telemedicine/find-doctor', builder: (_, __) => const FindDoctorScreen()),
    GoRoute(path: '/telemedicine/doctor/:id', builder: (_, state) => DoctorProfileScreen(doctorId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/telemedicine/book', builder: (_, __) => const BookConsultationScreen()),
    GoRoute(path: '/telemedicine/waiting-room', builder: (_, __) => const WaitingRoomScreen()),
    GoRoute(path: '/telemedicine/call', builder: (_, __) => const ActiveConsultationScreen()),
    GoRoute(path: '/telemedicine/summary', builder: (_, __) => const PostConsultationScreen()),
    GoRoute(path: '/telemedicine/history', builder: (_, __) => const ConsultationHistoryScreen()),

    // Facilities
    GoRoute(path: '/facilities', builder: (_, __) => const FacilitiesMapScreen()),
    GoRoute(path: '/facilities/list', builder: (_, __) => const FacilitiesListScreen()),
    GoRoute(path: '/facilities/detail/:id', builder: (_, state) => FacilityDetailScreen(facilityId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/facilities/pharmacy', builder: (_, __) => const PharmacyLocatorScreen()),

    // Drug Finder
    GoRoute(path: '/drugs', builder: (_, __) => const DrugFinderHomeScreen()),
    GoRoute(path: '/drugs/results', builder: (_, __) => const DrugSearchResultsScreen()),
    GoRoute(path: '/drugs/detail/:id', builder: (_, state) => DrugDetailScreen(drugId: state.pathParameters['id'] ?? '')),
    GoRoute(path: '/drugs/alternatives', builder: (_, __) => const AffordableAlternativesScreen()),

    // Profile & Settings
    GoRoute(path: '/profile/edit', builder: (_, __) => const EditPersonalScreen()),
    GoRoute(path: '/profile/health', builder: (_, __) => const HealthProfileScreen()),
    GoRoute(path: '/profile/emergency-contacts', builder: (_, __) => const EmergencyContactsScreen()),
    GoRoute(path: '/profile/linked-devices', builder: (_, __) => const LinkedDevicesScreen()),
    GoRoute(path: '/profile/privacy', builder: (_, __) => const PrivacyScreen()),
    GoRoute(path: '/profile/notifications', builder: (_, __) => const NotificationPrefsScreen()),
    GoRoute(path: '/profile/language', builder: (_, __) => const LanguageScreen()),
    GoRoute(path: '/profile/security', builder: (_, __) => const SecurityScreen()),
    GoRoute(path: '/profile/help', builder: (_, __) => const HelpScreen()),
    GoRoute(path: '/profile/about', builder: (_, __) => const AboutScreen()),

    // Utility
    GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
    GoRoute(path: '/health-tips', builder: (_, __) => const HealthTipsScreen()),
    GoRoute(path: '/viewer', builder: (context, state) {
      final extra = state.extra as Map<String, String>?;
      return GenericViewerScreen(
        title: extra?['title'] ?? 'Document Viewer',
        content: extra?['content'] ?? 'No content provided.',
      );
    }),
  ],
);
