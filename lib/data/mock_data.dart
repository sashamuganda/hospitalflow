import 'package:flutter/material.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────
enum StaffRole { doctor, nurse, admin, receptionist, pharmacist, labTech }

enum TriageLevel { immediate, urgent, semiUrgent, nonUrgent }

enum QueueStatus { waiting, inConsultation, completed, transferred, noShow }

enum AppointmentStatus { confirmed, pending, completed, cancelled, noShow }

enum BedStatus { empty, occupied, cleaning }

enum PrescriptionStatus { pending, processing, dispensed }

// ─── Enum Extensions ──────────────────────────────────────────────────────────
extension StaffRoleX on StaffRole {
  String get displayName {
    switch (this) {
      case StaffRole.doctor:
        return 'Doctor';
      case StaffRole.nurse:
        return 'Nurse';
      case StaffRole.admin:
        return 'Administrator';
      case StaffRole.receptionist:
        return 'Receptionist';
      case StaffRole.pharmacist:
        return 'Pharmacist';
      case StaffRole.labTech:
        return 'Lab Technician';
    }
  }

  String get description {
    switch (this) {
      case StaffRole.doctor:
        return 'Clinical consultation & EMR access';
      case StaffRole.nurse:
        return 'Patient care & vitals monitoring';
      case StaffRole.admin:
        return 'Hospital management & analytics';
      case StaffRole.receptionist:
        return 'Queue & appointment management';
      case StaffRole.pharmacist:
        return 'Medication dispensing & inventory';
      case StaffRole.labTech:
        return 'Lab orders & result processing';
    }
  }

  IconData get icon {
    switch (this) {
      case StaffRole.doctor:
        return Icons.medical_services_rounded;
      case StaffRole.nurse:
        return Icons.local_hospital_rounded;
      case StaffRole.admin:
        return Icons.admin_panel_settings_rounded;
      case StaffRole.receptionist:
        return Icons.support_agent_rounded;
      case StaffRole.pharmacist:
        return Icons.medication_rounded;
      case StaffRole.labTech:
        return Icons.science_rounded;
    }
  }
}

extension TriageLevelX on TriageLevel {
  String get label {
    switch (this) {
      case TriageLevel.immediate:
        return 'Immediate';
      case TriageLevel.urgent:
        return 'Urgent';
      case TriageLevel.semiUrgent:
        return 'Semi-Urgent';
      case TriageLevel.nonUrgent:
        return 'Non-Urgent';
    }
  }

  String get shortCode {
    switch (this) {
      case TriageLevel.immediate:
        return 'RED';
      case TriageLevel.urgent:
        return 'ORANGE';
      case TriageLevel.semiUrgent:
        return 'YELLOW';
      case TriageLevel.nonUrgent:
        return 'GREEN';
    }
  }

  Color get color {
    switch (this) {
      case TriageLevel.immediate:
        return const Color(0xFFFF4C6A);
      case TriageLevel.urgent:
        return const Color(0xFFFF8C42);
      case TriageLevel.semiUrgent:
        return const Color(0xFFFFB830);
      case TriageLevel.nonUrgent:
        return const Color(0xFF00E5A0);
    }
  }

  int get maxWaitMinutes {
    switch (this) {
      case TriageLevel.immediate:
        return 0;
      case TriageLevel.urgent:
        return 15;
      case TriageLevel.semiUrgent:
        return 60;
      case TriageLevel.nonUrgent:
        return 240;
    }
  }
}

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.noShow:
        return 'No Show';
    }
  }

  Color get color {
    switch (this) {
      case AppointmentStatus.confirmed:
        return const Color(0xFF00D4FF);
      case AppointmentStatus.pending:
        return const Color(0xFFFFB830);
      case AppointmentStatus.completed:
        return const Color(0xFF00E5A0);
      case AppointmentStatus.cancelled:
        return const Color(0xFF4A5880);
      case AppointmentStatus.noShow:
        return const Color(0xFFFF4C6A);
    }
  }
}

extension BedStatusX on BedStatus {
  String get label {
    switch (this) {
      case BedStatus.empty:
        return 'Empty';
      case BedStatus.occupied:
        return 'Occupied';
      case BedStatus.cleaning:
        return 'Cleaning';
    }
  }

