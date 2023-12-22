import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_employe_time_slot.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_service_entry.dart';
import 'package:heidi/src/data/model/model_step_item.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appointment_state.dart';
import 'package:heidi/src/presentation/main/add_listing/create_appointment/cubit/create_appoitment_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_service_entry.dart';
import 'package:heidi/src/presentation/widget/app_stepper.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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
  int _active = 0;
  TextEditingController employeeController = TextEditingController();
  List<ServiceEntry> serviceEntries = [ServiceEntry()];
  List<EmployeeTimeSlots> employeeTimeSlots = [EmployeeTimeSlots()];
  List<int> employeeSelectedTimeSlots = [];

  @override
  Widget build(BuildContext context) {
    List<StepModel> step = [
      StepModel(
        title: Translate.of(context).translate('service'),
        icon: Icons.home_repair_service,
      ),
      StepModel(
        title: Translate.of(context).translate('time_slots'),
        icon: Icons.timer,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('create_appointment')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            AppStepper(
              active: _active,
              list: step,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildContent(),
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

  Widget _buildContent() {
    switch (_active) {
      case 0:
        return _buildServices();
      case 1:
        return _buildTimeSlots();
      default:
        return Container();
    }
  }

  Widget _buildAction() {
    switch (_active) {
      case 0:
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: AppButton(
            Translate.of(context).translate('next'),
            onPressed: () {
              _onNext(step: 0);
            },
            mainAxisSize: MainAxisSize.max,
          ),
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  Translate.of(context).translate('previous'),
                  onPressed: _onPrevious,
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  Translate.of(context).translate('create_appointment'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
              )
            ],
          ),
        );
      default:
        return Container();
    }
  }

  void _onPrevious() {
    Utils.hiddenKeyboard(context);
    setState(() {
      _active -= 1;
    });
  }

  void _onNext({
    required int step,
  }) async {
    Utils.hiddenKeyboard(context);
    if (step == 0) {
      setState(() {
        _active += 1;
      });
    } else if (step == 1) {
      setState(() {
        _active += 1;
      });
    }
  }

  Widget _buildServices() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < serviceEntries.length; i++)
            BuildServiceEntry(
              entry: serviceEntries[i],
              index: i,
              onDelete: (index) {
                setState(() {
                  serviceEntries.removeAt(index);
                });
              },
              onEntryCallback: (data) {
                setState(() {});
              },
            ),
          // _buildServiceEntry(serviceEntries[i], i),
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

  Widget _buildTimeSlots() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < employeeTimeSlots.length; i++)
            _buildServiceEntry(employeeTimeSlots[i], i),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.white),
                onPressed: () {
                  // Add a new service entry
                  setState(() {
                    employeeTimeSlots.add(EmployeeTimeSlots());
                  });
                },
              ),
              const SizedBox(width: 8),
              const Text('Add More Employees'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceEntry(EmployeeTimeSlots employee, int index) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: employee.controller,
                decoration: InputDecoration(
                  labelText: 'Mitarbeiter ${index + 1}',
                  border:
                      const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
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
                    // employee.timeSlots.addAll(value as List<OpenTimeModel>);
                    logError('OpenTIme', timeSlots.length);
                  }
                  // logError('OpenTIme', employee.timeSlots[0].dayOfWeek);
                  // logError('OpenTIme', employee.timeSlots[0].schedule[0].start);
                  // logError('OpenTIme', employee.timeSlots[0].schedule[0].end);
                  return true;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  employeeTimeSlots.removeAt(index);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            MultiSelectDialogField(
              items: serviceEntries
                  .map((service) => MultiSelectItem<String>(
                      service.controller.text, service.controller.text))
                  .toList(),
              title: Text(Translate.of(context).translate('select_services')),
              buttonText:
                  Text(Translate.of(context).translate('select_services')),
              itemsTextStyle: const TextStyle(color: Colors.white),
              selectedItemsTextStyle:
                  TextStyle(color: Theme.of(context).primaryColor),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              unselectedColor: Colors.white,
              onConfirm: (values) {
                setState(() {
                  employee.selectedServices = values;
                });
              },
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
