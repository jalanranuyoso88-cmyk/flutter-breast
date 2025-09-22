import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class ImageStorageService {
  static const String _imagePrefix = 'analysis_image_';
  
  /// Store image data for a history item
  static Future<void> storeImage(String historyId, Uint8List imageData) async {
    try {
      print('ImageStorageService: Storing image for ID: $historyId');
      final prefs = await SharedPreferences.getInstance();
      final base64Image = base64Encode(imageData);
      await prefs.setString('$_imagePrefix$historyId', base64Image);
      print('ImageStorageService: Image stored successfully, size: ${imageData.length} bytes');
    } catch (e) {
      print('Error storing image: $e');
    }
  }
  
  /// Retrieve image data for a history item
  static Future<Uint8List?> getImage(String historyId) async {
    try {
      print('ImageStorageService: Retrieving image for ID: $historyId');
      final prefs = await SharedPreferences.getInstance();
      final base64Image = prefs.getString('$_imagePrefix$historyId');
      if (base64Image != null) {
        print('ImageStorageService: Image found, size: ${base64Image.length} chars');
        return base64Decode(base64Image);
      } else {
        print('ImageStorageService: No image found for ID: $historyId');
      }
    } catch (e) {
      print('Error retrieving image: $e');
    }
    return null;
  }
  
  /// Remove image data for a history item
  static Future<void> removeImage(String historyId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('$_imagePrefix$historyId');
    } catch (e) {
      print('Error removing image: $e');
    }
  }
  
  /// Clear all stored images
  static Future<void> clearAllImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      for (String key in keys) {
        if (key.startsWith(_imagePrefix)) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      print('Error clearing images: $e');
    }
  }
}
