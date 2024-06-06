class MeditationModel {
  String? meditationId;
  String? title;
  String? status;
  String? icon;

  MeditationModel({
    this.meditationId,
    this.title,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'meditationId': meditationId,
      'title': title,
      'status': status,
      'icon': icon,
    };
  }

  factory MeditationModel.fromMap(Map<String, dynamic> map) {
    return MeditationModel(
      meditationId: map['meditationId'],
      title: map['title'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}