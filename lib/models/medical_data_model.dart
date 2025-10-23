// lib/models/medical_data_model.dart

/// Main model for medical data containing patient information,
/// blood tests, prescriptions, and medical history
class MedicalData {
  final PatientInfo? patientInfo;
  final List<BloodTest> bloodTests;
  final List<Prescription> prescriptions;
  final List<MedicalHistoryItem> medicalHistory;

  MedicalData({
    this.patientInfo,
    this.bloodTests = const [],
    this.prescriptions = const [],
    this.medicalHistory = const [],
  });

  /// Factory constructor to create MedicalData from JSON
  factory MedicalData.fromJson(Map<String, dynamic> json) {
    return MedicalData(
      patientInfo: json['patient_info'] != null
          ? PatientInfo.fromJson(json['patient_info'])
          : null,
      bloodTests: (json['blood_tests'] as List?)
              ?.map((e) => BloodTest.fromJson(e))
              .toList() ??
          [],
      prescriptions: (json['prescriptions'] as List?)
              ?.map((e) => Prescription.fromJson(e))
              .toList() ??
          [],
      medicalHistory: (json['medical_history'] as List?)
              ?.map((e) => MedicalHistoryItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// Check if there is any medical data available
  bool get hasData =>
      patientInfo != null ||
      bloodTests.isNotEmpty ||
      prescriptions.isNotEmpty ||
      medicalHistory.isNotEmpty;
}

/// Model for patient basic information
class PatientInfo {
  final String name;
  final int age;
  final String bloodType;
  final String allergies;

  PatientInfo({
    required this.name,
    required this.age,
    required this.bloodType,
    required this.allergies,
  });

  /// Factory constructor to create PatientInfo from JSON
  factory PatientInfo.fromJson(Map<String, dynamic> json) {
    return PatientInfo(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      bloodType: json['blood_type'] ?? '',
      allergies: json['allergies'] ?? '',
    );
  }
}

/// Model for blood test results
class BloodTest {
  final String date;
  final double hemoglobin;          // Measured in g/dL
  final double whiteBloodCells;     // Measured in 10^3/μL
  final double platelets;           // Measured in 10^3/μL
  final double glucose;             // Measured in mg/dL
  final double cholesterol;         // Measured in mg/dL
  final String notes;

  BloodTest({
    required this.date,
    required this.hemoglobin,
    required this.whiteBloodCells,
    required this.platelets,
    required this.glucose,
    required this.cholesterol,
    required this.notes,
  });

  /// Factory constructor to create BloodTest from JSON
  factory BloodTest.fromJson(Map<String, dynamic> json) {
    return BloodTest(
      date: json['date'] ?? '',
      hemoglobin: (json['hemoglobin'] ?? 0).toDouble(),
      whiteBloodCells: (json['white_blood_cells'] ?? 0).toDouble(),
      platelets: (json['platelets'] ?? 0).toDouble(),
      glucose: (json['glucose'] ?? 0).toDouble(),
      cholesterol: (json['cholesterol'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
    );
  }
}

/// Model for medication prescriptions
class Prescription {
  final String medication;
  final String dosage;
  final String frequency;
  final String startDate;
  final String notes;

  Prescription({
    required this.medication,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.notes,
  });

  /// Factory constructor to create Prescription from JSON
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      medication: json['medication'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      startDate: json['start_date'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
}

/// Model for medical history records
class MedicalHistoryItem {
  final String condition;
  final String diagnosedDate;
  final String status;              // e.g., "Active", "Resolved", "Chronic"
  final String notes;

  MedicalHistoryItem({
    required this.condition,
    required this.diagnosedDate,
    required this.status,
    required this.notes,
  });

  /// Factory constructor to create MedicalHistoryItem from JSON
  factory MedicalHistoryItem.fromJson(Map<String, dynamic> json) {
    return MedicalHistoryItem(
      condition: json['condition'] ?? '',
      diagnosedDate: json['diagnosed_date'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
}
