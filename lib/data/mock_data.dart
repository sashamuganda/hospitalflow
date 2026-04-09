// ─── User & Auth ───────────────────────────────────────────────────────────────

// ─── User & Auth ───────────────────────────────────────────────────────────────

enum BiologicalSex { male, female }

class MockUser {
  static const String id = 'patient_001';
  static const String firstName = 'Amara';
  static const String lastName = 'Okonkwo';
  static const String fullName = 'Amara Okonkwo';
  static const String email = 'amara.okonkwo@gmail.com';
  static const String phone = '+234 812 345 6789';
  static const String dateOfBirth = '1993-07-14';
  static const int age = 32;
  static const BiologicalSex sex = BiologicalSex.female;
  static const String bloodType = 'O+';
  static const String nationality = 'Nigerian';
  static const String country = 'Nigeria';
  static const String emergencyContact = 'Chidi Okonkwo';
  static const String emergencyPhone = '+234 803 456 7890';
  static const List<String> allergies = ['Penicillin', 'Peanuts'];
  static const List<String> conditions = ['Hypertension', 'Asthma'];
  static const String healthScore = '78';
}

// ─── Appointments ──────────────────────────────────────────────────────────────

class MockAppointment {
  final String id;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorAvatar;
  final String facility;
  final String facilityAddress;
  final DateTime dateTime;
  final String type; // 'in-person' | 'telemedicine'
  final String status; // 'upcoming' | 'past' | 'cancelled'
  final String? notes;
  final String? visitSummary;

  const MockAppointment({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorAvatar,
    required this.facility,
    required this.facilityAddress,
    required this.dateTime,
    required this.type,
    required this.status,
    this.notes,
    this.visitSummary,
  });
}

final List<MockAppointment> mockAppointments = [
  MockAppointment(
    id: 'appt_001',
    doctorName: 'Dr. Ngozi Adeyemi',
    doctorSpecialty: 'Cardiology',
    doctorAvatar: 'NA',
    facility: 'Lagos University Teaching Hospital',
    facilityAddress: 'Idi-Araba, Surulere, Lagos',
    dateTime: DateTime.now().add(const Duration(days: 1, hours: 9)),
    type: 'in-person',
    status: 'upcoming',
    notes: 'Follow-up on blood pressure management.',
  ),
  MockAppointment(
    id: 'appt_002',
    doctorName: 'Dr. Emeka Eze',
    doctorSpecialty: 'General Practice',
    doctorAvatar: 'EE',
    facility: 'PatientFlow Telemedicine',
    facilityAddress: 'Virtual',
    dateTime: DateTime.now().add(const Duration(days: 5, hours: 14)),
    type: 'telemedicine',
    status: 'upcoming',
    notes: 'Monthly wellness check-in.',
  ),
  MockAppointment(
    id: 'appt_003',
    doctorName: 'Dr. Fatima Al-Hassan',
    doctorSpecialty: 'Gynecology',
    doctorAvatar: 'FA',
    facility: 'Reddington Hospital',
    facilityAddress: 'Victoria Island, Lagos',
    dateTime: DateTime.now().subtract(const Duration(days: 14)),
    type: 'in-person',
    status: 'past',
    notes: 'Annual gynecological exam.',
    visitSummary: 'All results within normal range. Continue iron supplementation. Next visit in 12 months.',
  ),
  MockAppointment(
    id: 'appt_004',
    doctorName: 'Dr. Yemi Balogun',
    doctorSpecialty: 'Pulmonology',
    doctorAvatar: 'YB',
    facility: 'Eko Hospital',
    facilityAddress: 'Ikeja, Lagos',
    dateTime: DateTime.now().subtract(const Duration(days: 45)),
    type: 'in-person',
    status: 'past',
    notes: 'Asthma medication review.',
    visitSummary: 'Inhaler technique reviewed. Switched to Symbicort 200/6mcg. Follow-up in 6 weeks.',
  ),
  MockAppointment(
    id: 'appt_005',
    doctorName: 'Dr. Chukwuma Obi',
    doctorSpecialty: 'Dermatology',
    doctorAvatar: 'CO',
    facility: 'PatientFlow Telemedicine',
    facilityAddress: 'Virtual',
    dateTime: DateTime.now().subtract(const Duration(days: 3)),
    type: 'telemedicine',
    status: 'cancelled',
  ),
];

// ─── Medications ───────────────────────────────────────────────────────────────

