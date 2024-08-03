class JournalModel {
  String? journalld;
  String? title;
  String? journalCategory;
  String? status;
  Map<String, String>? answers;

  JournalModel({
    this.journalld,
    this.title,
    this.journalCategory,
    this.status,
    this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'journalld': journalld,
      'title': title,
      'journalCategory': journalCategory,
      'status': status,
      'answers': answers,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      journalld: map['journalld'],
      title: map['title'],
      journalCategory: map['journalCategory'],
      status: map['status'],
      answers: Map<String, String>.from(map['answers'] ?? {}),
    );
  }
}
