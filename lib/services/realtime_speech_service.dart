// lib/services/realtime_speech_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Base class for all server messages
abstract class ServerMessage {}

/// Message containing partial transcription results
class PartialTranscript extends ServerMessage {
  final String text;
  PartialTranscript(this.text);
}

/// Message containing final transcription results
class FinalTranscript extends ServerMessage {
  final String text;
  FinalTranscript(this.text);
}

/// Message containing the complete AI response with patient data
class FinalResponse extends ServerMessage {
  final String name;
  final String age;
  final String problemSummary;
  final String medicalSummary;
  final String clarifyingQuestion;
  final Map<String, dynamic>? medicalData;
  
  FinalResponse({
    required this.name,
    required this.age,
    required this.problemSummary,
    required this.medicalSummary,
    required this.clarifyingQuestion,
    this.medicalData,
  });
}

/// Message indicating a server error occurred
class ServerError extends ServerMessage {
  final String message;
  ServerError(this.message);
}

/// Message indicating server processing status
class ServerProcessing extends ServerMessage {
  final bool isProcessing;
  ServerProcessing(this.isProcessing);
}

/// Service for managing real-time speech recognition via WebSocket.
/// Handles connection, message parsing, and audio streaming to the server.
class RealtimeSpeechService {
  final String serverUrl;
  WebSocketChannel? _channel;
  
  // Broadcast stream controller for server messages
  final StreamController<ServerMessage> _messageController =
      StreamController<ServerMessage>.broadcast();
  
  // Notifier for connection status
  final ValueNotifier<bool> isConnected = ValueNotifier(false);
  
  // Public stream of server messages
  Stream<ServerMessage> get messages => _messageController.stream;
  
  // Reconnection attempt counter
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 5;

  RealtimeSpeechService(this.serverUrl);

  /// Establishes WebSocket connection to the server.
  /// Automatically handles reconnection attempts on failure.
  Future<void> connect() async {
    // Don't reconnect if already connected
    if (isConnected.value && _channel != null) return;

    try {
      debugPrint("Connecting to $serverUrl...");
      _channel = IOWebSocketChannel.connect(Uri.parse(serverUrl));
      isConnected.value = true;
      _reconnectAttempts = 0;  // Reset attempts on successful connection
      debugPrint("WebSocket connected.");

      // Listen to incoming messages from server
      _channel!.stream.listen(
        (data) {
          debugPrint("RAW SERVER: $data");
          _handleServerMessage(data);
        },
        onDone: () async {
          debugPrint("WebSocket disconnected");
          isConnected.value = false;
          
          // Handle reconnection with attempt limit
          if (_reconnectAttempts < maxReconnectAttempts) {
            _reconnectAttempts++;
            debugPrint("Reconnection attempt $_reconnectAttempts/$maxReconnectAttempts");
            // Exponential backoff: wait longer with each attempt
            await Future.delayed(Duration(seconds: 2 * _reconnectAttempts));
            connect();
          } else {
            debugPrint("Maximum reconnection attempts reached");
            _messageController.add(ServerError("Unable to connect to server"));
          }
        },
        onError: (error) {
          debugPrint("WebSocket error: $error");
          _messageController.add(ServerError("Connection error"));
          isConnected.value = false;
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint("Unable to connect to WebSocket: $e");
      isConnected.value = false;
    }
  }

  /// Parses and handles incoming messages from the server.
  /// Converts JSON messages to typed ServerMessage objects.
  void _handleServerMessage(dynamic data) {
    try {
      final decoded = json.decode(data);
      final type = decoded['type'] as String?;

      switch (type) {
        // Handle partial transcription updates
        case 'partial_transcript':
          final text = decoded['text']?.toString() ?? '';
          _messageController.add(PartialTranscript(text));
          break;

        // Handle final transcription result
        case 'final_transcript':
          final text = decoded['text']?.toString() ?? '';
          _messageController.add(FinalTranscript(text));
          break;

        // Handle complete AI response with patient data
        case 'final_response':
          final responseData = decoded['data'] as Map<String, dynamic>?;
          
          if (responseData != null) {
            _messageController.add(
              FinalResponse(
                name: responseData['name']?.toString() ?? '',
                age: responseData['age']?.toString() ?? '',
                problemSummary: responseData['problem_summary']?.toString() ?? '',
                medicalSummary: responseData['medical_summary']?.toString() ?? '',
                clarifyingQuestion: responseData['clarifying_question']?.toString() ?? '',
                medicalData: responseData['medical_data'] as Map<String, dynamic>?,
              ),
            );
          }
          break;

        // Handle error messages from server
        case 'error':
          final errorMsg = decoded['message']?.toString() ?? 'Unknown error';
          _messageController.add(ServerError(errorMsg));
          break;

        // Unknown message type received
        default:
          debugPrint("Unknown message type: $type");
          break;
      }
    } catch (e) {
      debugPrint("Server parsing error: $e");
      _messageController.add(ServerError("Communication error"));
    }
  }

  /// Sends audio data to the server via WebSocket.
  /// Audio should be in PCM16 format at 16kHz sample rate.
  void sendAudio(Uint8List audioData) {
    if (isConnected.value && _channel != null) {
      _channel!.sink.add(audioData);
    } else {
      debugPrint("Attempted to send audio with WebSocket not connected");
    }
  }

  /// Sends a signal to the server indicating the end of speech.
  /// This triggers server-side processing of the accumulated audio.
  void sendEndSignal() {
    if (isConnected.value && _channel != null) {
      debugPrint("Sending end-of-speech signal...");
      _channel!.sink.add(json.encode({"event": "speech_end"}));
    }
  }

  /// Closes the WebSocket connection and cleans up resources.
  void dispose() {
    _channel?.sink.close();
    _messageController.close();
    isConnected.dispose();
  }
}
