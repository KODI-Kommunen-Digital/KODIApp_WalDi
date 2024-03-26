import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/data/repository/appointment_repository.dart';
import 'package:intl/intl.dart';

class AppointmentServiceModel {
  final int id;
  final int appointmentId;
  final String name;
  final int userId;
  final int duration;
  final bool slotSameAsAppointment;
  final int? maxBookingPerSlot;
  final List<OpenTimeModel>? openHours;
  final List<HolidayModel>? holidays;

  AppointmentServiceModel(
      {required this.id,
      required this.appointmentId,
      required this.name,
      required this.userId,
      required this.duration,
      required this.slotSameAsAppointment,
      this.maxBookingPerSlot,
      this.openHours,
      this.holidays});

  factory AppointmentServiceModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? jsonHolidays = json['MetaData']['Holidays'];
    List<HolidayModel>? parsedHolidays = [];

    if (jsonHolidays != null) {
      for (var holiday in jsonHolidays) {
        final DateTime parsedDate = DateTime.parse(holiday['date']);
        String date = DateFormat('dd.MM.yyyy').format(parsedDate);
        parsedHolidays.add(HolidayModel(date: date, title: holiday['title']));
      }
    } else {
      parsedHolidays = null;
    }

    final Map<String, dynamic>? openHours = json['MetaData']['OpeningDates'];
    List<OpenTimeModel>? parsedOpenHours = [];

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
              timeOfDayFromString(openHours[day]['startTime']);
          TimeOfDay endTime = timeOfDayFromString(openHours[day]['endTime']);
          ScheduleModel schedule =
              ScheduleModel(start: startTime, end: endTime);

          parsedOpenHours.add(OpenTimeModel(
              dayOfWeek: i + 1,
              key: day.substring(0, 3).toLowerCase(),
              schedule: [schedule]));
        }
      }
    } else {
      parsedOpenHours = null;
    }

    return AppointmentServiceModel(
        id: json['id'],
        appointmentId: json['appointmentId'],
        name: json['name'] ?? '',
        userId: json['userId'] ?? 0,
        duration: json['duration'],
        slotSameAsAppointment: ((json['slotSameAsAppointment'] ?? 0) == 1),
        maxBookingPerSlot: json['MetaData']['maxBookingPerSlot'],
        openHours: parsedOpenHours,
        holidays: parsedHolidays);
  }

  static List<Map<String, dynamic>> parseToParams(
      List<AppointmentServiceModel> services) {
    List<Map<String, dynamic>> parsedServices = [];
    for (AppointmentServiceModel service in services) {
      List<Map<String, String>>? parsedHolidays =
          AppointmentRepository.parseHolidays(service.holidays);
      Map<String, List<Map<String, String>>>? parsedOpenHours =
          AppointmentRepository.parseOpenHours(service.openHours);

      Map<String, dynamic> metaData = {
        'holidays': parsedHolidays,
        'maxBookingPerSlot': service.maxBookingPerSlot,
        'openingDates': parsedOpenHours
      };

      Map<String, dynamic> params = {
        'name': service.name,
        'duration': service.duration,
        'slotSameAsAppointment': service.slotSameAsAppointment,
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
