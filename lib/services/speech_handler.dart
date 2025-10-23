// lib/services/speech_handler.dart

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_vuzix/services/realtime_speech_service.dart';
import 'package:vad/vad.dart';

/// Represents the current state of audio recording and processing
enum RecordingState { stopped, listening, processing, error }

/// Handles Voice Activity Detection (VAD) and audio streaming.
/// Detects when speech starts and ends, converts audio to PCM16 format,
/// and triggers appropriate callbacks for audio data and speech end events.
class VADAudioHandler {
  // Notifier for current recording state
  final ValueNotifier<RecordingState> state = ValueNotifier(
    RecordingState.stopped,
  );

  // VAD handler instance for speech detection
  late VadHandlerBase _vadHandler;
  
  // Flag indicating if VAD is actively listening
  bool _isListening = false;
  
  // Timer for detecting silence after speech ends
  Timer? _silenceTimer;
  
  // Duration to wait after speech end before triggering onSpeechEnd callback
  final Duration _silenceDelay = const Duration(milliseconds: 1200);
  
  // Reference to speech service for connection status checks
  final RealtimeSpeechService speechService;
  
  // Callback invoked when audio data is ready to send
  final Function(Uint8List) onAudioData;
  
  // Callback invoked when speech has ended
  final Function() onSpeechEnd;

  VADAudioHandler({
    required this.speechService,
    required this.onAudioData,
    required this.onSpeechEnd,
  }) {
    _initializeVad();
  }

  /// Initializes the VAD handler and sets up event listeners
  /// for speech start, speech end, and error events.
  void _initializeVad() {
    _vadHandler = VadHandler.create(isDebug: false);
    
    // Listen for speech start events
    _vadHandler.onSpeechStart.listen((_) {
      debugPrint("VAD: Speech start detected");
      state.value = RecordingState.listening;
      _silenceTimer?.cancel();
    });

    // Listen for speech end events
    _vadHandler.onSpeechEnd.listen((List<double> samples) async {
      debugPrint("VAD: Speech end detected, starting inactivity timer");
      
      // Convert and send audio samples if available
      if (samples.isNotEmpty) {
        final pcmBytes = await compute(_convertFloatToPcm16, samples);
        onAudioData(pcmBytes);
      }

      // Cancel existing timer and start new silence detection timer
      _silenceTimer?.cancel();
      _silenceTimer = Timer(_silenceDelay, () {
        debugPrint("VAD: Timer expired, sending speech_end signal");
        onSpeechEnd();
        state.value = RecordingState.processing;
      });
    });

    // Listen for VAD errors
    _vadHandler.onError.listen((message) {
      debugPrint("VAD Error: $message");
      state.value = RecordingState.error;
    });
  }

  /// Starts the VAD listener with configured parameters.
  /// Configures sensitivity, frame sizes, and model paths.
  Future<void> start() async {
    if (_isListening) return;

    try {
      await _vadHandler.startListening(
        frameSamples: 512,                      // Number of samples per frame (512 for 16kHz)
        minSpeechFrames: 6,                     // Minimum frames to consider as speech
        preSpeechPadFrames: 3,                  // Frames to include before speech starts
        redemptionFrames: 18,                   // Frames to wait before declaring speech end
        positiveSpeechThreshold: 0.85,          // Threshold for detecting speech (higher = more strict)
        negativeSpeechThreshold: 0.3,           // Threshold for detecting silence (lower = more strict)
        model: 'silero_vad.onnx',               // VAD model file
        baseAssetPath: 'assets/packages/vad/assets/',
        onnxWASMBasePath: 'assets/packages/vad/assets/',
      );

      _isListening = true;
      state.value = RecordingState.listening;
      debugPrint("VAD Listening Started");
    } catch (e) {
      debugPrint("Error starting VAD: $e");
      state.value = RecordingState.error;
    }
  }

  /// Stops the VAD listener and cancels any pending timers.
  Future<void> stop() async {
    if (!_isListening) return;

    try {
      _silenceTimer?.cancel();
      await _vadHandler.stopListening();
      _isListening = false;
      state.value = RecordingState.stopped;
      debugPrint("VAD Listening Stopped");
    } catch (e) {
      debugPrint("Error stopping VAD: $e");
    }
  }

  /// Cleans up resources by stopping VAD and disposing listeners.
  void dispose() {
    stop();
    _vadHandler.dispose();
    state.dispose();
  }

  /// Converts floating-point audio samples (-1.0 to 1.0) to PCM16 format.
  /// This is a compute-intensive operation run in an isolate for performance.
  /// 
  /// @param samples List of floating-point audio samples
  /// @return Uint8List containing PCM16 encoded audio data (little-endian)
  static Future<Uint8List> _convertFloatToPcm16(List<double> samples) async {
    final byteData = ByteData(samples.length * 2);
    int byteIndex = 0;
    
    for (final sample in samples) {
      // Convert float (-1.0 to 1.0) to 16-bit integer (-32767 to 32767)
      final intValue = (sample * 32767).round().clamp(-32767, 32767);
      byteData.setInt16(byteIndex, intValue, Endian.little);
      byteIndex += 2;
    }
    
    return byteData.buffer.asUint8List();
  }
}
