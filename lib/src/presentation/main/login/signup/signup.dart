import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _textIDController = TextEditingController();
  final _textFNController = TextEditingController();
  final _textLNController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textCPassController = TextEditingController();

  final _textEmailController = TextEditingController();
  final _focusID = FocusNode();
  final _focusFN = FocusNode();
  final _focusLN = FocusNode();
  final _focusPass = FocusNode();
  final _focusCPass = FocusNode();
  final _focusEmail = FocusNode();

  bool _showPassword = false;
  bool _showCPassword = false;
  String? _errorID;
  String? _errorFN;
  String? _errorLN;
  String? _errorPass;
  String? _errorCPass;
  String? _errorEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textIDController.dispose();
    _textFNController.dispose();
    _textLNController.dispose();
    _textPassController.dispose();
    _textCPassController.dispose();
    _textEmailController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    _focusEmail.dispose();
    super.dispose();
  }

  void _signUp() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text.toLowerCase(), type: ValidateType.userName);
      _errorFN = UtilValidator.validate(_textFNController.text);
      _errorLN = UtilValidator.validate(_textLNController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
      _errorCPass = UtilValidator.validate(_textCPassController.text,
          password: _textPassController.text, type: ValidateType.cpassword);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
    });
    if (_errorID == null &&
        _errorPass == null &&
        _errorEmail == null &&
        _errorCPass == null) {
      final result = await AppBloc.signupCubit.onRegister(
        username: _textIDController.text.toLowerCase(),
        firstname: _textFNController.text,
        lastname: _textLNController.text,
        password: _textPassController.text,
        confirmPassword: _textCPassController.text,
        email: _textEmailController.text,
        role: "3",
      );
      if (result) {
        if (!mounted) return;
        AppBloc.loginCubit.onLogin(
          username: _textIDController.text,
          password: _textPassController.text,
        );
        Navigator.pop(context);
      } else {
        _showErrorSnackBar();
      }
    } else {
      _showErrorSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_up'),
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
                  Translate.of(context).translate('account'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_id'),
                  errorText: _errorID,
                  controller: _textIDController,
                  focusNode: _focusID,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorID = UtilValidator.validate(_textIDController.text.toLowerCase());
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusID, _focusFN);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('fname'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_fname'),
                  errorText: _errorFN,
                  controller: _textFNController,
                  focusNode: _focusFN,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorFN = UtilValidator.validate(_textFNController.text);
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusFN, _focusLN);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('lname'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_lname'),
                  errorText: _errorLN,
                  controller: _textLNController,
                  focusNode: _focusLN,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorLN = UtilValidator.validate(_textLNController.text);
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusLN, _focusPass);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('password'),
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
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusCPass,
                    );
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showPassword,
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('cpassword'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_cpassword',
                  ),
                  errorText: _errorCPass,
                  onChanged: (text) {
                    setState(() {
                      _errorCPass = UtilValidator.validate(
                        _textCPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusCPass,
                      _focusEmail,
                    );
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showCPassword = !_showCPassword;
                      });
                    },
                    child: Icon(_showCPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showCPassword,
                  controller: _textCPassController,
                  focusNode: _focusCPass,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('email'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_email'),
                  errorText: _errorEmail,
                  focusNode: _focusEmail,
                  onSubmitted: (text) {
                    _signUp();
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorEmail = UtilValidator.validate(
                        _textEmailController.text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('sign_up'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _signUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate("register_fail"))));
  }
}
