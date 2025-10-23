// lib/widgets/ai_response_widget.dart

import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

/// Widget that displays AI-generated questions or responses.
/// Shows a psychology icon alongside the text with accent styling.
/// Used to display clarifying questions from the medical assistant AI.
class AIResponseWidget extends StatelessWidget {
  /// The question or response text to display
  final String question;

  /// Creates an AI response widget.
  /// 
  /// The [question] parameter contains the text to display.
  /// The [response] parameter is currently unused but kept for future functionality.
  const AIResponseWidget({
    super.key, 
    required this.question, 
    required String response
  });

  @override
  Widget build(BuildContext context) {
    // Don't render anything if there's no question to display
    if (question.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppStyles.highlightDecoration,
      child: Row(
        children: [
          // AI brain icon indicator
          const Icon(
            Icons.psychology_outlined,
            color: AppStyles.aiColor,
            size: 18,
          ),
          const SizedBox(width: 10),
          // Question text with word wrapping
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                color: AppStyles.aiColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,  // Line height for better readability
              ),
            ),
          ),
        ],
      ),
    );
  }
}
