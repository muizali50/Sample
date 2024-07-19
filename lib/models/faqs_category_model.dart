class FAQsCategoryModel {
  String? faqsCategoryId;
  String? name;
  String? status;
  String? icon;

  FAQsCategoryModel({
    this.faqsCategoryId,
    this.name,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'faqsCategoryId': faqsCategoryId,
      'name': name,
      'status': status,
      'icon': icon,
    };
  }

  factory FAQsCategoryModel.fromMap(Map<String, dynamic> map) {
    return FAQsCategoryModel(
      faqsCategoryId: map['faqsCategoryId'],
      name: map['name'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}
