class StressorModel {
  String? stressorId;
  String? title;
  String? status;
  String? icon;

  StressorModel({
    this.stressorId,
    this.title,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'stressorId': stressorId,
      'title': title,
      'status': status,
      'icon': icon,
    };
  }

  factory StressorModel.fromMap(Map<String, dynamic> map) {
    return StressorModel(
      stressorId: map['stressorId'],
      title: map['title'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}
