// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/add_new_post/cubit/add_post_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class AddPostScreen extends StatefulWidget {
  final ForumGroupModel? item;
  final bool isNewPost;

  const AddPostScreen({
    Key? key,
    this.item,
    required this.isNewPost,
  }) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final regInt = RegExp('[^0-9]');
  final _textTitleController = TextEditingController();
  final _textContentController = TextEditingController();

  final _focusTitle = FocusNode();
  final _focusContent = FocusNode();

  bool _processing = false;
  String? _errorTitle;
  String? _errorContent;

  String? selectedCity;
  int? cityId;
  int? villageId;
  List listCity = [];

  String? _featureImage;

  String? selectedPrivacy;
  bool isImageChanged = false;

  late int? currentCity;

  @override
  void initState() {
    super.initState();
    _onProcess();
    selectedPrivacy = 'public';
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentCity = await context.read<AddPostCubit>().getCurrentCityId();
    _onProcess();
  }

  @override
  void dispose() {
    _textTitleController.dispose();
    _textContentController.dispose();
    _focusTitle.dispose();
    _focusContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String textTitle = Translate.of(context).translate('add_new_post');
    String textAction = Translate.of(context).translate('add');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(textTitle),
          actions: [
            AppButton(
              textAction,
              onPressed: _onSubmit,
              type: ButtonType.text,
            )
          ],
        ),
        body: SafeArea(
          child: _buildContent(),
        ),
      ),
    );
  }

  void _onProcess() async {
    if (!mounted) return;

    setState(() {});

    Map<String, dynamic> params = {};
    if (widget.item != null) {
      params['post_id'] = widget.item!.id;
    }

    setState(() {
      _processing = false;
    });
  }

  void _onSubmit() async {
    final success = _validData();
    if (success) {
      final result = await context.read<AddPostCubit>().onSubmit(
          cityId: currentCity ?? 1,
          title: _textTitleController.text,
          description: _textContentController.text,
          forumId: widget.item!.id);
      if (result) {
        _onSuccess();
        if (!mounted) return;
      }
    }
  }

  void _onSuccess() {
    Navigator.pop(context);
    // if (widget.isNewPost) {
    //   Navigator.pushNamed(context, Routes.submitSuccess);
    // }
  }

  bool _validData() {
    _errorTitle =
        UtilValidator.validate(_textTitleController.text, allowEmpty: false);

    _errorContent =
        UtilValidator.validate(_textContentController.text, allowEmpty: false);

    List<String?> errors = [
      _errorTitle,
      _errorContent,
    ];

    if (_errorTitle != null || _errorContent != null) {
      String errorMessage = "";
      for (var element in errors) {
        if (element != null &&
            !errorMessage.contains(Translate.of(context).translate(element))) {
          errorMessage =
              "$errorMessage${Translate.of(context).translate(element)}, ";
        }
      }
      errorMessage = errorMessage.substring(0, errorMessage.length - 2);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      setState(() {});
      return false;
    }
    return true;
  }

  Widget _buildContent() {
    if (_processing) {
      return const Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              child: AppUploadImage(
                title: Translate.of(context).translate('upload_feature_image'),
                image: _featureImage,
                profile: true,
                forumGroup: true,
                onChange: (result) {
                  isImageChanged = true;
                },
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: Translate.of(context).translate('title'),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_title'),
              errorText: _errorTitle,
              controller: _textTitleController,
              focusNode: _focusTitle,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                _errorTitle = UtilValidator.validate(
                  _textTitleController.text,
                );
              },
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusTitle,
                  _focusContent,
                );
              },
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: Translate.of(context).translate('input_content'),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              maxLines: 3,
              hintText: Translate.of(context).translate('input_content'),
              errorText: _errorContent,
              controller: _textContentController,
              focusNode: _focusContent,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                _errorContent = UtilValidator.validate(
                  _textContentController.text,
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
