import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class SelectHolidaysScreen extends StatefulWidget {
  final List<DateTime?> selectedDates;

  const SelectHolidaysScreen({Key? key, required this.selectedDates})
      : super(key: key);

  @override
  State<SelectHolidaysScreen> createState() => _SelectHolidaysScreenState();
}

class _SelectHolidaysScreenState extends State<SelectHolidaysScreen> {
  late List<DateTime?> _multiDatePickerValue;

  @override
  void initState() {
    super.initState();
    _multiDatePickerValue = widget.selectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('selectHolidays')),
        actions: [
          AppButton(
            'Done',
            onPressed: () {
              Navigator.of(context).pop(_multiDatePickerValue);
            },
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.multi,
                selectedDayHighlightColor: Colors.indigo,
              ),
              value: _multiDatePickerValue,
              onValueChanged: (dates) {
                setState(() {
                  _multiDatePickerValue = dates;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text('Selected Holiday Dates:'),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _multiDatePickerValue.map((date) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Chip(
                    label: Text(DateFormat('dd.MM.yyyy').format(date!)),
                    onDeleted: () {
                      setState(() {
                        _multiDatePickerValue.remove(date);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
