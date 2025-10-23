// lib/widgets/blood_test_card.dart

import 'package:flutter/material.dart';
import '../models/medical_data_model.dart';
import '../utils/app_styles.dart';

/// Widget that displays blood test results in a card format.
/// Shows test dates and key blood work values including hemoglobin,
/// white blood cells, platelets, glucose, and cholesterol levels.
/// Highlights values that are outside normal ranges.
class BloodTestCard extends StatelessWidget {
  /// List of blood test records to display
  final List<BloodTest> bloodTests;

  const BloodTestCard({super.key, required this.bloodTests});

  @override
  Widget build(BuildContext context) {
    // Don't render if there are no blood tests
    if (bloodTests.isEmpty) return const SizedBox.shrink();

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
                'BLOOD TESTS',
                style: AppStyles.sectionTitle.copyWith(
                  color: AppStyles.bloodColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Display up to 2 most recent blood tests
          ...bloodTests.take(2).map((test) => _buildTestItem(test)),
        ],
      ),
    );
  }

  /// Builds a single blood test result item with all values and notes.
  /// 
  /// Displays the test date, key blood work values, and any clinical notes.
  /// Values outside normal ranges are highlighted in orange.
  Widget _buildTestItem(BloodTest test) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Test date
          Text(
            'Date: ${test.date}',
            style: AppStyles.cardSubtitle.copyWith(fontSize: 9),
          ),
          const SizedBox(height: 4),
          // Blood work values in a wrapped layout
          Wrap(
            spacing: 12,
            runSpacing: 2,
            children: [
              _buildValue('Hb', '${test.hemoglobin}', 'g/dL'),
              _buildValue('WBC', '${test.whiteBloodCells}', '10³/μL'),
              _buildValue('PLT', '${test.platelets}', '10³/μL'),
              _buildValue('Glucose', '${test.glucose}', 'mg/dL'),
              _buildValue('Chol.', '${test.cholesterol}', 'mg/dL',
                  isWarning: test.cholesterol > 200),
            ],
          ),
          // Clinical notes if available
          if (test.notes.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Note: ${test.notes}',
              style: AppStyles.notes,
            ),
          ],
        ],
      ),
    );
  }

  /// Builds a single blood work value display with label, value, and unit.
  /// 
  /// [label] - Short name for the test (e.g., "Hb", "WBC")
  /// [value] - The test result value
  /// [unit] - The measurement unit (e.g., "g/dL", "mg/dL")
  /// [isWarning] - If true, highlights the value in orange to indicate abnormal range
  Widget _buildValue(String label, String value, String unit,
      {bool isWarning = false}) {
    return RichText(
      text: TextSpan(
        style: AppStyles.dataValue,
        children: [
          // Label (e.g., "Hb:")
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          // Value with warning color if abnormal
          TextSpan(
            text: value,
            style: TextStyle(
              color: isWarning ? Colors.orangeAccent : Colors.white,
              fontWeight: isWarning ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          // Unit of measurement
          TextSpan(text: ' $unit', style: const TextStyle(fontSize: 8)),
        ],
      ),
    );
  }
}
