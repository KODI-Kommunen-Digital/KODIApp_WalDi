import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_schedule.dart';

class AppointmentSlotModel {
  final int serviceId;
  final int appointmentId;
  final String name;
  final int duration;
  final bool slotSameAsAppointment;
  final List<ScheduleModel> openHours;

  AppointmentSlotModel(
      {required this.serviceId,
      required this.appointmentId,
      required this.name,
      required this.duration,
      required this.slotSameAsAppointment,
      required this.openHours});

  factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> openHours = json['openingHours'];
    List<ScheduleModel> schedules = [];
    for (var day in openHours) {
      schedules.add(ScheduleModel(
          startTime: timeOfDayFromString(day["startTime"]!),
          endTime: timeOfDayFromString(day["endTime"]!)));
    }

    return AppointmentSlotModel(
        serviceId: json['serviceId'] ?? 0,
        appointmentId: json['appointmentId'] ?? 0,
        name: json['name'] ?? '',
        duration: json['duration'] ?? 0,
        slotSameAsAppointment: ((json['slotSameAsAppointment'] ?? 0) == 1),
        openHours: schedules);
  }

  static TimeOfDay timeOfDayFromString(String time) {
    List<String> timeParts = time.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: minutes);

    return timeOfDay;
  }

  static String stringFromTimeOfDay(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
