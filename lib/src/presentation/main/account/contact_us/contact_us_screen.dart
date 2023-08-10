import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _textEmailController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _focusInfo = FocusNode();

  String? _errorEmail;
  String? _errorInfo;

  @override
  void initState() {
    super.initState();
    _textEmailController.text = 'info@heidi-app.de';
    _textInfoController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendFeedback() async {
    final user = AppBloc.contactUsCubit.getUserDetails();
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _errorInfo = UtilValidator.validate(_textInfoController.text);
    });
    if (_errorEmail == null && _errorInfo == null) {
      final result = await AppBloc.contactUsCubit
          .onSendFeedback(email: _textInfoController.text, token: user.token);

      if (result) {
        _onSuccess();
        if (!mounted) return;
      } else {
        logError('Update User Result Error', result);
      }
    }
  }

  void _onSuccess() {
    Navigator.pushReplacementNamed(context, Routes.contactUsSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('contact_us')),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Text(
                    Translate.of(context).translate('email'),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'info@heidi-app.de',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('information'),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_information',
                    ),
                    errorText: _errorInfo,
                    focusNode: _focusInfo,
                    maxLines: 5,
                    onSubmitted: (text) {
                      _sendFeedback();
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorInfo = UtilValidator.validate(
                          _textInfoController.text,
                        );
                      });
                    },
                    controller: _textInfoController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('send'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _sendFeedback,
              ),
            )
          ],
        ),
      ),
    );
  }
}
