// lib/widgets/medical_history_card.dart

import 'package:flutter/material.dart';
import '../models/medical_data_model.dart';
import '../utils/app_styles.dart';

/// Widget that displays medical history records in a card format.
/// Shows past and current medical conditions with their status,
/// diagnosis dates, and additional notes.
/// Status badges are color-coded: green for resolved, orange for active,
/// red for chronic conditions.
class MedicalHistoryCard extends StatelessWidget {
  /// List of medical history items to display
  final List<MedicalHistoryItem> history;

  /// Creates a medical history card.
  /// 
  /// The [history] parameter contains the list of medical history items.
  /// The [historyItems] parameter is currently unused but kept for compatibility.
  const MedicalHistoryCard({
    super.key, 
    required this.history, 
    required List<MedicalHistoryItem> historyItems
  });

  @override
  Widget build(BuildContext context) {
    // Don't render if there's no medical history
    if (history.isEmpty) return const SizedBox.shrink();

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
                'MEDICAL HISTORY',
                style: AppStyles.sectionTitle.copyWith(
                  color: AppStyles.historyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // List of medical history items
          ...history.map((h) => _buildHistoryItem(h)),
        ],
      ),
    );
  }

  /// Builds a single medical history item with status badge and details.
  /// 
  /// Displays the condition status as a colored badge, the condition name,
  /// and the diagnosis date.
  Widget _buildHistoryItem(MedicalHistoryItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          // Status badge with color coding
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getStatusColor(item.status).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _getStatusColor(item.status),
                width: 0.5,
              ),
            ),
            child: Text(
              item.status.toUpperCase(),
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(item.status),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Condition name and diagnosis date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.condition,
                  style: AppStyles.cardTitle.copyWith(fontSize: 10),
                ),
                Text(
                  item.diagnosedDate,
                  style: AppStyles.cardSubtitle.copyWith(fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the appropriate color for a given medical condition status.
  /// 
  /// Color mapping:
  /// - Active: Orange (ongoing treatment)
  /// - Chronic: Red (long-term condition)
  /// - Resolved: Green (successfully treated)
  /// - Unknown: Grey (default)
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'attivo':  // Support for Italian status values
        return Colors.orangeAccent;
      case 'chronic':
      case 'cronico':  // Support for Italian status values
        return Colors.redAccent;
      case 'resolved':
      case 'risolto':  // Support for Italian status values
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }
}
