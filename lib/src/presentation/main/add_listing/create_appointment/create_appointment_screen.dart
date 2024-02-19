import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_service_entry.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appointment_state.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appoitment_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';

class CreateAppointmentScreen extends StatelessWidget {
  const CreateAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAppointmentCubit, CreateAppointmentState>(
      listener: (context, state) {},
      builder: (context, state) => state.maybeWhen(
        loading: () => const CreateAppointmentLoading(),
        loaded: () => const CreateAppointmentLoaded(),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class CreateAppointmentLoading extends StatelessWidget {
  const CreateAppointmentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class CreateAppointmentLoaded extends StatefulWidget {
  const CreateAppointmentLoaded({super.key});

  @override
  State<CreateAppointmentLoaded> createState() =>
      _CreateAppointmentLoadedState();
}

class _CreateAppointmentLoadedState extends State<CreateAppointmentLoaded> {
  List<ServiceEntry> serviceEntries = [ServiceEntry()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('create_appointment')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month,
              size: 32,
            ),
            onPressed: () {
              List<OpenTimeModel> timeSlots = [];
              Navigator.pushNamed(context, Routes.openTime).then((value) {
                if (value != null) {
                  timeSlots.addAll(value as List<OpenTimeModel>);
                  logError('OpenTime', timeSlots.length);
                }
                return true;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildServices(),
                  ),
                ],
              ),
            ),
            _buildAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: AppButton(
        Translate.of(context).translate('create_appointment'),
        onPressed: () {
          Navigator.pop(context);
        },
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  Widget _buildServices() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          for (int index = 0; index < serviceEntries.length; index++)
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: serviceEntries[index].controller,
                        decoration: const InputDecoration(
                          labelText: 'Add Service Name',
                          border:
                              OutlineInputBorder(), // Add this line for border
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Visibility(
                      visible: !serviceEntries[index].providedTimeSlots,
                      child: IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                          size: 32,
                        ),
                        onPressed: () {
                          List<OpenTimeModel> timeSlots = [];
                          Navigator.pushNamed(context, Routes.openTime)
                              .then((value) {
                            if (value != null) {
                              serviceEntries[index]
                                  .employeeTimeSlots
                                  .addAll(value as List<OpenTimeModel>);
                              logError('OpenTIme', timeSlots.length);
                              // widget.selectedTimeSlots!(timeSlots);
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
                          setState(() {
                            serviceEntries.removeAt(index);
                          });
                          // widget.onDelete!(widget.index);
                          // employeeTimeSlots.removeAt(index);
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
                      value: serviceEntries[index].providedTimeSlots,
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          serviceEntries[index].providedTimeSlots = value!;
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
                      value: serviceEntries[index].selectedMinutes,
                      onChanged: (value) {
                        setState(() {
                          serviceEntries[index].selectedMinutes = value!;
                          // widget.onEntryCallback!(entry!);
                        });
                      },
                      items: List.generate(
                        5,
                        (index) => DropdownMenuItem<int>(
                          value: (index + 1) * 15,
                          child: Text('${(index + 1) * 15} mins'),
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
            ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.white),
                onPressed: () {
                  // Add a new service entry
                  setState(() {
                    serviceEntries.add(ServiceEntry());
                  });
                },
              ),
              const SizedBox(width: 8),
              const Text('Add More Services'),
            ],
          ),
        ],
      ),
    );
  }
}