class MockMedication {
  final String id;
  final String name;
  final String genericName;
  final String dosage;
  final String form;
  final String frequency;
  final String timing;
  final String prescribingDoctor;
  final DateTime startDate;
  final DateTime? endDate;
  final int daysRemaining;
  final bool isActive;
  final String? specialInstructions;

  const MockMedication({
    required this.id,
    required this.name,
    required this.genericName,
    required this.dosage,
    required this.form,
    required this.frequency,
    required this.timing,
    required this.prescribingDoctor,
    required this.startDate,
    this.endDate,
    required this.daysRemaining,
    required this.isActive,
    this.specialInstructions,
  });
}

final List<MockMedication> mockMedications = [
  MockMedication(
    id: 'med_001',
    name: 'Amlodipine',
    genericName: 'Amlodipine Besylate',
    dosage: '5mg',
    form: 'Tablet',
    frequency: 'Once daily',
    timing: 'Morning, with or without food',
    prescribingDoctor: 'Dr. Ngozi Adeyemi',
    startDate: DateTime.now().subtract(const Duration(days: 30)),
    endDate: DateTime.now().add(const Duration(days: 60)),
    daysRemaining: 60,
    isActive: true,
    specialInstructions: 'Do not discontinue without consulting your doctor.',
  ),
  MockMedication(
    id: 'med_002',
    name: 'Symbicort',
    genericName: 'Budesonide/Formoterol',
    dosage: '200/6mcg',
    form: 'Inhaler',
    frequency: 'Twice daily',
    timing: 'Morning and evening',
    prescribingDoctor: 'Dr. Yemi Balogun',
    startDate: DateTime.now().subtract(const Duration(days: 45)),
    endDate: DateTime.now().add(const Duration(days: 3)),
    daysRemaining: 3,
    isActive: true,
    specialInstructions: 'Rinse mouth after each use. Do not stop suddenly.',
  ),
  MockMedication(
    id: 'med_003',
    name: 'Ferrous Sulphate',
    genericName: 'Iron (II) Sulphate',
    dosage: '200mg',
    form: 'Tablet',
    frequency: 'Twice daily',
    timing: 'Morning and evening, with orange juice for absorption',
    prescribingDoctor: 'Dr. Fatima Al-Hassan',
    startDate: DateTime.now().subtract(const Duration(days: 14)),
    endDate: DateTime.now().add(const Duration(days: 76)),
    daysRemaining: 76,
    isActive: true,
    specialInstructions: 'Take with vitamin C to improve absorption. May cause dark stools.',
  ),
  MockMedication(
    id: 'med_004',
    name: 'Azithromycin',
    genericName: 'Azithromycin Dihydrate',
    dosage: '500mg',
    form: 'Tablet',
    frequency: 'Once daily',
    timing: 'Morning',
    prescribingDoctor: 'Dr. Emeka Eze',
    startDate: DateTime.now().subtract(const Duration(days: 120)),
    endDate: DateTime.now().subtract(const Duration(days: 115)),
    daysRemaining: 0,
    isActive: false,
  ),
];

// ─── Lab Results ───────────────────────────────────────────────────────────────

class MockLabResult {
  final String id;
  final String testName;
  final String requestingDoctor;
  final DateTime dateOrdered;
  final DateTime dateReceived;
  final String status; // 'normal' | 'borderline' | 'critical'
  final List<MockLabMarker> markers;

  const MockLabResult({
    required this.id,
    required this.testName,
    required this.requestingDoctor,
    required this.dateOrdered,
    required this.dateReceived,
    required this.status,
    required this.markers,
  });
}

class MockLabMarker {
  final String name;
  final String value;
  final String unit;
  final String referenceRange;
  final String status;

  const MockLabMarker({
    required this.name,
    required this.value,
    required this.unit,
    required this.referenceRange,
    required this.status,
  });
}

