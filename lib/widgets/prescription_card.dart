// lib/widgets/prescription_card.dart

import 'package:flutter/material.dart';
import '../models/medical_data_model.dart';
import '../utils/app_styles.dart';

/// Widget that displays active medication prescriptions in a card format.
/// Shows medication names, dosages, and frequency of administration.
/// Used to display current therapies retrieved from the medical database.
class PrescriptionCard extends StatelessWidget {
  /// List of active prescriptions to display
  final List<Prescription> prescriptions;

  const PrescriptionCard({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    // Don't render if there are no prescriptions
    if (prescriptions.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card header with title
          Row(
            children: [
              const SizedBox(width: 6),
              Text(
                'ACTIVE MEDICATIONS',
                style: AppStyles.sectionTitle.copyWith(
                  color: AppStyles.prescriptionColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // List of prescription items
          ...prescriptions.map((p) => _buildPrescriptionItem(p)),
        ],
      ),
    );
  }

  /// Builds a single prescription item with medication details.
  /// 
  /// Displays the medication name with dosage and frequency of administration.
  /// Each prescription is shown in a separate container with subtle background.
  Widget _buildPrescriptionItem(Prescription prescription) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medication name and dosage
          Text(
            '${prescription.medication} ${prescription.dosage}',
            style: AppStyles.cardTitle.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 2),
          // Frequency of administration (e.g., "Once daily", "3 times daily")
          Text(
            prescription.frequency,
            style: AppStyles.cardSubtitle.copyWith(fontSize: 9),
          ),
        ],
      ),
    );
  }
}
