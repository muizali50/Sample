class BreathWorkModel {
  String? breathworkId;
  String? title;
  String? status;
  String? icon;

  BreathWorkModel({
    this.breathworkId,
    this.title,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'breathworkId': breathworkId,
      'title': title,
      'status': status,
      'icon': icon,
    };
  }

  factory BreathWorkModel.fromMap(Map<String, dynamic> map) {
    return BreathWorkModel(
      breathworkId: map['breathworkId'],
      title: map['title'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}