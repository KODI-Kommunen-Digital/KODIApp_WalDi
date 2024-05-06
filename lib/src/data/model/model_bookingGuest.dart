// ignore_for_file: file_names

import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_schedule.dart';

class BookingGuestModel {
  final String firstname;
  final String lastname;
  final String description;
  final String email;
  final String? phoneNumber;
  final ScheduleModel? slot;

  BookingGuestModel(
      {required this.firstname,
      required this.lastname,
      required this.description,
      required this.email,
      this.phoneNumber,
      this.slot});

  factory BookingGuestModel.fromUser(UserModel user, {ScheduleModel? slot}) {
    return BookingGuestModel(
        firstname: user.firstname,
        lastname: user.lastname,
        description: user.description,
        email: user.email,
        slot: slot);
  }
}
