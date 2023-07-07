import 'package:heidi/src/data/model/model.dart';

class ResultApiModel {
  final bool success;
  final dynamic data;
  final dynamic attr;
  final dynamic payment;
  final PaginationModel? pagination;
  final UserModel? user;
  final int? id;
  final String message;
  dynamic token;

  ResultApiModel(
      {required this.success,
      required this.message,
      this.data,
      this.pagination,
      this.attr,
      this.payment,
      this.user,
      this.id,
      this.token});

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    UserModel? user;
    PaginationModel? pagination;
    String message;
    String? token;
    int id = 0;

    if (json['user'] != null) {
      // user = UserModel.fromJson(json['user']);
      user = UserModel.fromJson(json['data']);
    }
    if (json['pagination'] != null) {
      pagination = PaginationModel.fromJson(json['pagination']);
    }
    if (json['success'] == true) {
      message = "save_data_success";
    }

    if (json['success'] == true) {
      token = json['data']['accessToken'];
    }

    return ResultApiModel(
      success: json['status'] == "success",
      data: json['data'],
      id: json['id'],
      pagination: pagination,
      attr: json['attr'],
      payment: json['payment'],
      user: user,
      message: json['message'] ?? '',
    );
  }
}
