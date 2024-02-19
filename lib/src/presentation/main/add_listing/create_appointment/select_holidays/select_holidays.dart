import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:intl/intl.dart';

class SelectHolidaysScreen extends StatefulWidget {
  const SelectHolidaysScreen({super.key});

  @override
  State<SelectHolidaysScreen> createState() => _SelectHolidaysScreenState();
}

class _SelectHolidaysScreenState extends State<SelectHolidaysScreen> {
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Holidays',
        ),
        actions: [
          AppButton(
            'Done',
            onPressed: () {
              Navigator.of(context).pop(_multiDatePickerValueWithDefaultValue);
            },
            type: ButtonType.text,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            CalendarDatePicker2(
               config: config,
              value: _multiDatePickerValueWithDefaultValue,
              onValueChanged: (dates) =>
                  setState(() => _multiDatePickerValueWithDefaultValue = dates),
            ),
            const SizedBox(height: 10),
            const Text('Selected Holiday Dates: \n'),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ..._multiDatePickerValueWithDefaultValue.map((date) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Chip(
                      label: Text(DateFormat('dd.MM.yyyy').format(date!)),
                      onDeleted: () {
                        setState(() {
                          _multiDatePickerValueWithDefaultValue.remove(date);
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  final config = CalendarDatePicker2Config(
    calendarType: CalendarDatePicker2Type.multi,
    selectedDayHighlightColor: Colors.indigo,
  );
}
