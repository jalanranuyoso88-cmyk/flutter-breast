class AboutContent {
  final String title;
  final String description;
  final List<String> features;
  final TechnologyInfo technology;
  final String disclaimer;
  final ContactInfo contact;
  
  AboutContent({
    required this.title,
    required this.description,
    required this.features,
    required this.technology,
    required this.disclaimer,
    required this.contact,
  });
  
  factory AboutContent.fromJson(Map<String, dynamic> json) {
    return AboutContent(
      title: json['title'],
      description: json['description'],
      features: List<String>.from(json['features']),
      technology: TechnologyInfo.fromJson(json['technology']),
      disclaimer: json['disclaimer'],
      contact: ContactInfo.fromJson(json['contact']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'features': features,
      'technology': technology.toJson(),
      'disclaimer': disclaimer,
      'contact': contact.toJson(),
    };
  }
}

class TechnologyInfo {
  final String aiModel;
  final String imageProcessing;
  final String accuracy;
  final String platform;
  
  TechnologyInfo({
    required this.aiModel,
    required this.imageProcessing,
    required this.accuracy,
    required this.platform,
  });
  
  factory TechnologyInfo.fromJson(Map<String, dynamic> json) {
    return TechnologyInfo(
      aiModel: json['ai_model'],
      imageProcessing: json['image_processing'],
      accuracy: json['accuracy'],
      platform: json['platform'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'ai_model': aiModel,
      'image_processing': imageProcessing,
      'accuracy': accuracy,
      'platform': platform,
    };
  }
}

class ContactInfo {
  final String email;
  final String phone;
  final String website;
  
  ContactInfo({
    required this.email,
    required this.phone,
    required this.website,
  });
  
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'website': website,
    };
  }
}
