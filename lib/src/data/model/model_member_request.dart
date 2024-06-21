class MemberRequestModel {
  int? cityUserId;
  String? username;
  int? requestId;
  String? firstname;
  String? lastname;
  String? image;
  String? createdAt;

  MemberRequestModel(
      {this.cityUserId,
      this.username,
      this.requestId,
      this.firstname,
      this.lastname,
      this.image,
      this.createdAt});

  MemberRequestModel.fromJson(Map<String, dynamic> json) {
    cityUserId = json['cityUserId'];
    username = json['username'];
    requestId = json['requestId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    image = json['image'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityUserId'] = cityUserId ?? 0;
    data['username'] = username ?? '';
    data['requestId'] = requestId ?? 0;
    data['firstname'] = firstname ?? '';
    data['lastname'] = lastname ?? '';
    data['image'] = image ?? '';
    data['createdAt'] = createdAt ?? '';
    return data;
  }
}
