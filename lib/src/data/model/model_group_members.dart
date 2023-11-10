class GroupMembersModel {
  int? userId;
  String? username;
  int? memberId;
  String? firstname;
  String? lastname;
  String? image;
  int? isAdmin;
  String? joinedAt;

  GroupMembersModel(
      {this.userId,
      this.username,
      this.memberId,
      this.firstname,
      this.lastname,
      this.image,
      this.isAdmin,
      this.joinedAt});

  GroupMembersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    memberId = json['memberId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
    isAdmin = json['isAdmin'];
    joinedAt = json['joinedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId ?? 0;
    data['username'] = username ?? '';
    data['memberId'] = memberId ?? 0;
    data['firstname'] = firstname ?? '';
    data['lastname'] = lastname ?? '';
    data['image'] = image ?? 'admin/DefaultForum.jpeg';
    data['isAdmin'] = isAdmin ?? 0;
    data['joinedAt'] = joinedAt ?? '';
    return data;
  }
}
