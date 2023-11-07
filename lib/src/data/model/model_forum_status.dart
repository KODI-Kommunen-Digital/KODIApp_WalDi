class ForumStatusModel {
  int? forumIds;
  int? statusId;

  ForumStatusModel({this.forumIds, this.statusId});

  ForumStatusModel.fromJson(Map<String, dynamic> json) {
    forumIds = json['forumId'];
    statusId = json['statusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumId'] = forumIds;
    data['statusId'] = statusId;
    return data;
  }
}
