class DeclarationCategoryModel {
  String? declarationCategoryId;
  String? name;
  String? status;
  String? icon;

  DeclarationCategoryModel({
    this.declarationCategoryId,
    this.name,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'declarationCategoryId': declarationCategoryId,
      'name': name,
      'status': status,
      'icon': icon,
    };
  }

  factory DeclarationCategoryModel.fromMap(Map<String, dynamic> map) {
    return DeclarationCategoryModel(
      declarationCategoryId: map['declarationCategoryId'],
      name: map['name'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}