  Color get color {
    switch (this) {
      case BedStatus.empty:
        return const Color(0xFF00E5A0);
      case BedStatus.occupied:
        return const Color(0xFF00D4FF);
      case BedStatus.cleaning:
        return const Color(0xFFFFB830);
    }
  }
}

extension PrescriptionStatusX on PrescriptionStatus {
  String get label {
    switch (this) {
      case PrescriptionStatus.pending:
        return 'Pending';
      case PrescriptionStatus.processing:
        return 'Processing';
      case PrescriptionStatus.dispensed:
        return 'Dispensed';
    }
  }

  Color get color {
    switch (this) {
      case PrescriptionStatus.pending:
        return const Color(0xFFFFB830);
      case PrescriptionStatus.processing:
        return const Color(0xFF00D4FF);
      case PrescriptionStatus.dispensed:
        return const Color(0xFF00E5A0);
    }
  }
}

// ─── Models ────────────────────────────────────────────────────────────────────
class StaffMember {
  final String id;
  final String firstName;
  final String lastName;
  final StaffRole role;
  final String department;
  final String staffId;
  final String? specialization;
  final String email;
  final String phone;
  final bool isOnDuty;

  const StaffMember({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.department,
    required this.staffId,
    this.specialization,
    required this.email,
    required this.phone,
    this.isOnDuty = true,
  });

  String get fullName => '$firstName $lastName';
  String get displayName =>
      role == StaffRole.doctor ? 'Dr. $fullName' : fullName;
  String get avatarInitials => '${firstName[0]}${lastName[0]}';
}

class PatientInQueue {
  final String id;
  final String patientId;
  final String patientName;
  final int age;
  final String gender;
  final int queueNumber;
  final TriageLevel triageLevel;
  final DateTime arrivalTime;
  final String chiefComplaint;
  final String? assignedDoctorId;
  final String? assignedDoctorName;
  final QueueStatus status;
  final String department;
  final Map<String, String>? vitals;

  const PatientInQueue({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.queueNumber,
    required this.triageLevel,
    required this.arrivalTime,
    required this.chiefComplaint,
    this.assignedDoctorId,
    this.assignedDoctorName,
    required this.status,
    required this.department,
    this.vitals,
  });

  String get initials {
    final parts = patientName.split(' ');
    return parts.length >= 2 ? '${parts[0][0]}${parts[1][0]}' : patientName[0];
  }

  int get waitMinutes => DateTime.now().difference(arrivalTime).inMinutes;
}

class StaffAppointment {
  final String id;
  final String patientName;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final DateTime dateTime;
  final String type;
  final AppointmentStatus status;
  final String? room;
  final String? notes;
  final String department;

  const StaffAppointment({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.type,
    required this.status,
    this.room,
    this.notes,
    required this.department,
  });
}

class PatientRecord {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String bloodGroup;
  final List<String> allergies;
  final List<String> activeConditions;
  final List<String> currentMedications;
  final String nationalId;
  final String phone;
  final String? insuranceProvider;
  final DateTime? lastVisit;

  const PatientRecord({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.allergies,
    required this.activeConditions,
    required this.currentMedications,
    required this.nationalId,
    required this.phone,
    this.insuranceProvider,
    this.lastVisit,
  });

  String get fullName => '$firstName $lastName';
  String get avatarInitials => '${firstName[0]}${lastName[0]}';
  int get age {
    final now = DateTime.now();
    int a = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) a--;
    return a;
  }
}

class ClinicalNote {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime createdAt;
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;
  final bool isSigned;
  final List<String> diagnoses;

  const ClinicalNote({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.createdAt,
    required this.subjective,
    required this.objective,
    required this.assessment,
    required this.plan,
    required this.isSigned,
    required this.diagnoses,
  });
}

class VitalSigns {
  final String id;
  final String patientId;
  final DateTime timestamp;
  final double? systolicBP;
  final double? diastolicBP;
  final double? heartRate;
  final double? spO2;
  final double? temperature;
  final double? respiratoryRate;
  final double? weight;
  final double? height;
  final String recordedBy;

  const VitalSigns({
    required this.id,
    required this.patientId,
    required this.timestamp,
    this.systolicBP,
    this.diastolicBP,
    this.heartRate,
    this.spO2,
    this.temperature,
    this.respiratoryRate,
    this.weight,
    this.height,
    required this.recordedBy,
  });

