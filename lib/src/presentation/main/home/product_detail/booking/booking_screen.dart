// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_appointment.dart';
import 'package:heidi/src/data/model/model_appointment_service.dart';
import 'package:heidi/src/data/model/model_appointment_slot.dart';
import 'package:heidi/src/data/model/model_bookingGuest.dart';
import 'package:heidi/src/data/model/model_schedule.dart';
import 'package:heidi/src/data/model/model_step_item.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/cubit/booking_cubit.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/cubit/booking_state.dart';
import 'package:heidi/src/presentation/widget/app_appointment_success.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_number_picker.dart';
import 'package:heidi/src/presentation/widget/app_picker_item.dart';
import 'package:heidi/src/presentation/widget/app_stepper.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final int cityId;
  final int listingId;

  const BookingScreen({
    super.key,
    required this.cityId,
    required this.listingId,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().onLoadBooking(widget.cityId, widget.listingId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {},
      builder: (context, state) => state.maybeWhen(
        loading: () => const BookingDetailsLoading(),
        loaded: (slot, services, appointment) => BookingDetailsLoaded(
            appointment: appointment,
            slot: slot,
            services: services,
            listingId: widget.listingId,
            cityId: widget.cityId),
        orElse: () => ErrorWidget('Failed to load booking details.'),
      ),
    );
  }
}

class BookingDetailsLoading extends StatelessWidget {
  const BookingDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class BookingDetailsLoaded extends StatefulWidget {
  final AppointmentModel appointment;
  final AppointmentSlotModel? slot;
  final List<AppointmentServiceModel> services;
  final int listingId;
  final int cityId;

  const BookingDetailsLoaded(
      {super.key,
      required this.appointment,
      required this.slot,
      required this.services,
      required this.listingId,
      required this.cityId});

  @override
  State<BookingDetailsLoaded> createState() => _BookingDetailsLoadedState();
}

class _BookingDetailsLoadedState extends State<BookingDetailsLoaded> {
  final List<TextEditingController> _textFistNameController = [];
  final List<TextEditingController> _textLastNameController = [];
  final List<TextEditingController> _textPhoneController = [];
  final List<TextEditingController> _textEmailController = [];
  final List<TextEditingController> _textAddressController = [];
  final List<TextEditingController> _textMessageController = [];

  final List<FocusNode> _focusFistName = [];
  final List<FocusNode> _focusLastName = [];
  final List<FocusNode> _focusPhone = [];
  final List<FocusNode> _focusEmail = [];
  final List<FocusNode> _focusAddress = [];
  final List<FocusNode> _focusMessage = [];

  final List<String?> _errorFirstName = [];
  final List<String?> _errorLastName = [];
  final List<String?> errorMessages = [];
  final List<String?> _errorPhone = [];
  final List<String?> _errorEmail = [];
  final List<String?> _errorAddress = [];

  int _active = 0;
  bool isWrongEntry = false;
  String selectedDate = '';
  int adults = 1;
  String selectedTime = '';
  AppointmentServiceModel? _selectedService;
  BookingGuestModel? guestModel;
  List<BookingGuestModel> friends = [];
  bool? submittedSuccessful;
  final List<ScheduleModel> selectedSlots = [];

  final List<ScheduleModel> allSlots = [];
  final List<AppointmentServiceModel> services = [];

  @override
  void initState() {
    selectedDate = context.read<BookingCubit>().selectedDate ?? '';
    _selectedService =
        context.read<BookingCubit>().selectedService ?? widget.services.first;
    allSlots.addAll(widget.slot?.openHours ?? []);
    services.addAll(widget.services);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < (adults); i++) {
      _textFistNameController.add(TextEditingController());
      _textLastNameController.add(TextEditingController());
      _textPhoneController.add(TextEditingController());
      _textEmailController.add(TextEditingController());
      _textAddressController.add(TextEditingController());
      _textMessageController.add(TextEditingController());

      _focusFistName.add(FocusNode());
      _focusLastName.add(FocusNode());
      _focusPhone.add(FocusNode());
      _focusEmail.add(FocusNode());
      _focusAddress.add(FocusNode());
      _focusMessage.add(FocusNode());

      _errorFirstName.add(null);
      _errorLastName.add(null);
      errorMessages.add(null);
      _errorPhone.add(null);
      _errorEmail.add(null);
      _errorAddress.add(null);
    }

