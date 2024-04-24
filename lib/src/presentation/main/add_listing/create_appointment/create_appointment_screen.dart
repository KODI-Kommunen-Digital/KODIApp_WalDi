import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appointment_state.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appoitment_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

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
  List<AppointmentServiceModel> serviceEntries = [
    AppointmentServiceModel(
        id: 1,
        appointmentId: 1,
        userId: 1,
        name: '',
        duration: 15,
        slotSameAsAppointment: true)
  ];
  List<OpenTimeModel> timeSlots = [];
  List<DateTime?> selectedDates = [];
  bool nameError = true;

  Future<void> _navigateAndDisplayTimeSlots(BuildContext context) async {
    final result = await Navigator.pushNamed(context, Routes.openTime);

    if (result != null) {
      timeSlots = (result as List)[0] as List<OpenTimeModel>;
      selectedDates = [];
    }
  }

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
              _navigateAndDisplayTimeSlots(context);
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
          if (nameError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  Translate.of(context).translate("service_hint"),
                ),
              ),
            );
          } else {
            Navigator.pop(context, [serviceEntries, timeSlots]);
          }
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
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: serviceEntries[index].controller,
                          decoration: InputDecoration(
                            labelText: Translate.of(context)
                                .translate('addServiceName'),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              serviceEntries[index].name = value;
                            });
                          },
                          validator: (value) {
                            if ((value?.length ?? 0) < 3) {
                              nameError = true;
                              return Translate.of(context).translate("service_hint");
                            }
                            nameError = false;
                            return null; // Return null if the validation succeeds
                          },
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
                          _navigateAndDisplayTimeSlots(context);
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
                // Row(
                //   children: <Widget>[
                //     Text(Translate.of(context).translate('providedTimeSlot')),
                //     Checkbox(
                //       value: serviceEntries[index].providedTimeSlots,
                //       activeColor: Colors.blue,
                //       checkColor: Colors.white,
                //       onChanged: (value) {
                //         setState(() {
                //           serviceEntries[index].providedTimeSlots = value!;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Text('Duration:'),
                    const SizedBox(width: 20),
                    DropdownButton<int>(
                      value: serviceEntries[index].duration,
                      onChanged: (value) {
                        setState(() {
                          serviceEntries[index].duration = value!;
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
                    serviceEntries.add(AppointmentServiceModel(
                        id: 1,
                        appointmentId: 1,
                        name: '',
                        userId: 1,
                        duration: 15,
                        slotSameAsAppointment: false));
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(Translate.of(context).translate('addMoreServices')),
            ],
          ),
        ],
      ),
    );
  }
}