final List<MockLabResult> mockLabResults = [
  MockLabResult(
    id: 'lab_001',
    testName: 'Complete Blood Count (CBC)',
    requestingDoctor: 'Dr. Ngozi Adeyemi',
    dateOrdered: DateTime.now().subtract(const Duration(days: 16)),
    dateReceived: DateTime.now().subtract(const Duration(days: 14)),
    status: 'borderline',
    markers: const [
      MockLabMarker(name: 'Hemoglobin', value: '10.8', unit: 'g/dL', referenceRange: '12.0–16.0', status: 'borderline'),
      MockLabMarker(name: 'White Blood Cells', value: '6.5', unit: 'K/μL', referenceRange: '4.5–11.0', status: 'normal'),
      MockLabMarker(name: 'Platelets', value: '250', unit: 'K/μL', referenceRange: '150–400', status: 'normal'),
      MockLabMarker(name: 'Hematocrit', value: '33%', unit: '%', referenceRange: '36–46%', status: 'borderline'),
    ],
  ),
  MockLabResult(
    id: 'lab_002',
    testName: 'Lipid Panel',
    requestingDoctor: 'Dr. Ngozi Adeyemi',
    dateOrdered: DateTime.now().subtract(const Duration(days: 30)),
    dateReceived: DateTime.now().subtract(const Duration(days: 28)),
    status: 'normal',
    markers: const [
      MockLabMarker(name: 'Total Cholesterol', value: '185', unit: 'mg/dL', referenceRange: '<200', status: 'normal'),
      MockLabMarker(name: 'LDL', value: '105', unit: 'mg/dL', referenceRange: '<130', status: 'normal'),
      MockLabMarker(name: 'HDL', value: '55', unit: 'mg/dL', referenceRange: '>50', status: 'normal'),
      MockLabMarker(name: 'Triglycerides', value: '125', unit: 'mg/dL', referenceRange: '<150', status: 'normal'),
    ],
  ),
  MockLabResult(
    id: 'lab_003',
    testName: 'Blood Glucose (Fasting)',
    requestingDoctor: 'Dr. Emeka Eze',
    dateOrdered: DateTime.now().subtract(const Duration(days: 60)),
    dateReceived: DateTime.now().subtract(const Duration(days: 58)),
    status: 'normal',
    markers: const [
      MockLabMarker(name: 'Fasting Glucose', value: '88', unit: 'mg/dL', referenceRange: '70–100', status: 'normal'),
    ],
  ),
];

// ─── Vitals Data ───────────────────────────────────────────────────────────────

class VitalReading {
  final DateTime timestamp;
  final double value;
  final double? value2; // For BP: systolic/diastolic

  const VitalReading({required this.timestamp, required this.value, this.value2});
}

class MockVitals {
  static List<VitalReading> bloodPressure = List.generate(14, (i) => VitalReading(
    timestamp: DateTime.now().subtract(Duration(days: 13 - i)),
    value: 118 + (i % 3) * 4.0 + (i.isEven ? 2 : -1),   // systolic
    value2: 76 + (i % 3) * 2.0 + (i.isOdd ? 1 : -1),     // diastolic
  ));

  static List<VitalReading> heartRate = List.generate(14, (i) => VitalReading(
    timestamp: DateTime.now().subtract(Duration(days: 13 - i)),
    value: 72 + (i % 5) * 3.0 - 4,
  ));

  static List<VitalReading> weight = List.generate(30, (i) => VitalReading(
    timestamp: DateTime.now().subtract(Duration(days: 29 - i)),
    value: 68.2 - (i * 0.02),
  ));

  static List<VitalReading> bloodGlucose = List.generate(7, (i) => VitalReading(
    timestamp: DateTime.now().subtract(Duration(days: 6 - i)),
    value: 86 + (i % 3) * 3.0,
  ));

  static double get latestBP => bloodPressure.last.value;
  static double get latestBPDiastolic => bloodPressure.last.value2 ?? 80;
  static double get latestHR => heartRate.last.value;
  static double get latestWeight => weight.last.value;
  static double get latestGlucose => bloodGlucose.last.value;
  static double get bmi => latestWeight / (1.65 * 1.65);
}

// ─── Doctors ───────────────────────────────────────────────────────────────────

class MockDoctor {
  final String id;
  final String name;
  final String specialty;
  final String qualifications;
  final String hospital;
  final int yearsExperience;
  final double rating;
  final int reviewCount;
  final String consultationFee;
  final String nextSlot;
  final String bio;
  final String avatar;
  final List<String> languages;
  final bool availableToday;

  const MockDoctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.qualifications,
    required this.hospital,
    required this.yearsExperience,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.nextSlot,
    required this.bio,
    required this.avatar,
    required this.languages,
    required this.availableToday,
  });
}