  String get bpDisplay => systolicBP != null && diastolicBP != null
      ? '${systolicBP!.toInt()}/${diastolicBP!.toInt()}'
      : '—';
}

class LabOrder {
  final String id;
  final String patientId;
  final String patientName;
  final String orderedById;
  final String orderedByName;
  final DateTime orderedAt;
  final List<String> tests;
  final String status;
  final String priority;
  final String? specimenType;

  const LabOrder({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.orderedById,
    required this.orderedByName,
    required this.orderedAt,
    required this.tests,
    required this.status,
    required this.priority,
    this.specimenType,
  });

  Color get priorityColor {
    switch (priority.toLowerCase()) {
      case 'stat':
        return const Color(0xFFFF4C6A);
      case 'urgent':
        return const Color(0xFFFF8C42);
      default:
        return const Color(0xFF00D4FF);
    }
  }
}

class HospitalKPI {
  final int todayOPDCount;
  final int currentIPDOccupancy;
  final int totalBeds;
  final int staffOnDuty;
  final double avgWaitTimeMinutes;
  final int pendingLabResults;
  final int criticalAlerts;

  const HospitalKPI({
    required this.todayOPDCount,
    required this.currentIPDOccupancy,
    required this.totalBeds,
    required this.staffOnDuty,
    required this.avgWaitTimeMinutes,
    required this.pendingLabResults,
    required this.criticalAlerts,
  });

  double get ipdOccupancyPercent => (currentIPDOccupancy / totalBeds) * 100;
}

class StaffNotification {
  final String id;
  final String title;
  final String message;
  final String type; // 'critical', 'lab', 'appointment', 'system'
  final DateTime time;
  final bool isRead;

  const StaffNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.time,
    this.isRead = false,
  });

  Color get typeColor {
    switch (type) {
      case 'critical':
        return const Color(0xFFFF4C6A);
      case 'lab':
        return const Color(0xFF7C3AED);
      case 'appointment':
        return const Color(0xFF00D4FF);
      default:
        return const Color(0xFF00E5A0);
    }
  }

  IconData get typeIcon {
    switch (type) {
      case 'critical':
        return Icons.warning_rounded;
      case 'lab':
        return Icons.science_rounded;
      case 'appointment':
        return Icons.calendar_today_rounded;
      default:
        return Icons.info_rounded;
    }
  }
}

// ─── Mock Current User Helpers ────────────────────────────────────────────────
class MockCurrentUser {
  static StaffMember forRole(StaffRole role) {
    switch (role) {
      case StaffRole.doctor:
        return const StaffMember(
            id: 's001',
            firstName: 'Amara',
            lastName: 'Osei',
            role: StaffRole.doctor,
            department: 'Internal Medicine',
            staffId: 'DOC-2024-001',
            specialization: 'Internal Medicine & Nephrology',
            email: 'a.osei@medflow.hospital',
            phone: '+254 700 001 001');
      case StaffRole.nurse:
        return const StaffMember(
            id: 's002',
            firstName: 'Grace',
            lastName: 'Achieng',
            role: StaffRole.nurse,
            department: 'General Ward',
            staffId: 'NUR-2024-010',
            email: 'g.achieng@medflow.hospital',
            phone: '+254 700 002 002');
      case StaffRole.admin:
        return const StaffMember(
            id: 's003',
            firstName: 'Kwame',
            lastName: 'Mensah',
            role: StaffRole.admin,
            department: 'Administration',
            staffId: 'ADM-2024-001',
            email: 'k.mensah@medflow.hospital',
            phone: '+254 700 003 003');
      case StaffRole.receptionist:
        return const StaffMember(
            id: 's004',
            firstName: 'Nadia',
            lastName: 'Kamau',
            role: StaffRole.receptionist,
            department: 'Reception',
            staffId: 'REC-2024-001',
            email: 'n.kamau@medflow.hospital',
            phone: '+254 700 004 004');
      case StaffRole.pharmacist:
        return const StaffMember(
            id: 's005',
            firstName: 'David',
            lastName: 'Otieno',
            role: StaffRole.pharmacist,
            department: 'Pharmacy',
            staffId: 'PHR-2024-001',
            email: 'd.otieno@medflow.hospital',
            phone: '+254 700 005 005');
      case StaffRole.labTech:
        return const StaffMember(
            id: 's006',
            firstName: 'Fatima',
            lastName: 'Wanjiru',
            role: StaffRole.labTech,
            department: 'Laboratory',
            staffId: 'LAB-2024-001',
            email: 'f.wanjiru@medflow.hospital',
            phone: '+254 700 006 006');
    }
  }
}

