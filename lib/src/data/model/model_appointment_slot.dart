import 'package:flutter/material.dart';

class AppointmentSlotModel {
  final int serviceId;
  final int appointmentId;
  final String name;
  final int duration;
  final bool slotSameAsAppointment;
  final List<Map<String, TimeOfDay>> openHours;

  AppointmentSlotModel(
      {required this.serviceId,
      required this.appointmentId,
      required this.name,
      required this.duration,
      required this.slotSameAsAppointment,
      required this.openHours});

  factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) {
    return AppointmentSlotModel(
        serviceId: json['serviceId'] ?? 0,
        appointmentId: json['appointmentId'] ?? 0,
        name: json['name'] ?? '',
        duration: json['duration'] ?? 0,
        slotSameAsAppointment: ((json['slotSameAsAppointment'] ?? 0) == 1),
        openHours: json['openingHours'] ?? []);
  }

  static TimeOfDay timeOfDayFromString(String time) {
    List<String> timeParts = time.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: minutes);

    return timeOfDay;
  }
}
