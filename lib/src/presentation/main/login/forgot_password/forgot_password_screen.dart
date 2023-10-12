import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final textUserNameController = TextEditingController();

  String? _errorUsername;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textUserNameController.dispose();
    super.dispose();
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          Translate.of(context).translate("forgot_password_success"),
        ),
      ),
    );
  }

  ///Fetch API
  void _forgotPassword() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorUsername = UtilValidator.validate(
        textUserNameController.text,
        type: ValidateType.normal,
      );
    });
    if (_errorUsername == null) {
      final result = await AppBloc.forgotPasswordCubit.onForgotPassword(
        textUserNameController.text,
      );
      if (result) {
        _showSuccessSnackBar();
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('forgot_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('account'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_id',
                  ),
                  errorText: _errorUsername,
                  onSubmitted: (text) {
                    _forgotPassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorUsername = UtilValidator.validate(
                        textUserNameController.text,
                        type: ValidateType.normal,
                      );
                    });
                  },
                  controller: textUserNameController,
                  keyboardType: TextInputType.name,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: AppButton(
                    Translate.of(context).translate('reset_password'),
                    mainAxisSize: MainAxisSize.max,
                    onPressed: _forgotPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
