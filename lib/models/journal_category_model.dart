class JournalCategoryModel {
  String? journalCategoryId;
  String? name;
  String? status;
  String? icon;

  JournalCategoryModel({
    this.journalCategoryId,
    this.name,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'journalCategoryId': journalCategoryId,
      'name': name,
      'status': status,
      'icon': icon,
    };
  }

  factory JournalCategoryModel.fromMap(Map<String, dynamic> map) {
    return JournalCategoryModel(
      journalCategoryId: map['journalCategoryId'],
      name: map['name'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}
