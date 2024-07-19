class FAQsModel {
  String? faqsld;
  String? title;
  String? faqsCategory;
  String? description;
  String? status;

  FAQsModel({
    this.faqsld,
    this.title,
    this.faqsCategory,
    this.description,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'faqsld': faqsld,
      'title': title,
      'faqsCategory': faqsCategory,
      'description': description,
      'status': status,
    };
  }

  factory FAQsModel.fromMap(Map<String, dynamic> map) {
    return FAQsModel(
      faqsld: map['faqsld'],
      title: map['title'],
      faqsCategory: map['faqsCategory'],
      description: map['description'],
      status: map['status'],
    );
  }
}
