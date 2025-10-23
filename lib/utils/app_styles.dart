// lib/utils/app_styles.dart

import 'package:flutter/material.dart';

/// Centralized style definitions for the application.
/// Contains color schemes, text styles, and box decorations
/// used throughout the medical assistant interface.

/// [I know that's doesn't work very well on Vuzix shield, because support only green mode, but can be useful for other devices]
class AppStyles {

  
  /// Primary accent color for main UI elements
  static const Color primaryAccent = Colors.cyanAccent;
  
  /// Secondary accent color for alternative highlights
  static const Color secondaryAccent = Colors.orangeAccent;
  
  /// Color for blood test related elements
  static const Color bloodColor = Colors.redAccent;
  
  /// Color for prescription related elements
  static const Color prescriptionColor = Colors.greenAccent;
  
  /// Color for medical history related elements
  static const Color historyColor = Colors.purpleAccent;
  
  /// Color for AI-related elements and responses
  static const Color aiColor = Colors.lightBlueAccent;
  
  // Text Styles
  
  /// Style for section titles in cards
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8,
  );
  
  /// Style for main card titles
  static const TextStyle cardTitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  /// Style for card subtitles and secondary information
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 10,
    color: Colors.white70,
  );
  
  /// Style for data field labels
  static const TextStyle dataLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
  );
  
  /// Style for data values displayed in cards
  static const TextStyle dataValue = TextStyle(
    fontSize: 10,
    color: Colors.white70,
  );
  
  /// Style for notes and additional information text
  static const TextStyle notes = TextStyle(
    fontSize: 9,
    fontStyle: FontStyle.italic,
    color: Colors.yellowAccent,
  );
  
  // Decorations
  
  /// Standard card decoration with semi-transparent background
  /// and cyan border for consistent card styling
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.black.withOpacity(0.25),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: Colors.cyan.withOpacity(0.3),
      width: 1,
    ),
  );
  
  /// Highlighted card decoration for emphasized elements
  /// with slightly darker background and brighter border
  static BoxDecoration highlightDecoration = BoxDecoration(
    color: Colors.black.withOpacity(0.35),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: Colors.cyan.withOpacity(0.5),
      width: 1,
    ),
  );
}