final List<MockDoctor> mockDoctors = [
  const MockDoctor(
    id: 'doc_001',
    name: 'Dr. Ngozi Adeyemi',
    specialty: 'Cardiology',
    qualifications: 'MBBS, FWACP, MD (Cardiology)',
    hospital: 'Lagos University Teaching Hospital',
    yearsExperience: 14,
    rating: 4.9,
    reviewCount: 312,
    consultationFee: '₦8,000',
    nextSlot: 'Today, 4:00 PM',
    bio: 'Dr. Adeyemi is a consultant cardiologist with over 14 years of experience in cardiovascular disease management, hypertension, and heart failure care.',
    avatar: 'NA',
    languages: ['English', 'Yoruba'],
    availableToday: true,
  ),
  const MockDoctor(
    id: 'doc_002',
    name: 'Dr. Emeka Eze',
    specialty: 'General Practice',
    qualifications: 'MBBS, MCGP',
    hospital: 'PatientFlow Digital Clinic',
    yearsExperience: 8,
    rating: 4.7,
    reviewCount: 541,
    consultationFee: '₦4,000',
    nextSlot: 'Today, 6:30 PM',
    bio: 'Dr. Eze is a highly-rated general practitioner focused on primary care, preventive health, and chronic disease management. Available daily for virtual consultations.',
    avatar: 'EE',
    languages: ['English', 'Igbo'],
    availableToday: true,
  ),
  const MockDoctor(
    id: 'doc_003',
    name: 'Dr. Fatima Al-Hassan',
    specialty: 'Gynecology & Obstetrics',
    qualifications: 'MBBS, FWACS (OB/GYN)',
    hospital: 'Reddington Hospital',
    yearsExperience: 11,
    rating: 4.8,
    reviewCount: 229,
    consultationFee: '₦7,500',
    nextSlot: 'Tomorrow, 10:00 AM',
    bio: 'Dr. Al-Hassan specializes in women\'s reproductive health, high-risk obstetrics, and minimally invasive gynecological procedures.',
    avatar: 'FA',
    languages: ['English', 'Hausa', 'Arabic'],
    availableToday: false,
  ),
  const MockDoctor(
    id: 'doc_004',
    name: 'Dr. Kofi Mensah',
    specialty: 'Mental Health',
    qualifications: 'MBChB, MRCPsych',
    hospital: 'PatientFlow Digital Clinic',
    yearsExperience: 9,
    rating: 4.9,
    reviewCount: 187,
    consultationFee: '₦6,000',
    nextSlot: 'Today, 7:00 PM',
    bio: 'Dr. Mensah is a board-certified psychiatrist with a focus on anxiety, depression, trauma, and burnout recovery in working professionals.',
    avatar: 'KM',
    languages: ['English', 'Twi'],
    availableToday: true,
  ),
  const MockDoctor(
    id: 'doc_005',
    name: 'Dr. Aisha Ibrahim',
    specialty: 'Dermatology',
    qualifications: 'MBBS, FMCP (Dermatology)',
    hospital: 'National Hospital Abuja',
    yearsExperience: 7,
    rating: 4.6,
    reviewCount: 143,
    consultationFee: '₦5,500',
    nextSlot: 'Tomorrow, 2:00 PM',
    bio: 'Dr. Ibrahim specialises in medical and cosmetic dermatology, with expertise in skin conditions common to melanin-rich skin types.',
    avatar: 'AI',
    languages: ['English', 'Hausa'],
    availableToday: false,
  ),
];

// ─── Facilities ────────────────────────────────────────────────────────────────

class MockFacility {
  final String id;
  final String name;
  final String type; // 'hospital' | 'clinic' | 'pharmacy' | 'lab'
  final String address;
  final String distance;
  final String hours;
  final double rating;
  final String phone;
  final List<String> specialties;
  final bool openNow;

  const MockFacility({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.distance,
    required this.hours,
    required this.rating,
    required this.phone,
    required this.specialties,
    required this.openNow,
  });
}

