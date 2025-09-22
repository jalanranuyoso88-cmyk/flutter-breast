import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prediction_result.dart';
import '../models/analysis_history.dart';
import '../models/sadari_guide.dart';
import '../models/about_content.dart';

class ApiService {
  static const String baseUrl = 'http://147.93.158.86:5000/api';
  static final http.Client _client = http.Client();
  static String? _sessionId;
  
  // Session management functions
  static Future<String> _getOrCreateSessionId() async {
    if (_sessionId != null) return _sessionId!;
    
    final prefs = await SharedPreferences.getInstance();
    _sessionId = prefs.getString('session_id');
    
    if (_sessionId == null) {
      _sessionId = DateTime.now().millisecondsSinceEpoch.toString() + 
                   '_' + (DateTime.now().microsecondsSinceEpoch % 1000000).toString();
      await prefs.setString('session_id', _sessionId!);
    }
    
    return _sessionId!;
  }
  
  static Map<String, String> _getSessionHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-Session-ID': _sessionId ?? '',
    };
  }
  
  static Future<bool> checkHealth() async {
    try {
      await _getOrCreateSessionId();
      final response = await _client.get(
        Uri.parse('$baseUrl/health'),
        headers: _getSessionHeaders(),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  
  static Future<PredictionResult> predictImage(Uint8List imageBytes) async {
    try {
      await _getOrCreateSessionId();
      print('ApiService: Predicting image with session ID: $_sessionId');
      // Convert image to base64
      String base64Image = base64Encode(imageBytes);
      
      final response = await _client.post(
        Uri.parse('$baseUrl/predict'),
        headers: _getSessionHeaders(),
        body: jsonEncode({
          'image_data': base64Image,
          'session_id': _sessionId,
        }),
      ).timeout(const Duration(seconds: 30));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return PredictionResult.fromJson(data['prediction']);
        } else {
          throw Exception(data['message'] ?? 'Prediction failed');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in predictImage: $e');
      throw Exception('Failed to analyze image: $e');
    }
  }
  
  static Future<List<AnalysisHistory>> getHistory() async {
    try {
      await _getOrCreateSessionId();
      print('ApiService: Getting history with session ID: $_sessionId');
      final response = await _client.get(
        Uri.parse('$baseUrl/history'),
        headers: _getSessionHeaders(),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          List<dynamic> historyList = data['history'];
          return historyList.map((item) => AnalysisHistory.fromJson(item)).toList();
        } else {
          throw Exception(data['message'] ?? 'Failed to load history');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getHistory: $e');
      throw Exception('Failed to load history: $e');
    }
  }
  
  static Future<bool> deleteHistoryItem(String id) async {
    try {
      await _getOrCreateSessionId();
      final response = await _client.delete(
        Uri.parse('$baseUrl/history/$id'),
        headers: _getSessionHeaders(),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'];
      }
      return false;
    } catch (e) {
      print('Error in deleteHistoryItem: $e');
      return false;
    }
  }
  
  static Future<SadariGuide?> getSadariGuide() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/sadari/guide'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return SadariGuide.fromJson(data['content']);
        }
      }
      return null;
    } catch (e) {
      print('Error in getSadariGuide: $e');
      return null;
    }
  }
  
  static Future<AboutContent?> getAboutContent() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/about'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return AboutContent.fromJson(data['content']);
        }
      }
      return null;
    } catch (e) {
      print('Error in getAboutContent: $e');
      return null;
    }
  }
}
