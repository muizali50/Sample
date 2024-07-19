class DeclarationModel {
  String? declarationId;
  String? title;
  String? declarationCategory;
  String? description;
  String? image;
  String? status;

  DeclarationModel({
    this.declarationId,
    this.title,
    this.declarationCategory,
    this.description,
    this.image,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'declarationId': declarationId,
      'title': title,
      'declarationCategory': declarationCategory,
      'description': description,
      'image': image,
      'status': status,
    };
  }

  factory DeclarationModel.fromMap(Map<String, dynamic> map) {
    return DeclarationModel(
      declarationId: map['declarationId'],
      title: map['title'],
      declarationCategory: map['declarationCategory'],
      description: map['description'],
      image: map['image'],
      status: map['status'],
    );
  }
}
