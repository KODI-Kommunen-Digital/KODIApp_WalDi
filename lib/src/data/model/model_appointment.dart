import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:intl/intl.dart';

class AppointmentModel {
  final int id;
  final int userId;
  final int? cityId;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final int? maxBookingPerSlot;
  final List<OpenTimeModel?>? openHours;
  final List<HolidayModel>? holidays;

  AppointmentModel(
      {required this.id,
      required this.userId,
      this.cityId,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      this.maxBookingPerSlot,
      this.openHours,
      this.holidays});

  factory AppointmentModel.fromJson(Map<String, dynamic> json, {int? cityId}) {
    final DateTime parsedStartDate = DateTime.parse(json['startDate']);
    final DateTime parsedEndDate = DateTime.parse(json['endDate']);
    String startDate = DateFormat('dd.MM.yyyy HH:mm').format(parsedStartDate);
    String endDate = DateFormat('dd.MM.yyyy HH:mm').format(parsedEndDate);

    final List<dynamic>? jsonHolidays = json['metaData']['Holidays'];
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

    final Map<String, dynamic>? openHours = json['metaData']['OpeningDates'];
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

    return AppointmentModel(
        id: json["id"],
        userId: json["userId"] ?? 0,
        title: json["title"] ?? "",
        cityId: cityId ?? json["cityId"] ?? 0,
        description: json["description"] ?? "",
        maxBookingPerSlot: json['metaData']['maxBookingPerSlot'],
        startDate: startDate,
        endDate: endDate,
        holidays: parsedHolidays,
        openHours: parsedOpenHours);
  }

  static TimeOfDay timeOfDayFromString(String time) {
    List<String> timeParts = time.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: minutes);

    return timeOfDay;
  }
}
