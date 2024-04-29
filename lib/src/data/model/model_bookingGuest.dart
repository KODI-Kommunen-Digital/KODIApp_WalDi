// ignore_for_file: file_names

import 'package:heidi/src/data/model/model.dart';

class BookingGuestModel {
  final String firstname;
  final String lastname;
  final String description;
  final String emailId;
  final String? phoneNumber;

  BookingGuestModel(
      {required this.firstname,
      required this.lastname,
      required this.description,
      required this.emailId,
      this.phoneNumber});

  factory BookingGuestModel.fromUser(UserModel user) {
    return BookingGuestModel(
        firstname: user.firstname,
        lastname: user.lastname,
        description: user.description,
        emailId: user.email);
  }
}
