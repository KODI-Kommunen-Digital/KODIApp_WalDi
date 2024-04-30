class UserJoinedGroupsModel {
  String? forumName;
  int? forumId;
  int? memberId;
  String? image;
  int? isPrivate;
  int? isAdmin;
  String? joinedAt;
  int? cityId;

  UserJoinedGroupsModel(
      {this.forumName,
        this.forumId,
        this.memberId,
        this.image,
        this.isPrivate,
        this.isAdmin,
        this.joinedAt,
        this.cityId});

  UserJoinedGroupsModel.fromJson(Map<String, dynamic> json) {
    forumName = json['forumName'];
    forumId = json['forumId'];
    memberId = json['memberId'];
    image = json['image'];
    isPrivate = json['isPrivate'];
    isAdmin = json['isAdmin'];
    joinedAt = json['JoinedAt'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumName'] = forumName;
    data['forumId'] = forumId;
    data['memberId'] = memberId;
    data['image'] = image;
    data['isPrivate'] = isPrivate;
    data['isAdmin'] = isAdmin;
    data['JoinedAt'] = joinedAt;
    data['cityId'] = cityId;
    return data;
  }
}