// ─── Mock Queue ────────────────────────────────────────────────────────────────
final List<PatientInQueue> mockQueue = [
  PatientInQueue(
    id: 'q001',
    patientId: 'p001',
    patientName: 'James Mwangi',
    age: 54,
    gender: 'Male',
    queueNumber: 1,
    triageLevel: TriageLevel.immediate,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 5)),
    chiefComplaint: 'Severe chest pain with diaphoresis',
    department: 'Emergency',
    assignedDoctorId: 's001',
    assignedDoctorName: 'Dr. Amara Osei',
    status: QueueStatus.inConsultation,
    vitals: {'BP': '180/110', 'HR': '110 bpm', 'SpO₂': '94%'},
  ),
  PatientInQueue(
    id: 'q002',
    patientId: 'p002',
    patientName: 'Mary Njeri',
    age: 32,
    gender: 'Female',
    queueNumber: 2,
    triageLevel: TriageLevel.urgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 22)),
    chiefComplaint: 'High fever (39.8°C) with rigors',
    department: 'OPD',
    status: QueueStatus.waiting,
    vitals: {'Temp': '39.8°C', 'HR': '98 bpm'},
  ),
  PatientInQueue(
    id: 'q003',
    patientId: 'p003',
    patientName: 'Peter Kiprotich',
    age: 8,
    gender: 'Male',
    queueNumber: 3,
    triageLevel: TriageLevel.urgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 30)),
    chiefComplaint: 'Difficulty breathing — known asthmatic',
    department: 'Pediatrics',
    status: QueueStatus.waiting,
  ),
  PatientInQueue(
    id: 'q004',
    patientId: 'p004',
    patientName: 'Alice Wambua',
    age: 28,
    gender: 'Female',
    queueNumber: 4,
    triageLevel: TriageLevel.semiUrgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 45)),
    chiefComplaint: 'Persistent headache for 3 days',
    department: 'OPD',
    status: QueueStatus.waiting,
  ),
  PatientInQueue(
    id: 'q005',
    patientId: 'p005',
    patientName: 'Samuel Ouma',
    age: 67,
    gender: 'Male',
    queueNumber: 5,
    triageLevel: TriageLevel.semiUrgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 55)),
    chiefComplaint: 'Follow-up: hypertension management',
    department: 'OPD',
    status: QueueStatus.waiting,
  ),
  PatientInQueue(
    id: 'q006',
    patientId: 'p006',
    patientName: 'Rehema Abdi',
    age: 22,
    gender: 'Female',
    queueNumber: 6,
    triageLevel: TriageLevel.nonUrgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 70)),
    chiefComplaint: 'Prescription renewal — chronic condition',
    department: 'OPD',
    status: QueueStatus.waiting,
  ),
  PatientInQueue(
    id: 'q007',
    patientId: 'p007',
    patientName: 'Thomas Gichuki',
    age: 45,
    gender: 'Male',
    queueNumber: 7,
    triageLevel: TriageLevel.nonUrgent,
    arrivalTime: DateTime.now().subtract(const Duration(minutes: 80)),
    chiefComplaint: 'Annual health check-up',
    department: 'OPD',
    status: QueueStatus.waiting,
  ),
];

