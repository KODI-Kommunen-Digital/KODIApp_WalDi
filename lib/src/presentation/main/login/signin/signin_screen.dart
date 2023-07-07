import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String? _errorID;
  String? _errorPass;

  @override
  void initState() {
    super.initState();
    // _textIDController.text = "heidi";
    // _textPassController.text = "heidi";
  }

  @override
  void dispose() {
    _textIDController.dispose();
    _textPassController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  ///On navigate forgot password
  void _forgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  ///On navigate sign up
  void _signUp() {
    Navigator.pushNamed(context, Routes.signUp);
  }

  ///On login
  void _login() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorID == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textIDController.text,
        password: _textPassController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_in'),
        ),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, login) async {
          if (login == LoginState.success) {
            if(!mounted) {
              return;
            }
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppTextInput(
                    hintText: Translate.of(context).translate('account'),
                    errorText: _errorID,
                    controller: _textIDController,
                    focusNode: _focusID,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      setState(() {
                        _errorID = UtilValidator.validate(
                          _textIDController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(context, _focusID, _focusPass);
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate('password'),
                    errorText: _errorPass,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      setState(() {
                        _errorPass = UtilValidator.validate(
                          _textPassController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      _login();
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
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, login) {
                      return AppButton(
                        Translate.of(context).translate('sign_in'),
                        mainAxisSize: MainAxisSize.max,
                        onPressed: _login,
                        loading: login == LoginState.loading,
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AppButton(
                        Translate.of(context).translate('forgot_password'),
                        onPressed: _forgotPassword,
                        type: ButtonType.text,
                      ),
                      AppButton(
                        Translate.of(context).translate('sign_up'),
                        onPressed: _signUp,
                        type: ButtonType.text,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
