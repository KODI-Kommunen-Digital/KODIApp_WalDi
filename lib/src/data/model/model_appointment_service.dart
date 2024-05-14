import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:intl/intl.dart';

class AppointmentServiceModel {
  final int id;
  final int appointmentId;
  String name;
  final int userId;
  int duration = 15;
  final bool slotSameAsAppointment;
  final int? maxBookingPerSlot;
  final Set? openingDates;
  final List<HolidayModel>? holidays;
  TextEditingController controller = TextEditingController();
  bool providedTimeSlots = true;

  AppointmentServiceModel(
      {required this.id,
      required this.appointmentId,
      required this.name,
      required this.userId,
      required this.duration,
      required this.slotSameAsAppointment,
      this.maxBookingPerSlot,
      this.openingDates,
      this.holidays});

  factory AppointmentServiceModel.fromJson(Map<String, dynamic> json) {
    Set parsedOpenHours = {};
    List<HolidayModel>? parsedHolidays = [];
    int? maxBookingPerSlot; //Change dummy data
    if (json['metadata'] != null) {
      Map<String, dynamic> metaData = jsonDecode(json['metadata']);
      final List<dynamic>? jsonHolidays = metaData['holidays'];

      if (metaData['maxBookingPerSlot'] != null) {
        maxBookingPerSlot = metaData['maxBookingPerSlot'];
      }

      if (jsonHolidays != null) {
        for (var holiday in jsonHolidays) {
          final DateTime parsedDate = DateTime.parse(holiday['date']);
          String date = DateFormat('dd.MM.yyyy').format(parsedDate);
          parsedHolidays.add(HolidayModel(date: date, title: holiday['title']));
        }
      } else {
        parsedHolidays = [];
      }

      final Map<String, dynamic>? openHours = metaData['openingDates'];

      if (openHours != null) {
        const daysOfWeek = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];

        for (int i = 0; i < daysOfWeek.length; i++) {
          String day = daysOfWeek[i];

          if (openHours[day] != null) {
            TimeOfDay startTime =
                timeOfDayFromString(openHours[day].first['startTime']);
            TimeOfDay endTime = timeOfDayFromString(openHours[day].first['endTime']);
            ScheduleModel schedule =
                ScheduleModel(startTime: startTime, endTime: endTime);

            parsedOpenHours.add(OpenTimeModel(
                dayOfWeek: i + 1,
                key: day.substring(0, 3).toLowerCase(),
                schedule: [schedule]));
          }
        }
      } else {
        parsedOpenHours = {};
      }
    }

    return AppointmentServiceModel(
        id: json['id'],
        appointmentId: json['appointmentId'],
        name: json['name'] ?? '',
        userId: json['userId'] ?? 0,
        duration: json['duration'],
        // slotSameAsAppointment: ((json['slotSameAsAppointment'] ?? 0) == 1),
        slotSameAsAppointment: true,
        maxBookingPerSlot: maxBookingPerSlot ?? 8, //Change default value
        openingDates: parsedOpenHours,
        holidays: parsedHolidays);
  }

  static List<Map<String, dynamic>> parseToParams(
      List<AppointmentServiceModel> services) {
    List<Map<String, dynamic>> parsedServices = [];
    for (AppointmentServiceModel service in services) {
      List<Map<String, String>>? parsedHolidays =
          AppointmentRepository.parseHolidays(service.holidays);
      Map<String, List<Map<String, String>>?>? parsedOpenHours;

      if (service.openingDates != null) {
        // Cast the Set<dynamic> to Set<OpenTimeModel> and then convert it to a List<OpenTimeModel>
        List<OpenTimeModel> openingDatesList =
            service.openingDates!.cast<OpenTimeModel>().toList();
        parsedOpenHours =
            AppointmentRepository.parseOpenHours(openingDatesList);
      }

      Map<String, dynamic> metaData = {};

      if (parsedHolidays != null) {
        metaData['holidays'] = parsedHolidays;
      } else {
        metaData['holidays'] = [];
      }

      if (service.maxBookingPerSlot != null) {
        metaData['maxBookingPerSlot'] = service.maxBookingPerSlot;
      }
      if (parsedOpenHours != null && parsedOpenHours.isNotEmpty) {
        metaData['openingDates'] = parsedOpenHours;
      }

      Map<String, dynamic> params = {
        'name': service.name,
        'duration': service.duration,
        // 'slotSameAsAppointment': service.slotSameAsAppointment,
        'slotSameAsAppointment': true,
        'metadata': metaData
      };

      parsedServices.add(params);
    }
    return parsedServices;
  }

  static TimeOfDay timeOfDayFromString(String time) {
    List<String> timeParts = time.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: minutes);

    return timeOfDay;
  }
}
