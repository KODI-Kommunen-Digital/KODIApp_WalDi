// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/main/home/forum/add_group_screen/cubit/add_group_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:loggy/loggy.dart';

class AddGroupScreen extends StatefulWidget {
  final ProductModel? item;
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
  final _textTagsController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textZipCodeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final _textFaxController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textWebsiteController = TextEditingController();
  final _textStatusController = TextEditingController();
  final _textPriceController = TextEditingController();
  final _textPriceMinController = TextEditingController();
  final _textPriceMaxController = TextEditingController();
  final _textPlaceController = TextEditingController();

  final _focusTitle = FocusNode();
  final _focusContent = FocusNode();
  final _focusAddress = FocusNode();
  final _focusZipCode = FocusNode();
  final _focusPhone = FocusNode();
  final _focusFax = FocusNode();
  final _focusEmail = FocusNode();
  final _focusWebsite = FocusNode();
  final _focusPrice = FocusNode();

  bool _processing = false;
  String? _errorTitle;
  String? _errorContent;
  String? _errorPhone;
  String? _errorEmail;
  String? _errorWebsite;
  String? _errorStatus;
  String? _errorSDate;
  String? _errorEDate;
  String? _errorPrivacy;
  String? selectedCity;
  int? cityId;
  int? villageId;
  int? categoryId;
  int? subCategoryId;
  List listCity = [];
  List listVillage = [];
  List listCategory = [];
  List listSubCategory = [];

