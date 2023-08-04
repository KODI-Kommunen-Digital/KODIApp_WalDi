import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _textUNameController = TextEditingController();
  final _textFNameController = TextEditingController();
  final _textLNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textWebsiteController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _focusUName = FocusNode();
  final _focusFName = FocusNode();
  final _focusLName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusWebsite = FocusNode();
  final _focusInfo = FocusNode();
  final picker = ImagePicker();

  String? _image;
  String? _errorUName;
  String? _errorFName;
  String? _errorLName;
  String? _errorEmail;
  String? _errorWebsite;
  String? _errorInfo;

  @override
  void initState() {
    super.initState();
    final user = AppBloc.editProfileCubit.getUserDetails();
    _textUNameController.text = user.username;
    _textFNameController.text = user.firstname;
    _textLNameController.text = user.lastname;
    _textEmailController.text = user.email;
    _textWebsiteController.text = user.url;
    _textInfoController.text = user.description;
    _image = user.image;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateProfile() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorUName = UtilValidator.validate(_textUNameController.text);
      _errorFName = UtilValidator.validate(_textFNameController.text);
      _errorLName = UtilValidator.validate(_textLNameController.text);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _errorWebsite = UtilValidator.validate(_textWebsiteController.text);
      _errorInfo = UtilValidator.validate(_textInfoController.text);
    });
    if (_errorUName == null &&
        _errorFName == null &&
        _errorLName == null &&
        _errorEmail == null &&
        _errorWebsite == null &&
        _errorInfo == null) {
      final result = await AppBloc.editProfileCubit.onUpdateUser(
        username: _textUNameController.text,
        firstname: _textFNameController.text,
        lastname: _textLNameController.text,
        email: _textEmailController.text,
        url: _textWebsiteController.text,
        description: _textInfoController.text,
        image: _image,
      );

      if (result) {
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        logError('Update User Result Error', result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('edit_profile')),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: AppUploadImage(
                          title: 'profile',
                          type: UploadImageType.circle,
                          image: _image,
                          profile: true,
                          onChange: (result) {
                            setState(() {
                              _image = result;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                    errorText: _errorUName,
                    focusNode: _focusUName,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusUName,
                        _focusFName,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorUName = UtilValidator.validate(
                          _textUNameController.text,
                        );
                      });
                    },
                    controller: _textUNameController,
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
                    errorText: _errorFName,
                    focusNode: _focusFName,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusFName,
                        _focusLName,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorFName = UtilValidator.validate(
                          _textFNameController.text,
                        );
                      });
                    },
                    controller: _textFNameController,
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
                    errorText: _errorLName,
                    focusNode: _focusLName,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusLName,
                        _focusEmail,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorLName = UtilValidator.validate(
                          _textLNameController.text,
                        );
                      });
                    },
                    controller: _textLNameController,
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
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusEmail,
                        _focusWebsite,
                      );
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
                  Text(
                    Translate.of(context).translate('website'),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_website',
                    ),
                    errorText: _errorWebsite,
                    focusNode: _focusWebsite,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                        context,
                        _focusWebsite,
                        _focusInfo,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorWebsite = UtilValidator.validate(
                          _textWebsiteController.text,
                        );
                      });
                    },
                    controller: _textWebsiteController,
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
                      _updateProfile();
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
                Translate.of(context).translate('confirm'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _updateProfile,
              ),
            )
          ],
        ),
      ),
    );
  }
}
