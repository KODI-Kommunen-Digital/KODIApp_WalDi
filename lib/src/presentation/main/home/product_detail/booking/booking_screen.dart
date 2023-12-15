import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_step_item.dart';
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
  final String listingTitle;

  const BookingScreen({
    super.key,
    required this.listingTitle,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
        title: Translate.of(context).translate('completed'),
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
        return _buildCompleted();
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
                  Translate.of(context).translate('back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  Translate.of(context).translate('my_booking'),
                  onPressed: () {},
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
      if (selectedDate == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please choose Date'),
          ),
        );
      } else if (selectedTime == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please choose Time'),
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
              _errorPhone[i] == null &&
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
      // _onOrder(form);
    }
  }

  Widget _buildDetail() {
    return Column(
      children: [
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
        AppPickerItem(
          leading: Icon(
            Icons.more_time,
            color: Theme.of(context).hintColor,
          ),
          value: selectedTime,
          title: Translate.of(context).translate('time'),
          onPressed: _onTimePicker,
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
              });
            });
          },
        ),
        const SizedBox(width: 16),
      ],
    );
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
              children: [
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
                const SizedBox(height: 16),
                AppTextInput(
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
                const SizedBox(height: 16),
                AppTextInput(
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
                const SizedBox(height: 16),
                AppTextInput(
                  maxLines: 6,
                  hintText: Translate.of(context).translate('input_content'),
                  controller: _textMessageController[index],
                  focusNode: _focusMessage[index],
                  textInputAction: TextInputAction.done,
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

  Widget _buildCompleted() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Translate.of(context).translate('booking_success_title'),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            Translate.of(context).translate(
              'booking_success_message',
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
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

  void _onTimePicker() async {
    final result = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (result != null) {
      setState(() {
        selectedTime =
            '${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}';
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
