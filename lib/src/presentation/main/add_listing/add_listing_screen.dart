import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_picker_item.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/datetime.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

import 'cubit/add_listing_cubit.dart';

class AddListingScreen extends StatefulWidget {
  final ProductModel? item;

  const AddListingScreen({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
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
  String? _errorZipCode;
  String? _errorPhone;
  String? _errorEmail;
  String? _errorWebsite;
  String? _errorStatus;
  String? _errorSDate;
  String? _errorEDate;
  String? _errorCategory;
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
  String? selectedVillage;
  String? selectedCategory;
  String? selectedSubCategory;
  bool isImageChanged = false;

  int? currentCity;

  @override
  void initState() {
    super.initState();
    _onProcess();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentCity = await context.read<AddListingCubit>().getCurrentCityId();
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
    String textTitle = Translate.of(context).translate('add_new_listing');
    String textAction = Translate.of(context).translate('add');
    if (widget.item != null) {
      textTitle = Translate.of(context).translate('update_listing');
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
    final loadCitiesResponse =
        await context.read<AddListingCubit>().loadCities();
    if (!mounted) return;
    final loadCategoryResponse =
        await context.read<AddListingCubit>().loadCategory();
    if (!loadCategoryResponse?.data.isEmpty) {
      var jsonCategory = loadCategoryResponse!.data;
      final selectedCategory = jsonCategory.first['name'];
      if (!mounted) return;
      final subCategoryResponse = await context
          .read<AddListingCubit>()
          .loadSubCategory(selectedCategory);
      listSubCategory = subCategoryResponse!.data;
    }
    setState(() {
      listCategory = loadCategoryResponse?.data;
      if (currentCity != null && currentCity != 0) {
        for (var cityData in loadCitiesResponse!.data) {
          if (cityData['id'] == currentCity) {
            selectedCity = cityData['name'];
            break; // Exit the loop once the desired city is found
          }
        }
      } else {
        selectedCity = loadCitiesResponse!.data.first['name'];
      }
      selectedSubCategory = loadCategoryResponse?.data.first['name'];
      listCity = loadCitiesResponse.data;
      selectedCategory = selectedSubCategory;
      selectSubCategory(selectedSubCategory);
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
    }
    setState(() {
      _processing = false;
    });
  }

  void _onShowStartDatePicker() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      initialDate: now,
      firstDate: DateTime(now.year),
      context: context,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.dateView;
      });
    }
  }

