// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:flutter_vuzix/screen/chat_screen.dart';

/// Entry point of the application.
/// Initializes system settings for the Vuzix smart glasses:
/// - Forces landscape orientation
/// - Enables immersive fullscreen mode
/// - Keeps the screen on during use
void main() {
  // Ensure Flutter binding is initialized before making system calls
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to landscape mode for smart glasses display
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Enable fullscreen immersive mode, hiding system UI
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  
  // Keep screen on to prevent display from turning off during medical consultations
  KeepScreenOn.turnOn();

  runApp(const MainApp());
}

/// Root widget of the medical assistant application.
/// Configures the app theme with dark mode optimized for AR glasses
/// and transparent background for overlay display.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner in production
      debugShowCheckedModeBanner: false,
      
      // Dark theme optimized for smart glasses display
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
        ),
        // Compact visual density for limited display space
        visualDensity: VisualDensity.compact,
      ),
      
      // Launch directly into chat screen
      home: const ChatScreen(),
    );
  }
}
