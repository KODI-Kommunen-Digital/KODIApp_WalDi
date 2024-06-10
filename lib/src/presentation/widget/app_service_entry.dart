import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';

class BuildServiceEntry extends StatefulWidget {
  final AppointmentServiceModel entry;
  final int index;
  final ValueSetter<AppointmentServiceModel>? onEntryCallback;
  final ValueSetter<int>? onDelete;
  final ValueSetter<List<OpenTimeModel>>? selectedTimeSlots;

  const BuildServiceEntry({
    super.key,
    required this.entry,
    this.onEntryCallback,
    this.onDelete,
    required this.index,
    this.selectedTimeSlots,
  });

  @override
  State<BuildServiceEntry> createState() => _BuildServiceEntryState();
}

class _BuildServiceEntryState extends State<BuildServiceEntry> {
  AppointmentServiceModel? entry;
  bool userProvidedTimeSlots = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entry = widget.entry;
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: entry?.controller,
                decoration: const InputDecoration(
                  labelText: 'Add Service Name',
                  border: OutlineInputBorder(), // Add this line for border
                ),
              ),
            ),
            const SizedBox(width: 8),
            Visibility(
              visible: !userProvidedTimeSlots,
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  size: 32,
                ),
                onPressed: () {
                  List<OpenTimeModel> timeSlots = [];
                  Navigator.pushNamed(context, Routes.openTime).then((value) {
                    if (value != null) {
                      timeSlots.addAll(value as List<OpenTimeModel>);
                      logError('OpenTIme', timeSlots.length);
                      widget.selectedTimeSlots!(timeSlots);
                    }
                    return true;
                  });
                },
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  widget.onDelete!(widget.index);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const Text('Use provided time slot:'),
            Checkbox(
              value: userProvidedTimeSlots,
              activeColor: Colors.blue,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  userProvidedTimeSlots = value!;
                });
              },
            ),
          ],
        ),
        // const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const Text('Duration:'),
            const SizedBox(width: 20),
            DropdownButton<int>(
              value: entry?.duration,
              onChanged: (value) {
                setState(() {
                  entry?.duration = value!;
                  widget.onEntryCallback!(entry!);
                });
              },
              items: List.generate(
                5,
                (index) => DropdownMenuItem<int>(
                  value: (index + 1) * 15,
                  child: Text('${(index + 1) * 15} ${Translate.of(context).translate('minutes')}'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          thickness: 3,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
