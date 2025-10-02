class BreastLensGuide {
  final String title;
  final String description;
  final List<BreastLensStep> steps;
  final CancerEducation cancerEducation;
  
  BreastLensGuide({
    required this.title,
    required this.description,
    required this.steps,
    required this.cancerEducation,
  });
  
  factory BreastLensGuide.fromJson(Map<String, dynamic> json) {
    return BreastLensGuide(
      title: json['title'],
      description: json['description'],
      steps: (json['steps'] as List)
          .map((step) => BreastLensStep.fromJson(step))
          .toList(),
      cancerEducation: CancerEducation.fromJson(json['cancer_education']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'steps': steps.map((step) => step.toJson()).toList(),
      'cancer_education': cancerEducation.toJson(),
    };
  }
}

class BreastLensStep {
  final int number;
  final String title;
  final String description;
  final String icon;
  
  BreastLensStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });
  
  factory BreastLensStep.fromJson(Map<String, dynamic> json) {
    return BreastLensStep(
      number: json['number'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'description': description,
      'icon': icon,
    };
  }
}

class CancerEducation {
  final String title;
  final String description;
  final List<RiskFactor> riskFactors;
  final List<Symptom> symptoms;
  
  CancerEducation({
    required this.title,
    required this.description,
    required this.riskFactors,
    required this.symptoms,
  });
  
  factory CancerEducation.fromJson(Map<String, dynamic> json) {
    return CancerEducation(
      title: json['title'],
      description: json['description'],
      riskFactors: (json['risk_factors'] as List)
          .map((factor) => RiskFactor.fromJson(factor))
          .toList(),
      symptoms: (json['symptoms'] as List)
          .map((symptom) => Symptom.fromJson(symptom))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'risk_factors': riskFactors.map((factor) => factor.toJson()).toList(),
      'symptoms': symptoms.map((symptom) => symptom.toJson()).toList(),
    };
  }
}

class RiskFactor {
  final String name;
  final String description;
  
  RiskFactor({
    required this.name,
    required this.description,
  });
  
  factory RiskFactor.fromJson(Map<String, dynamic> json) {
    return RiskFactor(
      name: json['name'],
      description: json['description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class Symptom {
  final String name;
  final String description;
  
  Symptom({
    required this.name,
    required this.description,
  });
  
  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      name: json['name'],
      description: json['description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}