// ─── Mock Appointments ────────────────────────────────────────────────────────
final List<StaffAppointment> mockStaffAppointments = [
  StaffAppointment(
      id: 'a001',
      patientName: 'Alice Wambua',
      patientId: 'p004',
      doctorId: 's001',
      doctorName: 'Dr. Amara Osei',
      dateTime: DateTime.now().copyWith(hour: 9, minute: 0, second: 0),
      type: 'OPD',
      status: AppointmentStatus.completed,
      room: 'Room 3',
      department: 'Internal Medicine'),
  StaffAppointment(
      id: 'a002',
      patientName: 'Zainab Hassan',
      patientId: 'p008',
      doctorId: 's001',
      doctorName: 'Dr. Amara Osei',
      dateTime: DateTime.now().copyWith(hour: 10, minute: 30, second: 0),
      type: 'OPD',
      status: AppointmentStatus.confirmed,
      room: 'Room 3',
      department: 'Internal Medicine'),
  StaffAppointment(
      id: 'a003',
      patientName: 'Charles Mutua',
      patientId: 'p009',
      doctorId: 's001',
      doctorName: 'Dr. Amara Osei',
      dateTime: DateTime.now().copyWith(hour: 11, minute: 0, second: 0),
      type: 'Follow-up',
      status: AppointmentStatus.confirmed,
      room: 'Room 3',
      department: 'Internal Medicine'),
  StaffAppointment(
      id: 'a004',
      patientName: 'Sarah Ochieng',
      patientId: 'p010',
      doctorId: 's001',
      doctorName: 'Dr. Amara Osei',
      dateTime: DateTime.now().copyWith(hour: 14, minute: 0, second: 0),
      type: 'Telemedicine',
      status: AppointmentStatus.confirmed,
      department: 'Internal Medicine'),
  StaffAppointment(
      id: 'a005',
      patientName: 'Mohamed Ali',
      patientId: 'p011',
      doctorId: 's001',
      doctorName: 'Dr. Amara Osei',
      dateTime: DateTime.now().copyWith(hour: 15, minute: 30, second: 0),
      type: 'OPD',
      status: AppointmentStatus.pending,
      room: 'Room 3',
      department: 'Internal Medicine'),
];

// ─── Mock Patient Records ─────────────────────────────────────────────────────
final List<PatientRecord> mockPatientRecords = [
  PatientRecord(
      id: 'p001',
      firstName: 'James',
      lastName: 'Mwangi',
      dateOfBirth: DateTime(1970, 3, 15),
      gender: 'Male',
      bloodGroup: 'O+',
      allergies: ['Penicillin', 'Aspirin'],
      activeConditions: ['Hypertension', 'Coronary Artery Disease'],
      currentMedications: ['Amlodipine 5mg', 'Metoprolol 25mg', 'Aspirin 75mg'],
      nationalId: '12345678',
      phone: '+254 722 111 111',
      insuranceProvider: 'NHIF',
      lastVisit: DateTime.now().subtract(const Duration(days: 30))),
  PatientRecord(
      id: 'p002',
      firstName: 'Mary',
      lastName: 'Njeri',
      dateOfBirth: DateTime(1992, 8, 22),
      gender: 'Female',
      bloodGroup: 'A+',
      allergies: ['Sulfonamides'],
      activeConditions: ['Type 2 Diabetes'],
      currentMedications: ['Metformin 500mg'],
      nationalId: '23456789',
      phone: '+254 733 222 222',
      lastVisit: DateTime.now().subtract(const Duration(days: 14))),
  PatientRecord(
      id: 'p004',
      firstName: 'Alice',
      lastName: 'Wambua',
      dateOfBirth: DateTime(1996, 5, 10),
      gender: 'Female',
      bloodGroup: 'B+',
      allergies: [],
      activeConditions: ['Migraine'],
      currentMedications: ['Sumatriptan 50mg PRN'],
      nationalId: '34567890',
      phone: '+254 744 333 333',
      insuranceProvider: 'AAR Insurance',
      lastVisit: DateTime.now().subtract(const Duration(days: 60))),
  PatientRecord(
      id: 'p005',
      firstName: 'Samuel',
      lastName: 'Ouma',
      dateOfBirth: DateTime(1957, 11, 5),
      gender: 'Male',
      bloodGroup: 'AB+',
      allergies: ['Codeine'],
      activeConditions: ['Hypertension', 'Type 2 Diabetes', 'CKD Stage 2'],
      currentMedications: [
        'Enalapril 10mg',
        'Metformin 1000mg',
        'Atorvastatin 20mg'
      ],
      nationalId: '45678901',
      phone: '+254 755 444 444',
      insuranceProvider: 'NHIF',
      lastVisit: DateTime.now().subtract(const Duration(days: 7))),
];

