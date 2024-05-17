import 'dart:convert';

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
  String? imageLink;

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
      this.holidays,
      this.imageLink});

  factory AppointmentModel.fromJson(Map<String, dynamic> json, {int? cityId}) {
    List<OpenTimeModel> parsedOpenHours = [];
    List<HolidayModel>? parsedHolidays = [];
    int? maxBookingPerSlot;
    String? endDate;

    final DateTime parsedStartDate = DateTime.parse(json['startDate']);
    if (json['endDate'] != null) {
      final DateTime? parsedEndDate = DateTime.tryParse(json['endDate'] ?? '');
      if (parsedEndDate != null) {
        endDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedEndDate);
      }
    }
    String startDate = DateFormat('yyyy-MM-ddHH:mm').format(parsedStartDate);

    if (json['metadata'] != null) {
      Map<String, dynamic> metaData = jsonDecode(json['metadata']);

      maxBookingPerSlot = metaData['maxBookingPerSlot'] is int
          ? metaData['maxBookingPerSlot']
          : metaData['maxBookingPerSlot'] != null
              ? int.parse(metaData['maxBookingPerSlot'])
              : 0;

      final List<dynamic>? jsonHolidays = metaData['holidays'];

      if (jsonHolidays != null) {
        for (var holiday in jsonHolidays) {
          final DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(holiday['date']);
          String date = DateFormat('yyyy-MM-dd').format(parsedDate);
          parsedHolidays.add(HolidayModel(date: date, title: holiday['title']));
        }
      } else {
        parsedHolidays = null;
      }

      final Map<String, dynamic> openHours = metaData['openingDates'] ?? {};

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
          List<dynamic> schedules = openHours[day];
          for (var schedule in schedules) {
            TimeOfDay startTime = timeOfDayFromString(schedule['startTime']!);
            TimeOfDay endTime = timeOfDayFromString(schedule['endTime']!);
            ScheduleModel parsedSchedule =
                ScheduleModel(startTime: startTime, endTime: endTime);

            parsedOpenHours.add(OpenTimeModel(
                dayOfWeek: i + 1,
                key: day.substring(0, 3).toLowerCase(),
                schedule: [parsedSchedule]));
          }
        } else {
          openHours[day] = null;
        }
      }
    }
    return AppointmentModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'] ?? '',
      cityId: cityId ?? json['cityId'] ?? 0,
      description: json['description'] ?? '',
      maxBookingPerSlot: maxBookingPerSlot ?? 8,
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

  String getStartTime(String startTime) {
    if (startTime.length < 10) return startTime;
    String startDate = _formatDate(startTime.substring(0, 10));
    String startHour = startTime.substring(10);
    return "$startDate, $startHour";
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}