final List<MockFacility> mockFacilities = [
  const MockFacility(
    id: 'fac_001',
    name: 'Lagos University Teaching Hospital',
    type: 'hospital',
    address: 'Idi-Araba, Surulere, Lagos',
    distance: '2.3 km',
    hours: 'Open 24 hours',
    rating: 4.2,
    phone: '+234 1 774 5051',
    specialties: ['Cardiology', 'Neurology', 'Oncology', 'Pediatrics', 'Emergency'],
    openNow: true,
  ),
  const MockFacility(
    id: 'fac_002',
    name: 'Reddington Hospital',
    type: 'hospital',
    address: '12 Idowu Martins, Victoria Island, Lagos',
    distance: '4.8 km',
    hours: 'Open 24 hours',
    rating: 4.7,
    phone: '+234 1 461 2300',
    specialties: ['Gynecology', 'Surgery', 'ICU', 'Cardiology'],
    openNow: true,
  ),
  const MockFacility(
    id: 'fac_003',
    name: 'MedPlus Pharmacy — VI',
    type: 'pharmacy',
    address: 'Plot 22, Akin Adesola, Victoria Island',
    distance: '1.2 km',
    hours: '8:00 AM – 9:00 PM',
    rating: 4.4,
    phone: '+234 1 278 8888',
    specialties: [],
    openNow: true,
  ),
  const MockFacility(
    id: 'fac_004',
    name: 'Alpha Medical Laboratory',
    type: 'lab',
    address: '45 Bode Thomas, Surulere, Lagos',
    distance: '0.9 km',
    hours: '7:00 AM – 6:00 PM',
    rating: 4.5,
    phone: '+234 812 111 2222',
    specialties: ['Haematology', 'Biochemistry', 'Microbiology', 'Immunology'],
    openNow: true,
  ),
  const MockFacility(
    id: 'fac_005',
    name: 'Eko Hospital & Specialist Centre',
    type: 'hospital',
    address: '31 Mobolaji Bank Anthony Way, Ikeja',
    distance: '11.4 km',
    hours: 'Open 24 hours',
    rating: 4.6,
    phone: '+234 1 493 0000',
    specialties: ['Pulmonology', 'Endocrinology', 'Orthopedics', 'Ophthalmology'],
    openNow: true,
  ),
];

// ─── Drugs ─────────────────────────────────────────────────────────────────────

class MockDrug {
  final String id;
  final String name;
  final String genericName;
  final String drugClass;
  final String use;
  final List<String> sideEffects;
  final List<String> interactions;
  final String dosageGuidance;
  final String storage;
  final bool hasGenericAlternative;

  const MockDrug({
    required this.id,
    required this.name,
    required this.genericName,
    required this.drugClass,
    required this.use,
    required this.sideEffects,
    required this.interactions,
    required this.dosageGuidance,
    required this.storage,
    required this.hasGenericAlternative,
  });
}

final List<MockDrug> mockDrugs = [
  const MockDrug(
    id: 'drug_001',
    name: 'Norvasc',
    genericName: 'Amlodipine Besylate',
    drugClass: 'Calcium Channel Blocker',
    use: 'Used to treat high blood pressure (hypertension) and chest pain (angina). It works by relaxing blood vessels so the heart does not have to pump as hard.',
    sideEffects: ['Swelling of ankles or feet', 'Feeling flushed', 'Dizziness', 'Fatigue', 'Nausea'],
    interactions: ['Simvastatin (high doses)', 'Cyclosporine', 'Tacrolimus'],
    dosageGuidance: 'Typically 5–10mg once daily. Take at the same time each day.',
    storage: 'Store below 30°C. Keep away from moisture and light.',
    hasGenericAlternative: true,
  ),
];

// ─── Diagnoses ─────────────────────────────────────────────────────────────────

class MockDiagnosis {
  final String id;
  final String condition;
  final String icdCode;
  final String diagnosedBy;
  final DateTime date;
  final bool isChronic;
  final String description;

  const MockDiagnosis({
    required this.id,
    required this.condition,
    required this.icdCode,
    required this.diagnosedBy,
    required this.date,
    required this.isChronic,
    required this.description,
  });
}

final List<MockDiagnosis> mockDiagnoses = [
  MockDiagnosis(
    id: 'diag_001',
    condition: 'Essential Hypertension',
    icdCode: 'I10',
    diagnosedBy: 'Dr. Ngozi Adeyemi',
    date: DateTime.now().subtract(const Duration(days: 365)),
    isChronic: true,
    description: 'A long-term condition where the blood pressure in the arteries is persistently elevated. Being managed with Amlodipine and lifestyle modification.',
  ),
  MockDiagnosis(
    id: 'diag_002',
    condition: 'Mild Persistent Asthma',
    icdCode: 'J45.3',
    diagnosedBy: 'Dr. Yemi Balogun',
    date: DateTime.now().subtract(const Duration(days: 730)),
    isChronic: true,
    description: 'Recurring episodes of wheezing, chest tightness, and shortness of breath triggered by exercise and allergens. Managed with Symbicort inhaler.',
  ),
  MockDiagnosis(
    id: 'diag_003',
    condition: 'Iron Deficiency Anaemia',
    icdCode: 'D50.9',
    diagnosedBy: 'Dr. Fatima Al-Hassan',
    date: DateTime.now().subtract(const Duration(days: 14)),
    isChronic: false,
    description: 'Low haemoglobin level due to insufficient iron stores. Currently being treated with oral iron supplementation.',
  ),
];