  String? _featureImage;
  String? _startDate;
  String? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? selectedVillage;
  String? selectedCategory;
  String? selectedPrivacy;
  String? selectedSubCategory;
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
    currentCity = await context.read<AddGroupCubit>().getCurrentCityId();
    _onProcess();
  }

  @override
  void dispose() {
    _textTitleController.dispose();
    _textContentController.dispose();
    _textTagsController.dispose();
    _textAddressController.dispose();
    _textZipCodeController.dispose();
    _textPhoneController.dispose();
    _textFaxController.dispose();
    _textEmailController.dispose();
    _textWebsiteController.dispose();
    _textStatusController.dispose();
    _textPriceController.dispose();
    _textPriceMinController.dispose();
    _textPriceMaxController.dispose();
    _focusTitle.dispose();
    _focusContent.dispose();
    _focusAddress.dispose();
    _focusZipCode.dispose();
    _focusPhone.dispose();
    _focusFax.dispose();
    _focusEmail.dispose();
    _focusWebsite.dispose();
    _focusPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String textTitle = Translate.of(context).translate('add_new_group');
    String textAction = Translate.of(context).translate('add');
    if (widget.item != null) {
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

    setState(() {
      listCity = loadCitiesResponse!;
      selectedCategory = selectedSubCategory;
      if (selectedCategory == "News" || selectedCategory == null) {
        selectSubCategory(selectedCategory);
      }
      _processing = true;
    });

    Map<String, dynamic> params = {};
    if (widget.item != null) {
      params['post_id'] = widget.item!.id;
    }

    if (widget.item != null) {
      if (!mounted) return;
      _featureImage = widget.item?.image;
      _textTitleController.text = widget.item!.title;
      _textContentController.text = widget.item!.description;
      _textAddressController.text = widget.item!.address;
      _textZipCodeController.text = widget.item?.zipCode ?? '';
      _textPhoneController.text = widget.item?.phone ?? '';
      _textEmailController.text = widget.item?.email ?? '';
      _textWebsiteController.text = widget.item?.website ?? '';
      final city = listCity
          .firstWhere((element) => element['id'] == widget.item?.cityId);
      selectedCity = city['name'];
      if (selectedCategory == "News" || selectedCategory == null) {
        final subCategoryResponse = await context
            .read<AddGroupCubit>()
            .loadSubCategory(selectedCategory);
        listSubCategory = subCategoryResponse!.data;
      }
    } else {
      if (currentCity != null && currentCity != 0) {
        for (var cityData in loadCitiesResponse!) {
          if (cityData['id'] == currentCity) {
            selectedCity = cityData['name'];
            break;
          }
        }
      } else {
        selectedCity = loadCitiesResponse?.first['name'];
      }
    }
    setState(() {
      _processing = false;
    });
  }

  void _onSubmit() async {
    final success = _validData();
    if (success) {
      if (widget.item != null) {
        if (isImageChanged) {
          await context
              .read<AddGroupCubit>()
              .deleteImage(widget.item?.cityId, widget.item?.id);
          await context
              .read<AddGroupCubit>()
              .deletePdf(widget.item?.cityId, widget.item?.id);
        }
        final result = await context.read<AddGroupCubit>().onEdit(
            cityId: widget.item?.cityId,
            categoryId: widget.item!.categoryId,
            listingId: widget.item?.id,
            title: _textTitleController.text,
            place: _textPlaceController.text,
            description: _textContentController.text,
            address: _textAddressController.text,
            email: _textEmailController.text,
            phone: _textPhoneController.text,
            website: _textWebsiteController.text,
            price: _textPriceController.text,
            startDate: _startDate,
            endDate: _endDate,
            startTime: _startTime,
            endTime: _endTime,
            isImageChanged: isImageChanged);
        if (result) {
          _onSuccess();
        }
      } else {
        final result = await context.read<AddGroupCubit>().onSubmit(
            cityId: cityId ?? 1,
            title: _textTitleController.text,
            city: selectedCity,
            description: _textContentController.text,
            type: selectedPrivacy);
        if (result) {
          _onSuccess();
          if (!mounted) return;
        }
      }
    }
  }

  void _onSuccess() {
    Navigator.pop(context);
    if (widget.isNewGroup) {
      Navigator.pushNamed(context, Routes.submitSuccess);
    }
  }

  bool _validData() {
    _errorTitle =
        UtilValidator.validate(_textTitleController.text, allowEmpty: false);

    _errorContent =
        UtilValidator.validate(_textContentController.text, allowEmpty: false);

    logError('selectedCategory', selectedCategory);
    if (selectedCategory == "Events") {
      if (_startDate == null || _startDate == "" || _startTime == null) {
        _errorSDate = "value_not_date_empty";
      } else {
        _errorSDate = null;
      }

      if (_endDate == null || _endDate == "" || _endTime == null) {
        _errorEDate = "value_not_date_empty";
      } else {
        _errorEDate = null;
      }
    }

    List<String?> errors = [
      _errorTitle,
      _errorContent,
      _errorPrivacy,
      _errorPhone,
      _errorEmail,
      _errorWebsite,
      _errorStatus,
      _errorSDate,
      _errorEDate,
    ];

    if (_errorTitle != null ||
        _errorContent != null ||
        _errorPrivacy != null ||
        _errorPhone != null ||
        _errorEmail != null ||
        _errorWebsite != null ||
        _errorStatus != null ||
        _errorSDate != null ||
        _errorEDate != null) {
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
                    onChanged: (value) {
                      setState(() {
                        selectedPrivacy = value as String;
                      });
                    },
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
                          onChanged: (value) async {
                            setState(() {
                              selectedCity = value as String?;
                              for (var element in listCity) {
                                if (element["name"] == value) {
                                  cityId = element["id"];
                                }
                              }
                            });
                          },
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

  Future<void> selectSubCategory(String? selectedCategory) async {
    context.read<AddGroupCubit>().clearSubCategory();
    selectedSubCategory = null;
    // clearStartEndDate();
    final subCategoryResponse =
        await context.read<AddGroupCubit>().loadSubCategory(selectedCategory);
    if (!mounted) return;
    context.read<AddGroupCubit>().setCategoryId(selectedCategory);
    setState(() {
      selectedSubCategory = subCategoryResponse?.data.first['name'];
    });
  }
}
