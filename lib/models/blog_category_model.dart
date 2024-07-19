class BlogCategoryModel {
  String? blogCategoryId;
  String? name;
  String? status;
  String? icon;

  BlogCategoryModel({
    this.blogCategoryId,
    this.name,
    this.status,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'blogCategoryId': blogCategoryId,
      'name': name,
      'status': status,
      'icon': icon,
    };
  }

  factory BlogCategoryModel.fromMap(Map<String, dynamic> map) {
    return BlogCategoryModel(
      blogCategoryId: map['blogCategoryId'],
      name: map['name'],
      status: map['status'],
      icon: map['icon'],
    );
  }
}