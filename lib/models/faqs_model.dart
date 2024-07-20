class FAQsModel {
  String? faqsid;
  String? title;
  String? faqsCategory;
  String? description;
  String? status;

  FAQsModel({
    this.faqsid,
    this.title,
    this.faqsCategory,
    this.description,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'faqsid': faqsid,
      'title': title,
      'faqsCategory': faqsCategory,
      'description': description,
      'status': status,
    };
  }

  factory FAQsModel.fromMap(Map<String, dynamic> map) {
    return FAQsModel(
      faqsid: map['faqsid'],
      title: map['title'],
      faqsCategory: map['faqsCategory'],
      description: map['description'],
      status: map['status'],
    );
  }
}
