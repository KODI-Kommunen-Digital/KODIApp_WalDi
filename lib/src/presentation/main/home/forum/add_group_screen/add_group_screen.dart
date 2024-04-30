// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/presentation/main/home/forum/add_group_screen/cubit/add_group_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class AddGroupScreen extends StatefulWidget {
  final ForumGroupModel? item;
  final bool isNewGroup;

  const AddGroupScreen({
    Key? key,
    this.item,
    required this.isNewGroup,
  }) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
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
  List listCity = [];

  String? _featureImage;
  String? selectedPrivacy;
  bool isImageChanged = false;

  late int? currentCity;

  @override
  void initState() {
    super.initState();
    _onProcess();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentCity = await context.read<AddGroupCubit>().getCurrentCityId();
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
    String textTitle = Translate.of(context).translate('add_new_group');
    String textAction = Translate.of(context).translate('add');
    if (!widget.isNewGroup) {
      textTitle = Translate.of(context).translate('update_group');
      textAction = Translate.of(context).translate('update');
    }

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
    final loadCitiesResponse = await context.read<AddGroupCubit>().loadCities();
    if (!mounted) return;
    final prefs = await Preferences.openBox();
    final cityIdPref = prefs.getKeyValue(Preferences.cityId, 0);

    if (widget.item != null) {
      final selectedCityDetails = loadCitiesResponse!.firstWhere(
        (element) =>
            element['id'] ==
            (widget.item?.cityId == 0 ? cityIdPref : widget.item?.cityId),
      );
      if (!mounted) return;
      _textTitleController.text = widget.item!.forumName ?? '';
      _textContentController.text = widget.item!.description ?? '';
      _featureImage = widget.item?.image;
      cityId = widget.item?.cityId ?? 1;
      selectedPrivacy = widget.item!.isPrivate == 1 ? 'private' : 'public';
      selectedCity = selectedCityDetails['name'];
    } else {
      selectedCity = loadCitiesResponse?.first['name'];
      selectedPrivacy = 'public';
    }
    setState(() {
      listCity = loadCitiesResponse!;
      _processing = true;
    });

    Map<String, dynamic> params = {};
    if (widget.item != null) {
      params['post_id'] = widget.item!.id;
    }

    if (currentCity != null && currentCity != 0) {
      for (var cityData in loadCitiesResponse!) {
        if (cityData['id'] == currentCity) {
          selectedCity = cityData['name'];
          break;
        }
      }
    } else {
      // selectedCity = loadCitiesResponse?.first['name'];
    }

    setState(() {
      _processing = false;
    });
  }

  void _onSubmit() async {
    final success = _validData();
    if (success) {
      if (widget.item == null) {
        final result = await context.read<AddGroupCubit>().onSubmit(
            cityId: cityId ?? 1,
            title: _textTitleController.text,
            city: selectedCity,
            description: _textContentController.text,
            type: selectedPrivacy);
        if (result) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      } else {
        final result = await context.read<AddGroupCubit>().onEditForum(
            _textTitleController.text,
            _textContentController.text,
            selectedCity,
            selectedPrivacy,
            isImageChanged,
            widget.item!.id,
            widget.item!.createdAt);
        if (result) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      }
    }
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
                  setState(() {
                    isImageChanged = true;
                  });
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
            Text.rich(
              TextSpan(
                text: Translate.of(context).translate('select_privacy'),
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
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    menuMaxHeight: 200,
                    hint:
                        Text(Translate.of(context).translate('select_privacy')),
                    value: selectedPrivacy,
                    items: [
                      DropdownMenuItem(
                        value: 'private',
                        child: Text(Translate.of(context).translate('private')),
                      ),
                      DropdownMenuItem(
                        value: 'public',
                        child: Text(Translate.of(context).translate('public')),
                      ),
                    ],
                    onChanged: widget.item == null
                        ? (value) {
                            setState(() {
                              selectedPrivacy = value as String;
                            });
                          }
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: Translate.of(context).translate('city'),
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
            Row(
              children: [
                Expanded(
                  child: listCity.isEmpty
                      ? const LinearProgressIndicator()
                      : DropdownButton(
                          isExpanded: true,
                          menuMaxHeight: 200,
                          hint: Text(
                              Translate.of(context).translate('input_city')),
                          value: selectedCity ?? listCity.first['name'],
                          items: listCity.map((city) {
                            return DropdownMenuItem(
                                value: city['name'], child: Text(city['name']));
                          }).toList(),
                          onChanged: widget.item == null
                              ? (value) async {
                                  setState(() {
                                    selectedCity = value as String?;
                                    for (var element in listCity) {
                                      if (element["name"] == value) {
                                        cityId = element["id"];
                                      }
                                    }
                                  });
                                }
                              : null,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
