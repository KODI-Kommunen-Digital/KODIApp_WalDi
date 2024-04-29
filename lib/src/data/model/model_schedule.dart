import 'package:flutter/material.dart';
import 'package:heidi/src/utils/datetime.dart';
import 'package:intl/intl.dart';

class ScheduleModel {
  String? view;
  String? date;
  TimeOfDay startTime;
  TimeOfDay endTime;

  ScheduleModel(
      {this.view, required this.startTime, required this.endTime, this.date});

  get title {
    if (view != null) {
      return view;
    }
    return '${startTime.viewTime} - ${endTime.viewTime}';
  }

  factory ScheduleModel.fromString(String value, {String? date}) {
    final arr = value.split(" - ");
    return ScheduleModel(
      startTime: TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(arr[0])),
      endTime: TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(arr[1])),
      date: date
    );
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    if (json['startTime'].toString() == '0') {
      json['startTime'] = '00:00';
    }
    if (json['endTime'].toString() == '0') {
      json['endTime'] = '00:00';
    }

    return ScheduleModel(
      view: json['format'],
      startTime:
          TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(json['startTime'])),
      endTime:
          TimeOfDay.fromDateTime(DateFormat('HH:mm').parse(json['endTime'])),
    );
  }
}