// ─── Health Tips ───────────────────────────────────────────────────────────────

class MockHealthTip {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String readTime;
  final String tag;

  const MockHealthTip({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.readTime,
    required this.tag,
  });
}

final List<MockHealthTip> mockHealthTips = [
  const MockHealthTip(
    id: 'tip_001',
    title: 'Managing Hypertension Through Diet',
    summary: 'The DASH diet has been clinically proven to reduce blood pressure by up to 11 mmHg. Here\'s how to get started with small, sustainable changes.',
    category: 'Cardiology',
    readTime: '4 min read',
    tag: 'For You',
  ),
  const MockHealthTip(
    id: 'tip_002',
    title: 'Understanding Your Asthma Triggers',
    summary: 'Identifying and avoiding your personal asthma triggers is the single most effective step in reducing the frequency of flare-ups.',
    category: 'Pulmonology',
    readTime: '3 min read',
    tag: 'For You',
  ),
  const MockHealthTip(
    id: 'tip_003',
    title: 'Iron-Rich Foods to Support Your Recovery',
    summary: 'Beyond supplementation, your diet can play a powerful role in restoring iron levels. Learn which foods give you the biggest boost.',
    category: 'Nutrition',
    readTime: '5 min read',
    tag: 'For You',
  ),
  const MockHealthTip(
    id: 'tip_004',
    title: 'Sleep & Blood Pressure: The Overlooked Connection',
    summary: 'Getting less than 6 hours of sleep consistently can raise your blood pressure by up to 8 mmHg. Small sleep improvements have outsized cardiovascular benefits.',
    category: 'Cardiology',
    readTime: '3 min read',
    tag: 'Trending',
  ),
  const MockHealthTip(
    id: 'tip_005',
    title: 'When to Use Your Rescue Inhaler vs. Your Maintenance Inhaler',
    summary: 'Many asthma patients confuse the two. Understanding the difference could prevent a hospital visit.',
    category: 'Pulmonology',
    readTime: '4 min read',
    tag: 'Education',
  ),
];

// ─── Symptoms ──────────────────────────────────────────────────────────────────

const List<String> mockSymptoms = [
  'Headache', 'Fever', 'Cough', 'Shortness of breath', 'Chest pain',
  'Fatigue', 'Nausea', 'Vomiting', 'Diarrhoea', 'Abdominal pain',
  'Dizziness', 'Back pain', 'Joint pain', 'Skin rash', 'Itching',
  'Swollen legs', 'Palpitations', 'Loss of appetite', 'Night sweats',
  'Blurred vision', 'Sore throat', 'Runny nose', 'Muscle aches',
  'Frequent urination', 'Painful urination', 'Anxiety', 'Insomnia',
];

// ─── Notifications ─────────────────────────────────────────────────────────────

class MockNotification {
  final String id;
  final String title;
  final String body;
  final String type;
  final DateTime timestamp;
  final bool isRead;
  final String? route;

  const MockNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.route,
  });
}

final List<MockNotification> mockNotifications = [
  MockNotification(
    id: 'notif_001',
    title: 'Appointment Tomorrow',
    body: 'You have an appointment with Dr. Ngozi Adeyemi tomorrow at 9:00 AM.',
    type: 'appointment',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
    route: '/appointments/detail/appt_001',
  ),
  MockNotification(
    id: 'notif_002',
    title: 'Medication Reminder',
    body: 'Time to take your Amlodipine 5mg.',
    type: 'medication',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: false,
    route: '/medications/detail/med_001',
  ),
  MockNotification(
    id: 'notif_003',
    title: 'Lab Results Available',
    body: 'Your Complete Blood Count results are ready to view.',
    type: 'lab',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
    route: '/records/lab/lab_001',
  ),
  MockNotification(
    id: 'notif_004',
    title: 'Refill Reminder',
    body: 'Your Symbicort inhaler has 3 days remaining. Time to refill.',
    type: 'refill',
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
    isRead: true,
    route: '/medications/refill',
  ),
  MockNotification(
    id: 'notif_005',
    title: 'Health Tip',
    body: 'New article: Managing Hypertension Through Diet — 4 min read',
    type: 'tip',
    timestamp: DateTime.now().subtract(const Duration(days: 4)),
    isRead: true,
    route: '/health-tips',
  ),
];
