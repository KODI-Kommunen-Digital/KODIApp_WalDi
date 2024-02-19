import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_cubit.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_state.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('sign_in'),
          ),
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state == const LoginState.loaded()) {
              Navigator.pop(context);
            }
            state.maybeWhen(
              error: (msg) {
                String? messageKey = AppBloc.loginCubit.getTranslationKey(msg);
                String message;
                if (messageKey == null) {
                  message = msg;
                } else {
                  message = Translate.of(context).translate(messageKey);
                }

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) => state.maybeWhen(
            initial: () {
              return const SignInLoaded();
            },
            loading: () => const SignInLoading(),
            loaded: () => Container(),
            error: (msg) => const SignInLoaded(),
            orElse: () {
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class SignInLoading extends StatelessWidget {
  const SignInLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class SignInLoaded extends StatefulWidget {
  const SignInLoaded({Key? key}) : super(key: key);

  @override
  State<SignInLoaded> createState() => _SignInLoadedState();
}

class _SignInLoadedState extends State<SignInLoaded> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();
  bool _showPassword = false;
  String? _errorID;
  String? _errorPass;

  @override
  void dispose() {
    _textIDController.dispose();
    _textPassController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {},
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 12 : 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppTextInput(
                  hintText: Translate.of(context).translate('accountOrEmail'),
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
                  builder: (context, state) {
                    return AppButton(
                      Translate.of(context).translate('sign_in'),
                      mainAxisSize: MainAxisSize.max,
                      onPressed: _login,
                      loading: state == const LoginState.loading(),
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
                    Expanded(
                      child: AppButton(
                        Translate.of(context).translate('sign_up'),
                        onPressed: _signUp,
                        type: ButtonType.text,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Anleitung',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Registrieren in der App',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: 'Schritt 1:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Nutzername und Passwort festlegen,\n\n',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Schritt 2:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Es wird Ihnen eine E-Mail gesendet an die Mail, die Sie eingegeben haben,\n\n',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Schritt 3:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Bitte verifizieren Sie die Mail, indem Sie in Ihr Postfach gehen und den Bestätigungslink drücken,\n\n',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Schritt 4:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' Ihr Account ist verifiziert und Sie können sich mit Ihren Login-Daten einloggen\n\nWir wünschen Ihnen viel Spaß beim Benutzen der App!\n\nDanke!!',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        Translate.of(context).translate('info'),
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  void _signUp() {
    Navigator.pushNamed(context, Routes.signUp);
  }

  void _login() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorID == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textIDController.text.trim(),
        password: _textPassController.text.trim(),
      );
    }
  }
}
