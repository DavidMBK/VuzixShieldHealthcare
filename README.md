# 🏥 Vuzix Medical Assistant - Flutter Client

<div align="center">

A hands-free, real-time medical assistant application for Vuzix smart glasses that combines voice recognition with AI-powered clinical insights. Built for healthcare professionals who need instant access to patient information while maintaining sterile hands-free operation.

[![Flutter 3.32.6](https://img.shields.io/badge/Flutter-3.32.6-blue.svg)](https://flutter.dev/)
[![Dart 3.8.1](https://img.shields.io/badge/Dart-3.8.1-blue.svg)](https://dart.dev/)
[![Android](https://img.shields.io/badge/Platform-Android-green.svg)](https://www.android.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>

---

## ✨ Features

### 🎤 Advanced Voice Processing
- **Real-time Speech Recognition** with Voice Activity Detection (VAD) using Silero VAD
- **WebSocket Communication** for low-latency audio streaming to transcription server
- **Continuous Recording** with automatic speech detection and silence filtering
- **Multi-language Support** through backend Whisper integration

### 🤖 AI-Powered Intelligence
- **Smart Clarifying Questions** powered by Google Generative AI (Gemini 2.5 Flash)
- **Context-Aware Responses** displayed in real-time at the bottom of the screen
- **Professional Medical Language** optimized for clinical documentation

### 📊 Medical Data Visualization
- **Patient Information Display** with name, age, and current problem
- **Blood Test Results** with color-coded indicators for normal/abnormal values
- **Prescription Management** showing medications, dosages, and schedules
- **Medical History Timeline** with chronological health records

### 👓 Vuzix Optimized
- **Landscape Orientation** specifically designed for Vuzix smart glasses
- **Immersive Fullscreen Mode** for distraction-free clinical use
- **Always-On Display** prevents screen timeout during procedures
- **Touch-Free Operation** ideal for sterile medical environments

---

## 📋 Prerequisites

### System Requirements

| Component | Requirement |
|-----------|-------------|
| Flutter SDK | 3.32.6 (Stable) |
| Dart SDK | 3.8.1 |
| Platform | Android (Vuzix smart glasses or Android phone) |
| Network | WiFi or Hotspot (same network as server) |

### Backend Requirements

You'll need the **Medical Assistant Voice Recognition Server** running on the same network. See the server repository for setup instructions.

### Device Requirements

⚠️ **CRITICAL**: This application has been successfully tested **only on physical devices with a working microphone**. Virtual emulators and devices without proper microphone support have shown compatibility issues and are not recommended for testing.

---

## 🚀 Quick Start

### 1️⃣ Install Flutter

#### Recommended: Video Tutorial
Follow this comprehensive Flutter installation guide: [Flutter Installation Tutorial](https://www.youtube.com/watch?v=mMeQhLGD-og)

#### Alternative: Official Documentation
Visit [Flutter's official installation guide](https://docs.flutter.dev/get-started/install) for your operating system.

### 2️⃣ Verify Flutter Installation

flutter --version


**Expected output:**

Flutter 3.32.6 - channel stable - https://github.com/flutter/flutter.git
Framework - revision 077b4a4ce1 (4 months ago) - 2025-07-08 13:31:08 -0700
Engine - revision 72f2b18bb0 (4 months ago) - 2025-07-08 10:33:53 -0700

**Note**: Minor version differences are acceptable (e.g., 3.x.x), but ensure you're on a stable channel.

### 3️⃣ Clone the Repository

git clone <your-repository-url>
cd <project-directory>


### 4️⃣ Install Dependencies

flutter pub get

**Installation time**: Typically 1-3 minutes depending on network speed.

---

## ⚙️ Configuration

### 🔴 CRITICAL: Server IP Configuration

This is the **most important step**. The application will not work without proper server configuration.

#### Step 1: Locate Configuration File
Find the server IP configuration in your project (typically in `lib/config/config.dart` or at the top of your main Dart files).

#### Step 2: Get Your Server IP Address

**On Windows (Server machine):**

ipconfig

Look for `IPv4 Address` under your active network adapter (e.g., `128.162.12.74`) (WIFI, not Ethernet)

**On macOS/Linux (Server machine):**

ip addr show

#### Step 3: Update Server IP

Edit the configuration file and replace the IP address:

const String SERVER_IP = 'ws://128.162.12.74:8000/ws/transcribe';

**Replace `128.162.12.74` with your actual server IP address of the server (REMEMBER SAME WIFI).**

### Network Requirements

🔴 **CRITICAL NETWORK SETUP**:

1. **Same Network Requirement**: Both the Flutter device (Vuzix/phone) and the server **MUST** be on the same network
2. **Supported Configurations**:
   - Both connected to the same WiFi network
   - Server creates a hotspot, device connects to it
   - Device creates a hotspot, server connects to it
3. **Test Connectivity**: Ping the server from your device before running the app

**Testing Server Reachability:**

#### On Android device (using Termux or similar):

ping <server_ip>

#### Example: 

ping 128.162.12.74


---

## 📦 Dependencies

The project uses the following key packages:

### Communication
- `web_socket_channel: ^2.4.0` - WebSocket client for real-time server communication

### Voice Processing
- `vad: ^0.0.6` - Voice Activity Detection using Silero VAD model
- `record: ^6.0.0` - Audio recording and streaming

### AI Integration
- `google_generative_ai: ^0.4.6` - Google Gemini AI for intelligent responses

### UI/UX
- `keep_screen_on: ^4.0.0` - Prevent screen timeout during medical procedures
- `fullscreen_window: ^1.1.0` - Immersive fullscreen mode for Vuzix

### Utilities
- `path_provider: ^2.1.5` - File system access for VAD model storage

**All dependencies are automatically installed with `flutter pub get`.**

---

## ▶️ Running the Application

### Connect Your Device

#### For Physical Android Device:
1. Enable **Developer Options** on your device:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable **USB Debugging**:
   - Go to Settings → Developer Options
   - Turn on "USB Debugging"
3. Connect device via USB cable

#### For Vuzix Smart Glasses:
1. Follow Vuzix-specific USB debugging setup (just plug the cable and install)

### Verify Device Connection

flutter devices

**Expected output:**

Vuzix Blade (mobile) - ABC123DEF - android-arm64 - Android 10 (API 29)
Chrome (web) - chrome - web-javascript - Google Chrome 120.0.6099.109


### Run the Application

flutter run (on the main.dart)

**First Launch**: Initial compilation may take 2-5 minutes.

### Expected Startup

1. **Fullscreen Mode** activates automatically
2. **Screen stays on** during operation
3. **WebSocket connection** attempts to server
4. **VAD model** loads (silero_vad.onnx)
5. **Microphone permission** request appears (grant it)

---

## 📱 Usage Guide

### First-Time Setup

1. **Launch Application** on Vuzix or Android device
2. **Grant Microphone Permission** when prompted
3. **Verify WebSocket Connection**:
   - Check the connection status on screen
   - If disconnected, verify server is running and IP is correct
4. **Position Vuzix Glasses** comfortably

### During Operation

1. **Voice Interaction**:
   - Speak naturally toward the device microphone
   - VAD automatically detects speech and streams audio
   - Transcription appears in real-time

2. **AI Responses**:
   - Clarifying questions appear at bottom-left of screen
   - Context-aware medical questions guide data collection

3. **Patient Data Display**:
   - **Right Panel**: Patient information (name, age, problem)
   - **Blood Tests**: Scrollable list with color-coded results
   - **Prescriptions**: Medication details with dosages
   - **Medical History**: Chronological health records

4. **Screen Navigation**:
   - Landscape orientation locked
   - Touch-free operation for sterile environments
   - Hands-free voice commands only


---

## 🛠️ Troubleshooting

### Common Issues

#### ❌ WebSocket Connection Failed

**Symptoms:**
- "Disconnected" status shown
- No transcription appearing
- Console shows connection errors

**Solutions:**
1. ✅ Verify server is running (`python main.py` on server)
2. ✅ Check `SERVER_IP` matches your server's actual IP address
3. ✅ Ensure both devices are on **the same network**
4. ✅ Ping server from device to test connectivity
5. ✅ Check firewall settings on server machine
6. ✅ Verify port 8000 is not blocked

**Test Server Reachability:**

On device terminal
ping <your_server_ip>

---

#### ❌ Microphone Not Working

**Symptoms:**
- No audio recording
- VAD not detecting speech
- Permission errors

**Solutions:**
1. ✅ Grant microphone permission in app settings
2. ✅ Test on **physical device with working microphone** (emulators not supported)
3. ✅ Check device microphone works in other apps
4. ✅ Restart application after granting permissions

**⚠️ CRITICAL**: This application requires a physical device with a functional microphone. Virtual emulators and simulators have shown unreliable microphone support and are not recommended.

---

#### ❌ VAD Model Not Loading

**Symptoms:**
- Error: "Failed to load VAD model"
- App crashes on startup

**Solutions:**
1. ✅ Ensure `vad` package is properly installed (`flutter pub get`)
2. ✅ Check `assets/packages/vad/assets/silero_vad.onnx` exists
3. ✅ Verify `pubspec.yaml` includes VAD assets
4. ✅ Run `flutter clean && flutter pub get`

---

#### ❌ Display Issues on Vuzix

**Symptoms:**
- UI elements cut off
- Incorrect orientation
- Text too small/large

**Solutions:**
1. ✅ Ensure landscape orientation is locked in code
2. ✅ Verify fullscreen mode is enabled
3. ✅ Check Vuzix display settings
4. ✅ Adjust font sizes in `app_styles.dart` if needed

---

#### ❌ Flutter Pub Get Fails

**Symptoms:**
- Dependency resolution errors
- Package conflicts

**Solutions:**
1. ✅ Update Flutter SDK: `flutter upgrade`
2. ✅ Clean project: `flutter clean`
3. ✅ Remove pubspec.lock and retry: `rm pubspec.lock && flutter pub get`
4. ✅ Check internet connection

---

#### ❌ App Crashes on Startup

**Solutions:**
1. ✅ Check device meets minimum requirements (Android 5.0+)
2. ✅ Review error logs: `flutter logs`
3. ✅ Rebuild app: `flutter clean && flutter run`
4. ✅ Ensure all dependencies are compatible

---

### Testing Recommendations

#### ✅ Recommended Testing Environment
- **Physical Android device** with working microphone
- **Vuzix smart glasses** (production environment)
- **Same WiFi network** as server
- **Quiet environment** for accurate voice detection

#### ❌ Not Recommended
- Virtual emulators (microphone issues)
- Devices without microphone
- Different networks between device and server
- Bluetooth headsets (latency issues)

---

## Example Use


![cinese](https://github.com/user-attachments/assets/3a86241f-f99c-4c86-b0a6-446ed7422fc6)
![coreano](https://github.com/user-attachments/assets/60161045-3ed8-46b4-8830-7c269fe1cf4d)
![Peach](https://github.com/user-attachments/assets/45531f06-cac5-4916-a0e4-83a7c5286db0)
![english](https://github.com/user-attachments/assets/ab0e51fc-d123-48da-aaa3-03d3a9f229b1)


---

## 🔧 Advanced Configuration

### Adjusting VAD Sensitivity

If VAD is too sensitive or not sensitive enough, you can adjust the threshold on the server side. Refer to server documentation for VAD configuration.

### Customizing UI

Edit `lib/utils/app_styles.dart` to customize:
- Colors and themes
- Font sizes
- Spacing and padding
- Card styling

### Adding Custom Medical Fields

1. Update data models in `lib/models/medical_data_model.dart`
2. Modify widgets to display new fields
3. Update server to send additional data

---

## 📚 Built With

### Core Technologies
- **[Flutter](https://flutter.dev/)** - Google's UI toolkit for cross-platform apps
- **[Dart](https://dart.dev/)** - Programming language optimized for UI
- **[Silero VAD](https://github.com/snakers4/silero-vad)** - Voice Activity Detection
- **[Google Generative AI](https://ai.google.dev/)** - Gemini 2.5 Flash for AI responses

### Key Packages
- **[web_socket_channel](https://pub.dev/packages/web_socket_channel)** - WebSocket client
- **[vad](https://pub.dev/packages/vad)** - Voice Activity Detection for Flutter
- **[record](https://pub.dev/packages/record)** - Cross-platform audio recording

### Infrastructure
- **WebSocket Protocol** - Real-time bidirectional communication
- **JSON Serialization** - Data exchange format
- **Android Platform** - Primary deployment target

---

## 🏗️ Architecture

### Data Flow

1. **Audio Capture**: Microphone → Record package
2. **Voice Detection**: Audio stream → VAD → Speech segments
3. **Transmission**: Speech segments → WebSocket → Server
4. **Processing**: Server → Whisper transcription → Gemini AI
5. **Response**: Server → WebSocket → Flutter app
6. **Display**: JSON data → Models → Widgets → Screen

### State Management

- **Stateful Widgets** for real-time UI updates
- **Stream Controllers** for audio and WebSocket data
- **JSON Deserialization** for server responses

---

## 📄 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute the code in accordance with the terms of the MIT License.

---

## ⚠️ Disclaimer

This software is provided "as is" without warranty of any kind. The author is not liable for any direct, indirect, consequential, incidental, or special damages arising out of or in any way connected with the use or misuse of this software.

**Medical Use Notice**: This tool is designed to assist healthcare professionals but should not replace professional medical judgment. Always verify AI-generated content and patient data before use in clinical settings. This application is intended for research and development purposes.

**Device Compatibility Notice**: This application has been tested and verified to work on physical devices with functioning microphones. Virtual emulators and devices without proper microphone support may not work correctly.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 👨‍💻 Author

**David M.**

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Silero team for the VAD model
- Google for Gemini AI integration
- Vuzix for smart glasses platform

---

<div align="center">

**Made with ❤️ for Healthcare Professionals**

*Empowering hands-free clinical documentation with AI*

If you find this project helpful, please consider giving it a ⭐

</div>