// ─── Mock Clinical Notes ──────────────────────────────────────────────────────
final List<ClinicalNote> mockClinicalNotes = [
  ClinicalNote(
    id: 'cn001',
    patientId: 'p005',
    patientName: 'Samuel Ouma',
    doctorId: 's001',
    doctorName: 'Dr. Amara Osei',
    isSigned: true,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    subjective:
        'Patient presents with poorly controlled blood pressure despite current medications. Reports intermittent headache and blurred vision. Denies chest pain or SOB.',
    objective:
        'BP: 160/100 mmHg, HR: 82 bpm, SpO₂: 98%. Weight: 92kg. BMI: 28.4. GFR estimated at 58 ml/min.',
    assessment:
        'Uncontrolled hypertension. Worsening diabetic nephropathy — declining GFR.',
    plan:
        '1. Increase Enalapril to 20mg OD\n2. Add Amlodipine 5mg OD\n3. Repeat renal function in 4 weeks\n4. Dietary counselling — reduce salt & protein\n5. Review in 4 weeks',
    diagnoses: [
      'I10 — Essential Hypertension',
      'E11.65 — Type 2 DM with hyperglycaemia',
      'N18.2 — CKD Stage 2'
    ],
  ),
];

// ─── Mock Vitals ──────────────────────────────────────────────────────────────
final List<VitalSigns> mockVitals = [
  VitalSigns(
      id: 'v001',
      patientId: 'p005',
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      systolicBP: 160,
      diastolicBP: 100,
      heartRate: 82,
      spO2: 98,
      temperature: 36.8,
      respiratoryRate: 16,
      weight: 92,
      height: 175,
      recordedBy: 'Nurse Grace Achieng'),
  VitalSigns(
      id: 'v002',
      patientId: 'p001',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      systolicBP: 180,
      diastolicBP: 110,
      heartRate: 110,
      spO2: 94,
      temperature: 37.2,
      respiratoryRate: 22,
      recordedBy: 'Nurse Grace Achieng'),
];

// ─── Mock Lab Orders ──────────────────────────────────────────────────────────
final List<LabOrder> mockLabOrders = [
  LabOrder(
      id: 'lo001',
      patientId: 'p005',
      patientName: 'Samuel Ouma',
      orderedById: 's001',
      orderedByName: 'Dr. Amara Osei',
      orderedAt: DateTime.now().subtract(const Duration(hours: 2)),
      tests: ['CBC', 'Renal Function Tests', 'HbA1c', 'Lipid Profile'],
      status: 'pending',
      priority: 'routine',
      specimenType: 'Blood'),
  LabOrder(
      id: 'lo002',
      patientId: 'p002',
      patientName: 'Mary Njeri',
      orderedById: 's001',
      orderedByName: 'Dr. Amara Osei',
      orderedAt: DateTime.now().subtract(const Duration(hours: 1)),
      tests: ['Blood Culture', 'Malaria RDT', 'FBC'],
      status: 'processing',
      priority: 'urgent',
      specimenType: 'Blood'),
];

// ─── Mock Hospital KPIs ───────────────────────────────────────────────────────
const HospitalKPI mockKPIs = HospitalKPI(
  todayOPDCount: 142,
  currentIPDOccupancy: 87,
  totalBeds: 120,
  staffOnDuty: 34,
  avgWaitTimeMinutes: 23.0,
  pendingLabResults: 18,
  criticalAlerts: 3,
);

// ─── Mock Notifications ───────────────────────────────────────────────────────
final List<StaffNotification> mockNotifications = [
  StaffNotification(
      id: 'n001',
      title: 'Critical Lab Result',
      message:
          'James Mwangi — Troponin I: 2.8 ng/mL (CRITICAL HIGH). Immediate review required.',
      type: 'critical',
      time: DateTime.now().subtract(const Duration(minutes: 8))),
  StaffNotification(
      id: 'n002',
      title: 'Lab Results Ready',
      message:
          'Mary Njeri — Blood Culture, Malaria RDT, FBC results available for review.',
      type: 'lab',
      time: DateTime.now().subtract(const Duration(minutes: 25))),
  StaffNotification(
      id: 'n003',
      title: 'Appointment Changed',
      message:
          'Sarah Ochieng rescheduled her 2:00 PM telemedicine to 3:30 PM via PatientFlow.',
      type: 'appointment',
      time: DateTime.now().subtract(const Duration(hours: 1))),
  StaffNotification(
      id: 'n004',
      title: 'Prescription Ready',
      message:
          'Pharmacy: Rx #2024-4521 for Samuel Ouma is ready for collection.',
      type: 'system',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true),
  StaffNotification(
      id: 'n005',
      title: 'New Queue Entry',
      message:
          'Patient Thomas Gichuki checked in — Queue #7. Annual health check-up.',
      type: 'system',
      time: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true),
];

