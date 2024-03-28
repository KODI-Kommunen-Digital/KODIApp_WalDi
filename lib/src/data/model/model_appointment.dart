import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_holiday.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:intl/intl.dart';

class AppointmentModel {
  final int? id;
  final int? userId;
  final int? cityId;
  final String title;
  final String description;
  final String startDate;
  final String? endDate;
  final int? maxBookingPerSlot;
  final List<OpenTimeModel?> openHours;
  final List<HolidayModel>? holidays;

  AppointmentModel(
      {this.id,
      this.userId,
      this.cityId,
      required this.title,
      required this.description,
      required this.startDate,
      this.endDate,
      this.maxBookingPerSlot,
      required this.openHours,
      this.holidays});

  factory AppointmentModel.fromJson(Map<String, dynamic> json, {int? cityId}) {
    final DateTime parsedStartDate = DateTime.parse(json['startDate']);
    final DateTime? parsedEndDate = DateTime.tryParse(json['endDate'] ?? '');
    String startDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedStartDate);
    String? endDate;

    if (parsedEndDate != null) {
      endDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedEndDate);
    }

    final List<dynamic>? jsonHolidays = json['metaData']['Holidays'];
    List<HolidayModel>? parsedHolidays = [];

    if (jsonHolidays != null) {
      for (var holiday in jsonHolidays) {
        final DateTime parsedDate = DateTime.parse(holiday['date']);
        String date = DateFormat('dd-MM-yyyy').format(parsedDate);
        parsedHolidays.add(HolidayModel(date: date, title: holiday['title']));
      }
    } else {
      parsedHolidays = null;
    }

    final Map<String, dynamic> openHours =
        json['metaData']['OpeningDates'] ?? {};
    List<OpenTimeModel> parsedOpenHours = [];

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
        TimeOfDay startTime = timeOfDayFromString(openHours[day]['startTime']);
        TimeOfDay endTime = timeOfDayFromString(openHours[day]['endTime']);
        ScheduleModel schedule = ScheduleModel(start: startTime, end: endTime);

        parsedOpenHours.add(OpenTimeModel(
            dayOfWeek: i + 1,
            key: day.substring(0, 3).toLowerCase(),
            schedule: [schedule]));
      } else {
        openHours[day] = null;
      }
    }

    return AppointmentModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'] ?? '',
      cityId: cityId ?? json['cityId'] ?? 0,
      description: json['description'] ?? '',
      maxBookingPerSlot: json['metaData']['maxBookingPerSlot'],
      startDate: startDate,
      endDate: endDate,
      holidays: parsedHolidays,
      openHours: parsedOpenHours,
    );
  }

  static TimeOfDay timeOfDayFromString(String time) {
    List<String> timeParts = time.split(':');
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
