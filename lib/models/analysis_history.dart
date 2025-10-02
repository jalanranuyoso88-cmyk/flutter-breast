class AnalysisHistory {
  final String id;
  final String label;
  final double confidence;
  final DateTime timestamp;
  final String imagePath;
  final String? imageData; // Base64 image data from server
  
  AnalysisHistory({
    required this.id,
    required this.label,
    required this.confidence,
    required this.timestamp,
    required this.imagePath,
    this.imageData,
  });
  
  factory AnalysisHistory.fromJson(Map<String, dynamic> json) {
    return AnalysisHistory(
      id: json['id'].toString(), // Convert to string to handle both int and string
      label: json['label'].toString(), // Convert to string
      confidence: (json['confidence'] is int) 
          ? json['confidence'].toDouble() 
          : json['confidence'].toDouble(),
      timestamp: DateTime.parse(json['timestamp'].toString()),
      imagePath: json['image_path']?.toString() ?? '',
      imageData: json['image_data']?.toString(), // Get base64 image data from server
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
      'image_path': imagePath,
      'image_data': imageData,
    };
  }
  
  bool get isCancer => label == 'Cancer';
  String get confidenceText => '${confidence.toStringAsFixed(1)}%';
  String get resultText => isCancer ? 'Kanker' : 'Normal';
}
