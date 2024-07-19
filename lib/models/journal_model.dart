class JournalModel {
  String? journalld;
  String? title;
  String? journalCategory;
  String? status;

  JournalModel({
    this.journalld,
    this.title,
    this.journalCategory,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'journalld': journalld,
      'title': title,
      'journalCategory': journalCategory,
      'status': status,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      journalld: map['journalld'],
      title: map['title'],
      journalCategory: map['journalCategory'],
      status: map['status'],
    );
  }
}