    List<StepModel> step = [
      StepModel(
        title: Translate.of(context).translate('details'),
        icon: Icons.calendar_today_outlined,
      ),
      StepModel(
        title: Translate.of(context).translate('contact'),
        icon: Icons.contact_mail_outlined,
      ),
      StepModel(
        title: Translate.of(context).translate('summary'),
        icon: Icons.contact_mail_outlined,
      ),
      StepModel(
        title: Translate.of(context).translate('finish'),
        icon: Icons.check,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('bookAppointment')),
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
        return _buildDetail();
      case 1:
        return _buildContact();
      case 2:
        return _buildSummary();
      case 3:
        return AppointmentSuccess(success: submittedSuccessful ?? false);
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
                  Translate.of(context).translate('next'),
                  onPressed: () {
                    _onNext(step: 1);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
              )
            ],
          ),
        );
      case 2:
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
                  Translate.of(context).translate('next'),
                  onPressed: () async {
                    await _onSubmit();
                    _onNext(step: 2);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
              )
            ],
          ),
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  Translate.of(context).translate('finish'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
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
      if (selectedDate == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translate.of(context).translate('chooseDate'),
            ),
          ),
        );
      } else {
        setState(() {
          _active += 1;
        });
      }
    } else if (step == 1) {
      for (int i = 0; i < (adults); i++) {
        if (_textFistNameController[i].text.isEmpty) {
          _errorFirstName[i] =
              Translate.of(context).translate('first_name_message');
        }
        if (_textLastNameController[i].text.isEmpty) {
          _errorLastName[i] =
              Translate.of(context).translate('last_name_message');
        }
        if (_textPhoneController[i].text.isEmpty) {
          _errorPhone[i] = Translate.of(context).translate('phone_message');
        }
        if (_textEmailController[i].text.isEmpty) {
          _errorEmail[i] = Translate.of(context).translate('email_message');
        }
        setState(() {
          if (_errorFirstName[i] == null &&
              _errorLastName[i] == null &&
              _errorEmail[i] == null) {
            isWrongEntry = true;
            //address does not get saved!!
            guestModel = BookingGuestModel(
                firstname: _textFistNameController[0].text,
                lastname: _textLastNameController[0].text,
                description: _textMessageController[0].text,
                email: _textEmailController[0].text,
                phoneNumber: _textPhoneController[0].text);
            for (int i = 1; i < adults; i++) {
              friends.add(BookingGuestModel(
                  firstname: _textFistNameController[i].text,
                  lastname: _textLastNameController[i].text,
                  description: '',
                  email: _textEmailController[0].text));
            }
          } else {
            isWrongEntry = false;
          }
        });
      }
      if (isWrongEntry) {
        setState(() {
          _active += 1;
        });
      }
    } else if (step == 2) {
      setState(() {
        _active += 1;
      });
    }
  }

  Widget _buildDetail() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.miscellaneous_services,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedService!.id,
                    hint: Row(
                      children: [
                        Text(
                          Translate.of(context).translate('selectService'),
                        ),
                      ],
                    ),
                    items: services.map((service) {
                      return DropdownMenuItem(
                        value: service.id,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          service.name,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedService = services
                            .firstWhere((element) => element.id == value);
                        _updateSlots();
                      });
                    },
                    elevation: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.white,
                        fontSize: 18),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.white),
                    ),
                    iconSize: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AppPickerItem(
          leading: Icon(
            Icons.person_outline,
            color: Theme.of(context).hintColor,
          ),
          value: adults.toString(),
          title: Translate.of(context).translate('adult'),
          onPressed: () {
            _onPersonPicker(adults, (value) {
              setState(() {
                adults = value;
                selectedSlots.clear();
                allSlots.clear();
                allSlots.addAll(widget.slot?.openHours ?? []);
              });
            });
          },
        ),
        const SizedBox(height: 20),
        AppPickerItem(
          leading: Icon(
            Icons.calendar_today_outlined,
            color: Theme.of(context).hintColor,
          ),
          value: selectedDate,
          title: Translate.of(context).translate('date'),
          onPressed: _onDatePicker,
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(.07),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ScheduleModel>(
              value: null,
              items: _buildDropdownItems(),
              onChanged: _onTimeSlotSelected,
              elevation: 16,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  fontSize: 18),
              hint: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      Translate.of(context).translate('selectTimeSlot'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 4.0,
          children: selectedSlots
              .map(
                (slot) => Chip(
                  label: Text(slot.title),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      selectedSlots.remove(slot);
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ScheduleModel>> _buildDropdownItems() {
    return allSlots.map((ScheduleModel timeSlot) {
      return DropdownMenuItem<ScheduleModel>(
        value: timeSlot,
        child: Text(timeSlot.title),
      );
    }).toList();
  }

  void _onTimeSlotSelected(ScheduleModel? slot) {
    if (slot != null) {
      setState(() {
        if (selectedSlots.length < adults) {
          selectedSlots.add(slot);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                Translate.of(context)
                    .translate('noAvailableSlots')
                    .replaceFirst("{0}", "$adults")
                    .replaceFirst("{1}", "$adults"),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  Widget _buildContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: adults,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USER ${index + 1}:',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_first_name'),
                  errorText: _errorFirstName[index],
                  controller: _textFistNameController[index],
                  focusNode: _focusFistName[index],
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorFirstName[index] = UtilValidator.validate(
                        _textFistNameController[index].text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusFistName[index],
                      _focusLastName[index],
                    );
                  },
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_last_name'),
                  errorText: _errorLastName[index],
                  controller: _textLastNameController[index],
                  focusNode: _focusLastName[index],
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorLastName[index] = UtilValidator.validate(
                        _textLastNameController[index].text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusLastName[index],
                      _focusPhone[index],
                    );
                  },
                ),
                Visibility(
                  visible: index < 1,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: index < 1,
                  child: AppTextInput(
                    hintText: Translate.of(context).translate('input_phone'),
                    errorText: _errorPhone[index],
                    controller: _textPhoneController[index],
                    focusNode: _focusPhone[index],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onChanged: (text) {
                      setState(() {
                        _errorPhone[index] = UtilValidator.validate(
                          _textPhoneController[index].text,
                          type: ValidateType.phone,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusPhone[index],
                        _focusEmail[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_email'),
                  errorText: _errorEmail[index],
                  controller: _textEmailController[index],
                  focusNode: _focusEmail[index],
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorEmail[index] = UtilValidator.validate(
                        _textEmailController[index].text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusEmail[index],
                      _focusAddress[index],
                    );
                  },
                ),
                Visibility(
                  visible: index < 1,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: index < 1,
                  child: AppTextInput(
                    hintText: Translate.of(context).translate('input_address'),
                    errorText: _errorAddress[index],
                    controller: _textAddressController[index],
                    focusNode: _focusAddress[index],
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      setState(() {
                        _errorAddress[index] = UtilValidator.validate(
                          _textAddressController[index].text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusAddress[index],
                        _focusMessage[index],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: index < 1,
                  child: const SizedBox(height: 16),
                ),
                Visibility(
                  visible: index < 1,
                  child: AppTextInput(
                    maxLines: 6,
                    hintText: Translate.of(context).translate('input_content'),
                    controller: _textMessageController[index],
                    focusNode: _focusMessage[index],
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _selectedService?.name ?? '',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        for (int i = 0; i < adults; i++)
          Text(
            'Kunde ${i + 1}:\n'
            'Name: ${_textFistNameController[i].text} ${_textLastNameController[i].text} '
            '${_textEmailController[i].text.isNotEmpty ? '\nEmail: ${_textEmailController[i].text}' : ''}  '
            '${_textAddressController[i].text != '' ? '\nAddress: ${_textAddressController[i].text}' : ''} '
            '${_textPhoneController[i].text != '' ? '\nTelefon: ${_textPhoneController[i].text}' : ''}'
            '${_textMessageController[i].text != '' ? '\nDescription: ${_textMessageController[i].text}' : ''} \n',
            style: const TextStyle(
                fontWeight: FontWeight.bold), // Apply bold style
          ),
        Text(
          'Buchungsdatum: $selectedDate',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        for (final slots in selectedSlots)
          Text(
            'Buchungsslots: ${slots.title},',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  void _onDatePicker() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(now.year, now.month),
      context: context,
      lastDate: DateTime(now.year + 5),
    );
    if (result != null) {
      setState(() {
        String formattedDate = DateFormat('dd.MM.yyyy').format(result);
        selectedDate = formattedDate;
        _updateSlots();
      });
    }
  }

  void _onPersonPicker(int? init, Function(int) callback) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppNumberPicker(
          value: init,
        );
      },
    );
    if (result != null) {
      callback(result);
    }
  }

  void _updateSlots() {
    if (_selectedService != null && selectedDate.isNotEmpty) {
      context.read<BookingCubit>().selectedService = _selectedService;
      context.read<BookingCubit>().selectedDate = selectedDate;
      context
          .read<BookingCubit>()
          .onLoadBooking(widget.cityId, widget.listingId);
    }
  }

  Future<void> _onSubmit() async {
    for (var slot in selectedSlots) {
      bool success = await context.read<BookingCubit>().onSubmit(
          startTime: slot.stringFromTimeOfDay(slot.startTime),
          endTime: slot.stringFromTimeOfDay(slot.endTime),
          guestDetails: guestModel!,
          date: selectedDate,
          cityId: widget.cityId,
          friends: friends,
          listingId: widget.listingId,
          appointmentId: widget.appointment.id!);
      if (success) {
        setState(() {
          submittedSuccessful = true;
        });
      } else {
        submittedSuccessful = false;
      }
    }
  }
}
