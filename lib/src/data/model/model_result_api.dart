import 'model.dart';

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

    if (json['user'] != null) {
      user = UserModel.fromJson(json['data']);
    }
    if (json['pagination'] != null) {
      pagination = PaginationModel.fromJson(json['pagination']);
    }

    return ResultApiModel(
      success: (json['status'] == 'error' ||
              json['status'] == 'fail' ||
              json['status'] == 'Error')
          ? false
          : true,
      data: json['data'] ?? '',
      id: json['id'] ?? 0,
      pagination: pagination,
      attr: json['attr'] ?? '',
      payment: json['payment'] ?? '',
      user: user,
      message: json['message'] ?? '',
    );
  }
}
