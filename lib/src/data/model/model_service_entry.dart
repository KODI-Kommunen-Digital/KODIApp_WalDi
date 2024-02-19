import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_open_time.dart';

class ServiceEntry {
  TextEditingController controller = TextEditingController();
  int selectedMinutes = 15;
  List<OpenTimeModel> employeeTimeSlots = [];
  bool providedTimeSlots = true;

  ServiceEntry();
}
