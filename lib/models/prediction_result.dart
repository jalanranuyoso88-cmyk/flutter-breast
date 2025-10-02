class PredictionResult {
  final String id;
  final String label;
  final double confidence;
  final DateTime timestamp;
  
  PredictionResult({
    required this.id,
    required this.label,
    required this.confidence,
    required this.timestamp,
  });
  
  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      id: json['id'],
      label: json['label'],
      confidence: json['confidence'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  bool get isCancer => label.toLowerCase() == 'cancer' || label.toLowerCase() == 'malignant';
  String get confidenceText => '${confidence.toStringAsFixed(1)}%';
  String get resultText => isCancer ? 'Kanker Terdeteksi' : 'Tidak Ada Kanker';
}











