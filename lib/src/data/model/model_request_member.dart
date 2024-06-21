class RequestMemberModel {
  int? forumId;
  int? userId;
  int? statusId;
  String? createdAt;
  String? updatedAt;
  int? id;
  String? reason;

  RequestMemberModel(
      {this.forumId,
      this.userId,
      this.statusId,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.reason});

  RequestMemberModel.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    userId = json['userId'];
    statusId = json['statusId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumId'] = forumId;
    data['userId'] = userId;
    data['statusId'] = statusId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    data['reason'] = reason;
    return data;
  }
}
