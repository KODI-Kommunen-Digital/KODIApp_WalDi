import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_open_time.dart';

class EmployeeTimeSlots {
  TextEditingController controller = TextEditingController();
  List<String> selectedServices = [];
  List<OpenTimeModel> timeSlots = [];

  EmployeeTimeSlots();
}
