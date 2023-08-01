import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_picker_item.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
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
  final _focusPlace = FocusNode();
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

  @override
  void initState() {
    super.initState();
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
      selectedCity = loadCitiesResponse!.data.first['name'];
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
      final result = await ListRepository.loadProduct(
          widget.item!.cityId, widget.item!.id);
      if (result != null) {
        _featureImage = result.image;
        _textTitleController.text = result.title;
        _textContentController.text = result.description;
        _textAddressController.text = result.address;
        _textZipCodeController.text = result.zipCode!;
        _textPhoneController.text = result.phone;
        _textEmailController.text = result.email;
        _textWebsiteController.text = result.website;
      }
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

  void _onSuccess() {
    Navigator.pushReplacementNamed(context, Routes.submitSuccess);
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
        if (element != null) {
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
      12: "category_offers"
    };
    return categories[id];
  }

  String? _getSubCategoryTranslation(int id) {
    Map<int, String> subCategories = {
      1: "subcategory_newsflash",
      2: "subcategory_alerts",
      3: "subcategory_politics",
      4: "subcategory_economy",
      5: "subcategory_sports",
      6: "subcategory_day_topic",
      7: "subcategory_local",
      8: "subcategory_club_news",
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
                onChange: (result) {
                  setState(() {
                    _featureImage = result;
                  });
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
                              value: selectedSubCategory ??
                                  Translate.of(context).translate(
                                      _getSubCategoryTranslation(
                                          listSubCategory.first["id"])),
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
              hintText: Translate.of(context).translate('input_place'),
              controller: _textPlaceController,
              focusNode: _focusPlace,
              textInputAction: TextInputAction.next,
              onSubmitted: (text) {
                Utils.fieldFocusChange(
                  context,
                  _focusPlace,
                  _focusAddress,
                );
              },
            ),
            const SizedBox(height: 8),
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
              textInputAction: TextInputAction.next,
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
                  );
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
