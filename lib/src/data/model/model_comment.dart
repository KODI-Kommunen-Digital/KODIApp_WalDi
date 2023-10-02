class CommentModel {
  int? id;
  int? forumId;
  int? postId;
  String? comment;
  String? createdAt;
  int? childrenCount;
  int? cityUserId;
  String? username;
  String? firstname;
  String? lastname;
  String? image;
  int? parentId;
  List<CommentModel>? replies;
  String? userName;
  String? userProfileImage;

  CommentModel(
      {this.id,
      this.forumId,
      this.postId,
      this.comment,
      this.createdAt,
      this.childrenCount,
      this.cityUserId,
      this.username,
      this.firstname,
      this.lastname,
      this.image,
      this.parentId,
      this.userName = '',
      this.userProfileImage = '',
      this.replies});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forumId = json['forumId'];
    postId = json['postId'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    childrenCount = json['childrenCount'];
    cityUserId = json['cityUserId'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
    parentId = json['parentId'];

    userName = json['username'];
    userProfileImage = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['forumId'] = forumId;
    data['postId'] = postId;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['childrenCount'] = childrenCount;
    data['cityUserId'] = cityUserId;
    data['username'] = username;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['image'] = image;
    data['parentId'] = parentId;

    data['userName'] = userName;
    data['userProfileImage'] = userProfileImage;

    return data;
  }
}
