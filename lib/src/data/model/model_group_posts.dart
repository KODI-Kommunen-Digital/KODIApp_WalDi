class GroupPostsModel {
  int? id;
  int? forumId;
  String? title;
  String? description;
  int? userId;
  String? image;
  String? createdAt;
  int? isHidden;

  GroupPostsModel(
      {this.id,
        this.forumId,
        this.title,
        this.description,
        this.userId,
        this.image,
        this.createdAt,
        this.isHidden});

  GroupPostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forumId = json['forumId'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    image = json['image'];
    createdAt = json['createdAt'];
    isHidden = json['isHidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['forumId'] = forumId ?? 0;
    data['title'] = title ?? '';
    data['description'] = description ?? '';
    data['userId'] = userId ?? 0;
    data['image'] = image ?? 'admin/News.jpeg';
    data['createdAt'] = createdAt ?? '';
    data['isHidden'] = isHidden ?? 0;
    return data;
  }
}
