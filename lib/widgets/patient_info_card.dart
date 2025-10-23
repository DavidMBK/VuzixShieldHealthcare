// lib/widgets/patient_info_card.dart

import 'package:flutter/material.dart';
import '../models/medical_data_model.dart';
import '../utils/app_styles.dart';

/// Widget that displays patient information in a card format.
/// Shows basic patient data (name, age, current problem) and
/// additional medical information (blood type, allergies) if available
/// from the database.
class PatientInfoCard extends StatelessWidget {
  /// Patient's name
  final String name;
  
  /// Patient's age
  final String age;
  
  /// Summary of the patient's current medical problem
  final String problem;
  
  /// Additional patient information from database (optional)
  final PatientInfo? patientInfo;

  const PatientInfoCard({
    super.key,
    required this.name,
    required this.age,
    required this.problem,
    this.patientInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card header
          Text(
            'PATIENT',
            style: AppStyles.sectionTitle.copyWith(
              color: AppStyles.secondaryAccent,
            ),
          ),
          const SizedBox(height: 8),
          
          // Basic patient information collected during conversation
          if (name.isNotEmpty) _buildRow('Name', name),
          if (age.isNotEmpty) _buildRow('Age', age),
          if (problem.isNotEmpty) _buildRow('Problem', problem),
          
          // Additional information from database (if available)
          if (patientInfo != null) ...[
            const Divider(color: Colors.cyan, height: 16),
            Text(
              'ADDITIONAL INFO',
              style: AppStyles.sectionTitle.copyWith(
                color: AppStyles.primaryAccent,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 6),
            _buildRow('Blood Type', patientInfo!.bloodType),
            _buildRow('Allergies', patientInfo!.allergies, maxLines: 2),
          ],
        ],
      ),
    );
  }

  /// Builds a single row displaying a label-value pair.
  /// 
  /// [label] - The field label (e.g., "Name", "Age")
  /// [value] - The field value to display
  /// [maxLines] - Maximum number of lines before truncating (default: 1)
  Widget _buildRow(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label: $value',
        textAlign: TextAlign.right,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          height: 1.3,
        ),
      ),
    );
  }
}