// ─── Mock Staff List ──────────────────────────────────────────────────────────
final List<StaffMember> mockStaffList = [
  const StaffMember(
      id: 's001',
      firstName: 'Amara',
      lastName: 'Osei',
      role: StaffRole.doctor,
      department: 'Internal Medicine',
      staffId: 'DOC-2024-001',
      specialization: 'Internal Medicine & Nephrology',
      email: 'a.osei@medflow.hospital',
      phone: '+254 700 001 001'),
  const StaffMember(
      id: 's007',
      firstName: 'Priya',
      lastName: 'Patel',
      role: StaffRole.doctor,
      department: 'Pediatrics',
      staffId: 'DOC-2024-002',
      specialization: 'Pediatrics',
      email: 'p.patel@medflow.hospital',
      phone: '+254 700 001 002'),
  const StaffMember(
      id: 's008',
      firstName: 'John',
      lastName: 'Kariuki',
      role: StaffRole.doctor,
      department: 'Emergency Medicine',
      staffId: 'DOC-2024-003',
      specialization: 'Emergency Medicine',
      email: 'j.kariuki@medflow.hospital',
      phone: '+254 700 001 003'),
  const StaffMember(
      id: 's002',
      firstName: 'Grace',
      lastName: 'Achieng',
      role: StaffRole.nurse,
      department: 'General Ward',
      staffId: 'NUR-2024-010',
      email: 'g.achieng@medflow.hospital',
      phone: '+254 700 002 002'),
  const StaffMember(
      id: 's009',
      firstName: 'Dennis',
      lastName: 'Njoroge',
      role: StaffRole.nurse,
      department: 'ICU',
      staffId: 'NUR-2024-011',
      email: 'd.njoroge@medflow.hospital',
      phone: '+254 700 002 003'),
  const StaffMember(
      id: 's003',
      firstName: 'Kwame',
      lastName: 'Mensah',
      role: StaffRole.admin,
      department: 'Administration',
      staffId: 'ADM-2024-001',
      email: 'k.mensah@medflow.hospital',
      phone: '+254 700 003 003'),
];

// ─── Ward Management Models ───────────────────────────────────────────────────
class Ward {
  final String id;
  final String name;
  final int totalBeds;
  final int occupiedBeds;
  final String supervisor;

  const Ward({
    required this.id,
    required this.name,
    required this.totalBeds,
    required this.occupiedBeds,
    required this.supervisor,
  });

  double get occupancyPercent => (occupiedBeds / totalBeds) * 100;
}

class InpatientBed {
  final String id;
  final String wardId;
  final String bedNumber;
  final BedStatus status;
  final String? patientId;
  final String? patientName;

  const InpatientBed({
    required this.id,
    required this.wardId,
    required this.bedNumber,
    required this.status,
    this.patientId,
    this.patientName,
  });

  String get patientInitials {
    if (patientName == null) return '';
    final parts = patientName!.split(' ');
    return parts.length >= 2 ? '${parts[0][0]}${parts[1][0]}' : patientName![0];
  }
}

class AdmissionRecord {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime admissionDate;
  final String reason;
  final String treatingDoctor;

  const AdmissionRecord({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.admissionDate,
    required this.reason,
    required this.treatingDoctor,
  });
}

// ─── Mock Wards & Beds ────────────────────────────────────────────────────────
final List<Ward> mockWards = [
  const Ward(
      id: 'w001',
      name: 'General Ward',
      totalBeds: 24,
      occupiedBeds: 18,
      supervisor: 'Grace Achieng'),
  const Ward(
      id: 'w002',
      name: 'ICU',
      totalBeds: 8,
      occupiedBeds: 6,
      supervisor: 'Dennis Njoroge'),
  const Ward(
      id: 'w003',
      name: 'Maternity',
      totalBeds: 12,
      occupiedBeds: 8,
      supervisor: 'Sarah Wanjiku'),
];

