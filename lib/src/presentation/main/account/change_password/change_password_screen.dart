import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _textPassController = TextEditingController();
  final _textNewPassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusNewPass = FocusNode();

  String? _errorPass;
  String? _errorNewPass;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textPassController.dispose();
    _textNewPassController.dispose();
    _focusPass.dispose();
    _focusNewPass.dispose();
    super.dispose();
  }

  void _changePassword() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorPass = UtilValidator.validate(
        _textPassController.text,
      );
      _errorNewPass = UtilValidator.validate(
        _textNewPassController.text,
      );
    });
    if (_errorPass == null && _errorNewPass == null) {
      final result = await AppBloc.changePasswordCubit.onChangePassword(
        _textPassController.text,
        _textNewPassController.text,
      );
      if (!mounted) return;
      if (result) {
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
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('cur_password'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_password',
                  ),
                  errorText: _errorPass,
                  focusNode: _focusPass,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusNewPass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  controller: _textPassController,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('newPass'),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'newPass',
                  ),
                  errorText: _errorNewPass,
                  focusNode: _focusNewPass,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onSubmitted: (text) {
                    _changePassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorNewPass = UtilValidator.validate(
                        _textNewPassController.text,
                      );
                    });
                  },
                  controller: _textNewPassController,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('confirm'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
