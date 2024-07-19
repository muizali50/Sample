class BlogModel {
  String? blogId;
  String? title;
  String? blogCategory;
  String? description;
  String? image;
  String? status;

  BlogModel({
    this.blogId,
    this.title,
    this.blogCategory,
    this.description,
    this.image,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'blogId': blogId,
      'title': title,
      'blogCategory': blogCategory,
      'description': description,
      'image': image,
      'status': status,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blogId'],
      title: map['title'],
      blogCategory: map['blogCategory'],
      description: map['description'],
      image: map['image'],
      status: map['status'],
    );
  }
}