final List<InpatientBed> mockBeds = [
  // General Ward (w001)
  const InpatientBed(
      id: 'b001',
      wardId: 'w001',
      bedNumber: 'A1',
      status: BedStatus.occupied,
      patientId: 'p020',
      patientName: 'John Doe'),
  const InpatientBed(
      id: 'b002',
      wardId: 'w001',
      bedNumber: 'A2',
      status: BedStatus.occupied,
      patientId: 'p021',
      patientName: 'Jane Smith'),
  const InpatientBed(
      id: 'b003', wardId: 'w001', bedNumber: 'A3', status: BedStatus.cleaning),
  const InpatientBed(
      id: 'b004', wardId: 'w001', bedNumber: 'A4', status: BedStatus.empty),
  const InpatientBed(
      id: 'b005',
      wardId: 'w001',
      bedNumber: 'A5',
      status: BedStatus.occupied,
      patientId: 'p022',
      patientName: 'Mark Lee'),
  const InpatientBed(
      id: 'b006', wardId: 'w001', bedNumber: 'A6', status: BedStatus.empty),
  const InpatientBed(
      id: 'b007',
      wardId: 'w001',
      bedNumber: 'B1',
      status: BedStatus.occupied,
      patientId: 'p023',
      patientName: 'Sophie Turner'),
  const InpatientBed(
      id: 'b008', wardId: 'w001', bedNumber: 'B2', status: BedStatus.cleaning),

  // ICU (w002)
  const InpatientBed(
      id: 'b101',
      wardId: 'w002',
      bedNumber: 'ICU-1',
      status: BedStatus.occupied,
      patientId: 'p030',
      patientName: 'Mike Ross'),
  const InpatientBed(
      id: 'b102',
      wardId: 'w002',
      bedNumber: 'ICU-2',
      status: BedStatus.occupied,
      patientId: 'p031',
      patientName: 'Harvey Specter'),
  const InpatientBed(
      id: 'b103', wardId: 'w002', bedNumber: 'ICU-3', status: BedStatus.empty),
  const InpatientBed(
      id: 'b104',
      wardId: 'w002',
      bedNumber: 'ICU-4',
      status: BedStatus.cleaning),
];

final List<AdmissionRecord> mockAdmissions = [
  AdmissionRecord(
      id: 'ar001',
      patientId: 'p020',
      patientName: 'John Doe',
      admissionDate: DateTime.now().subtract(const Duration(days: 3)),
      reason: 'Post-appendectomy recovery',
      treatingDoctor: 'Dr. Amara Osei'),
  AdmissionRecord(
      id: 'ar002',
      patientId: 'p030',
      patientName: 'Mike Ross',
      admissionDate: DateTime.now().subtract(const Duration(days: 1)),
      reason: 'Severe respiratory distress',
      treatingDoctor: 'Dr. John Kariuki'),
];

// ─── Pharmacy Models ─────────────────────────────────────────────────────────
class PharmacyPrescription {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorName;
  final DateTime prescribedAt;
  final List<String> medications;
  final PrescriptionStatus status;
  final String? notes;

  const PharmacyPrescription({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.prescribedAt,
    required this.medications,
    required this.status,
    this.notes,
  });
}

final List<PharmacyPrescription> mockPharmacyPrescriptions = [
  PharmacyPrescription(
    id: 'rx001',
    patientId: 'p005',
    patientName: 'Samuel Ouma',
    doctorName: 'Dr. Amara Osei',
    prescribedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    medications: ['Enalapril 20mg OD (30 days)', 'Amlodipine 5mg OD (30 days)'],
    status: PrescriptionStatus.pending,
    notes: 'Patient waiting in pharmacy lobby',
  ),
  PharmacyPrescription(
    id: 'rx002',
    patientId: 'p002',
    patientName: 'Mary Njeri',
    doctorName: 'Dr. John Kariuki',
    prescribedAt: DateTime.now().subtract(const Duration(hours: 2)),
    medications: ['Amoxicillin 500mg TDS (7 days)', 'Paracetamol 1g PRN'],
    status: PrescriptionStatus.processing,
  ),
  PharmacyPrescription(
    id: 'rx003',
    patientId: 'p004',
    patientName: 'Alice Wambua',
    doctorName: 'Dr. Priya Patel',
    prescribedAt: DateTime.now().subtract(const Duration(hours: 4)),
    medications: ['Sumatriptan 50mg PRN (10 tabs)'],
    status: PrescriptionStatus.dispensed,
  ),
];
