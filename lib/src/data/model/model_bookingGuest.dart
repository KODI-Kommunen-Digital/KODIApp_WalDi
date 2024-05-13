// ignore_for_file: file_names

import 'package:heidi/src/data/model/model_booking.dart';
import 'package:heidi/src/data/model/model_schedule.dart';

class BookingGuestModel {
  final String firstname;
  final String lastname;
  final String? remark;
  final String email;
  final String? phoneNumber;
  final ScheduleModel? slot;

  BookingGuestModel(
      {required this.firstname,
      required this.lastname,
      required this.remark,
      required this.email,
      this.phoneNumber,
      this.slot});

  factory BookingGuestModel.fromUser(GuestDetails user, String? remark,
      {ScheduleModel? slot}) {
    return BookingGuestModel(
        firstname: user.firstname,
        lastname: user.lastname,
        remark: remark ?? 'Keine Bemerkungen',
        email: user.email,
        slot: slot);
  }
}
