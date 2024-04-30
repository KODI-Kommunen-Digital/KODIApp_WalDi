// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_picker_item.dart';
// import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/datetime.dart';
import 'package:heidi/src/utils/translate.dart';

class OpenTimeSlotsScreen extends StatefulWidget {
  final List<OpenTimeModel?>? selected;

  const OpenTimeSlotsScreen({Key? key, this.selected}) : super(key: key);

  @override
  State<OpenTimeSlotsScreen> createState() {
    return _OpenTimeSlotsScreenState();
  }
}

class _OpenTimeSlotsScreenState extends State<OpenTimeSlotsScreen> {
  final _defaultStartTime = const TimeOfDay(hour: 0, minute: 0);
  final _defaultEndTime = const TimeOfDay(hour: 0, minute: 0);
  List<OpenTimeModel> _time = [];
  List<DateTime?> selectedDates = [];

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      for(var schedule in widget.selected!) {
        if(schedule != null) {
          _time.add(schedule);
        }
      }
    } else {
      _time = [
        OpenTimeModel(dayOfWeek: 1, key: 'mon', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 2, key: 'tue', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 3, key: 'wed', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 4, key: 'thu', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 5, key: 'fri', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 6, key: 'sat', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
        OpenTimeModel(dayOfWeek: 7, key: 'sun', schedule: [
          ScheduleModel(
            startTime: _defaultStartTime,
            endTime: _defaultEndTime,
          ),
        ]),
      ];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> _navigateAndDisplayHolidays(BuildContext context) async {
  //   final result =
  //       await Navigator.pushNamed(context, Routes.selectHolidays, arguments: {
  //     'selectedDates': selectedDates,
  //   });

  //   // if (result != null) {
  //   //   setState(() {
  //   //     selectedDates = result as List<DateTime?>;
  //   //   });
  //   // }
  // }

  ///Show Time Time
  void _onTimePicker(TimeOfDay time, Function(TimeOfDay) callback) async {
    final picked = await showTimePicker(
      initialTime: time,
      context: context,
    );

    if (picked != null) {
      callback(picked);
    }
  }

  ///On Save
  void _onSave() {
    Navigator.pop(context, [_time, selectedDates]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('open_time'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('apply'),
            onPressed: _onSave,
            type: ButtonType.text,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final item = _time[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translate.of(context).translate(item.key),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final addAction = index == 0;
                          final element = item.schedule[index];
                          return Row(
                            children: [
                              Expanded(
                                child: AppPickerItem(
                                  value: element.startTime.viewTime,
                                  title: Translate.of(context).translate(
                                    'choose_hours',
                                  ),
                                  onPressed: () {
                                    _onTimePicker(element.startTime, (time) {
                                      setState(() {
                                        element.startTime = time;
                                      });
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppPickerItem(
                                  value: element.endTime.viewTime,
                                  title: Translate.of(context).translate(
                                    'choose_hours',
                                  ),
                                  onPressed: () {
                                    _onTimePicker(element.endTime, (time) {
                                      setState(() {
                                        element.endTime = time;
                                      });
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  if (addAction) {
                                    item.schedule.add(
                                      ScheduleModel(
                                        startTime: _defaultStartTime,
                                        endTime: _defaultEndTime,
                                      ),
                                    );
                                  } else {
                                    item.schedule.remove(element);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Icon(
                                    addAction ? Icons.add : Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemCount: item.schedule.length,
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: _time.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Theme.of(context).dividerColor.withOpacity(.07),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: TextButton(
                    //   onPressed: () {
                    //     _navigateAndDisplayHolidays(context);
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         Translate.of(context).translate('selectHolidays'),
                    //         style: TextStyle(
                    //           color: Colors
                    //               .white, // Change color to blue for hyperlink style
                    //           // Remove TextDecoration.underline
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 4,
                    //       ),
                    //       Icon(
                    //         Icons.arrow_forward,
                    //         color:
                    //             Colors.blue, // Match icon color with text color
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
