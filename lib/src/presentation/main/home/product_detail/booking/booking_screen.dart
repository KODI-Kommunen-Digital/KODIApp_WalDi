import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class BookingScreen extends StatelessWidget {
  final String listingTitle;

  const BookingScreen({
    super.key,
    required this.listingTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {},
      builder: (context, state) => state.maybeWhen(
        loading: () => const BookingDetailsLoading(),
        loaded: (availableSlots, services) => BookingDetailsLoaded(
          listingTitle: listingTitle,
          availableSlots: availableSlots,
          services: services,
        ),
        orElse: () => ErrorWidget('Failed to load Accounts.'),
      ),
    );
  }
}

class BookingDetailsLoading extends StatelessWidget {
  const BookingDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BookingDetailsLoaded extends StatefulWidget {
  final String listingTitle;
  final Map<String, int> availableSlots;
  final List<String> services;

  const BookingDetailsLoaded({
    super.key,
    required this.listingTitle,
    required this.availableSlots,
    required this.services,
  });

  @override
  State<BookingDetailsLoaded> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingDetailsLoaded> {
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
  String? _selectedService = '';
  final List<String> _selectedTimeSlots = [];

  final Map<String, int> _availableSlots = {};
  final List<String> services = [];

  @override
  void initState() {
    _selectedService = widget.services.first;
    _availableSlots.addAll(widget.availableSlots);
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
        title: Text(widget.listingTitle),
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
        return const AppointmentSuccess();
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
                  onPressed: () {
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
          const SnackBar(
            content: Text('Please choose Date'),
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
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.miscellaneous_services, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedService,
                    hint: const Row(
                      children: [
                        Text('Select Service'),
                      ],
                    ),
                    items: services.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          category,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedService = value;
                      });
                    },
                    elevation: 16,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.arrow_drop_down, color: Colors.white),
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
                _selectedTimeSlots.clear();
                _availableSlots.clear();
                _availableSlots.addAll(widget.availableSlots);
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
            child: DropdownButton<String>(
              value: null,
              items: _buildDropdownItems(),
              onChanged: _onTimeSlotSelected,
              elevation: 16,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text('Select Time Slot'),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 4.0,
          children: _selectedTimeSlots
              .map(
                (timeSlot) => Chip(
                  label: Text(timeSlot),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      _selectedTimeSlots.remove(timeSlot);
                      _availableSlots[timeSlot] =
                          (_availableSlots[timeSlot] ?? 0) + 1;
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return _availableSlots.keys.map((String timeSlot) {
      return DropdownMenuItem<String>(
        value: timeSlot,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(timeSlot),
            _availableSlots[timeSlot] != null
                ? Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Available No. of Slots: ${_availableSlots[timeSlot]!.toString()}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );
    }).toList();
  }

  void _onTimeSlotSelected(String? value) {
    if (value != null) {
      setState(() {
        if (_selectedTimeSlots.length < adults) {
          if (_availableSlots[value] != null && _availableSlots[value]! > 0) {
            _selectedTimeSlots.add(value);
            _availableSlots[value] = (_availableSlots[value] ?? 0) - 1;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text("There are no more slots left for this time period"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "You can only select up to $adults time slots for $adults people"),
              duration: const Duration(seconds: 2), // Optional duration
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
          _selectedService!,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        for (int i = 0; i < adults; i++)
          Text(
            'Client ${i + 1}:\n'
            'Name: ${_textFistNameController[i].text} ${_textLastNameController[i].text} '
            '${_textEmailController[i].text.isNotEmpty ? '\nEmail: ${_textEmailController[i].text}' : ''}  '
            '${_textAddressController[i].text != '' ? '\nAddress: ${_textAddressController[i].text}' : ''} '
            '${_textPhoneController[i].text != '' ? '\nTelephone: ${_textPhoneController[i].text}' : ''}'
            '${_textMessageController[i].text != '' ? '\nDescription: ${_textMessageController[i].text}' : ''} \n',
            style: const TextStyle(
                fontWeight: FontWeight.bold), // Apply bold style
          ),
        Text(
          'Appointment Date: $selectedDate',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        for (final slots in _selectedTimeSlots)
          Text(
            'Appointment Slots $slots,',
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
}