  void _onShowEndDatePicker() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      initialDate: now,
      firstDate: DateTime(now.year),
      context: context,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked.dateView;
      });
    }
  }

  void _onSubmit() async {
    final success = _validData();
    if (success) {
      if (widget.item != null) {
        final result = await context.read<AddListingCubit>().onEdit(
            cityId: widget.item?.cityId,
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
            isImageChanged: isImageChanged);
        if (result) {
          _onSuccess();
        }
      } else {
        final result = await context.read<AddListingCubit>().onSubmit(
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
            );
        if (result) {
          _onSuccess();
          if (!mounted) return;
          context.read<AddListingCubit>().clearImagePath();
        }
      }
    }
  }

  void _onSuccess() {
    Navigator.pop(context);
  }

  bool _validData() {
    _errorZipCode = UtilValidator.validate(
      _textZipCodeController.text,
      type: ValidateType.number,
      allowEmpty: true,
    );

    _errorPhone = UtilValidator.validate(
      _textPhoneController.text,
      type: ValidateType.phone,
      allowEmpty: true,
    );

    _errorEmail = UtilValidator.validate(
      _textEmailController.text,
      type: ValidateType.email,
      allowEmpty: true,
    );

    _errorWebsite = UtilValidator.validate(
      _textWebsiteController.text,
      allowEmpty: true,
    );

    _errorStatus = UtilValidator.validate(
      _textStatusController.text,
      allowEmpty: true,
    );

    _errorWebsite = UtilValidator.validate(_textWebsiteController.text,
        allowEmpty: true, type: ValidateType.website);

    _errorTitle =
        UtilValidator.validate(_textTitleController.text, allowEmpty: false);

    _errorContent =
        UtilValidator.validate(_textContentController.text, allowEmpty: false);

    if (selectedCategory == "Events") {
      if (_startDate == null || _startDate == "") {
        _errorSDate = "value_not_date_empty";
      } else {
        _errorSDate = null;
      }

      if (_endDate == null || _endDate == "") {
        _errorEDate = "value_not_date_empty";
      } else {
        _errorEDate = null;
      }
    }

    List<String?> errors = [
      _errorTitle,
      _errorContent,
      _errorCategory,
      _errorPhone,
      _errorEmail,
      _errorWebsite,
      _errorStatus,
      _errorSDate,
      _errorEDate,
    ];

    if (_errorTitle != null ||
        _errorContent != null ||
        _errorCategory != null ||
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

  String? _getCategoryTranslation(int id) {
    Map<int, String> categories = {
      1: "category_news",
      2: "category_traffic",
      3: "category_events",
      4: "category_clubs",
      5: "category_products",
      6: "category_offer_search",
      7: "category_citizen_info",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food"
    };
    return categories[id];
  }

  String? _getSubCategoryTranslation(int id) {
    Map<int, String> subCategories = {
      1: "subcategory_newsflash",
      3: "subcategory_politics",
      4: "subcategory_economy",
      5: "subcategory_sports",
      7: "subcategory_local",
      8: "subcategory_club_news",
      9: "subcategory_road",
      10: "subcategory_official_notification",
    };
    return subCategories[id];
  }

  Widget _buildContent() {
    if (_processing) {
      return const Center(
        child: CircularProgressIndicator(
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
                profile: false,
                onChange: (result) {
                  isImageChanged = true;
                },
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              Translate.of(context).translate('title'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_title'),
              errorText: _errorTitle,
              controller: _textTitleController,
              focusNode: _focusTitle,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorTitle = UtilValidator.validate(
                    _textTitleController.text,
                  );
                });
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
            Text(
              Translate.of(context).translate('content'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
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
                setState(() {
                  _errorContent = UtilValidator.validate(
                    _textContentController.text,
                  );
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              Translate.of(context).translate('category'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: listCategory.isEmpty
                        ? const LinearProgressIndicator()
                        : DropdownButton(
                            isExpanded: true,
                            menuMaxHeight: 200,
                            hint: Text(Translate.of(context)
                                .translate('input_category')),
                            value: selectedCategory ??
                                Translate.of(context).translate(
                                    _getCategoryTranslation(
                                        listCategory.first['id'])),
                            items: listCategory.map((category) {
                              return DropdownMenuItem(
                                  value: category['name'],
                                  child: Text(Translate.of(context).translate(
                                      _getCategoryTranslation(
                                          category['id']))));
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                selectedCategory = value as String?;
                              });
                              selectSubCategory(selectedCategory);
                            },
                          )),
              ],
            ),
            if (selectedCategory == "News" || selectedCategory == null)
              const SizedBox(height: 8),
            if (selectedCategory == "News" || selectedCategory == null)
              Text(
                Translate.of(context).translate('subCategory'),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (selectedCategory == "News")
                  Expanded(
                      child: listSubCategory.isEmpty
                          ? const LinearProgressIndicator()
                          : DropdownButton(
                              isExpanded: true,
                              menuMaxHeight: 200,
                              hint: Text(Translate.of(context)
                                  .translate('input_subcategory')),
                              value: selectedSubCategory,
                              items: listSubCategory.map((subcategory) {
                                return DropdownMenuItem(
                                    value: subcategory['name'],
                                    child: Text(Translate.of(context).translate(
                                        _getSubCategoryTranslation(
                                            subcategory['id']))));
                              }).toList(),
                              onChanged: (value) {
                                context
                                    .read<AddListingCubit>()
                                    .getSubCategoryId(value);
                                setState(() {
                                  selectedSubCategory = value as String?;
                                });
                              },
                            )),
              ],
            ),
            if (selectedCategory == "News" || selectedCategory == null)
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            Text(
              Translate.of(context).translate('city'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
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
                            });
                            selectedVillage = null;
                            context.read<AddListingCubit>().clearVillage();
                            if (value != null) {
                              final loadVillageResponse = await context
                                  .read<AddListingCubit>()
                                  .loadVillages(value);
                              selectedVillage =
                                  loadVillageResponse.data.first['name'];
                              villageId = loadVillageResponse.data.first['id'];
                              setState(() {
                                listVillage = loadVillageResponse.data;
                              });
                            }
                          },
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            // Text(
            //   Translate.of(context).translate('village'),
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleMedium!
            //       .copyWith(fontWeight: FontWeight.bold),
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: DropdownButton(
            //       isExpanded: true,
            //       menuMaxHeight: 200,
            //       hint: Text(Translate.of(context).translate('input_village')),
            //       value: selectedVillage,
            //       items: listVillage.map((village) {
            //         return DropdownMenuItem(
            //             value: village['name'], child: Text(village['name']));
            //       }).toList(),
            //       onChanged: (value) {
            //         setState(() {
            //           selectedVillage = value as String?;
            //         });
            //       },
            //     )),
            //   ],
            // ),
            // const SizedBox(height: 16),
            AppTextInput(
              hintText: Translate.of(context).translate('input_address'),
              // errorText: _errorAddress,
              controller: _textAddressController,
              focusNode: _focusAddress,
              textInputAction: TextInputAction.next,
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusAddress,
                  _focusZipCode,
                );
              },
              leading: Icon(
                Icons.home_outlined,
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_zipcode'),
              errorText: _errorZipCode,
              controller: _textZipCodeController,
              focusNode: _focusZipCode,
              maxLength: 5,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  _errorZipCode = UtilValidator.validate(
                    _textZipCodeController.text,
                    type: ValidateType.number,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusZipCode,
                  _focusPhone,
                );
              },
              leading: Icon(
                Icons.wallet_travel_outlined,
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_phone'),
              errorText: _errorPhone,
              controller: _textPhoneController,
              focusNode: _focusPhone,
              maxLength: 15,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorPhone = UtilValidator.validate(
                    _textPhoneController.text,
                    type: ValidateType.phone,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusPhone,
                  _focusEmail,
                );
              },
              leading: Icon(
                Icons.phone_outlined,
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_email'),
              errorText: _errorEmail,
              controller: _textEmailController,
              focusNode: _focusEmail,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorEmail = UtilValidator.validate(
                    _textEmailController.text,
                    type: ValidateType.email,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusEmail,
                  _focusWebsite,
                );
              },
              leading: Icon(
                Icons.email_outlined,
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: Translate.of(context).translate('input_website'),
              errorText: _errorWebsite,
              controller: _textWebsiteController,
              focusNode: _focusWebsite,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  _errorWebsite = UtilValidator.validate(
                      _textWebsiteController.text,
                      allowEmpty: true,
                      type: ValidateType.website);
                });
              },
              leading: Icon(
                Icons.language_outlined,
                color: Theme.of(context).hintColor,
              ),
            ),
            if (selectedCategory == "Events") const SizedBox(height: 16),
            Text(
              selectedCategory == "Events"
                  ? Translate.of(context).translate(
                      'start_date',
                    )
                  : '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (selectedCategory == "Events") const SizedBox(height: 8),
            if (selectedCategory == "Events")
              AppPickerItem(
                leading: Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).hintColor,
                ),
                value: _startDate,
                title: Translate.of(context).translate(
                  'choose_date',
                ),
                onPressed: _onShowStartDatePicker,
              ),
            if (selectedCategory == "Events") const SizedBox(height: 16),
            Text(
              selectedCategory == "Events"
                  ? Translate.of(context).translate(
                      'end_date',
                    )
                  : '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (selectedCategory == "Events") const SizedBox(height: 8),
            if (selectedCategory == "Events")
              AppPickerItem(
                leading: Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).hintColor,
                ),
                value: _endDate,
                title: Translate.of(context).translate(
                  'choose_date',
                ),
                onPressed: _onShowEndDatePicker,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> selectSubCategory(String? selectedCategory) async {
    context.read<AddListingCubit>().clearSubCategory();
    selectedSubCategory = null;
    // clearStartEndDate();
    final subCategoryResponse =
        await context.read<AddListingCubit>().loadSubCategory(selectedCategory);
    if (!mounted) return;
    context.read<AddListingCubit>().getCategoryId(selectedCategory);
    setState(() {
      selectedSubCategory = subCategoryResponse?.data.first['name'];
    });
  }
}
