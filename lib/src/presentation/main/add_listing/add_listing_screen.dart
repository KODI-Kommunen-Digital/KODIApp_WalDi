// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_picker_item.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/datetime.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

import 'cubit/add_listing_cubit.dart';

class AddListingScreen extends StatefulWidget {
  final ProductModel? item;
  final bool isNewList;

  const AddListingScreen({
    Key? key,
    this.item,
    required this.isNewList,
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

  // String? _errorEmail;
  String? _errorWebsite;
  String? _errorStatus;
  String? _errorSDate;
  String? _errorCategory;
  String? _errorCity;
  List<String> selectedCities = [];
  List<int> cityIds = [];
  int? statusId;
  int? villageId;
  int? categoryId;
  int? subCategoryId;
  List listCity = [];
  List listVillage = [];
  List listCategory = [];
  List listSubCategory = [];

  String? _featurePdf;
  String? _expiryDate;
  bool _isExpiryDateEnabled = true;
  TimeOfDay? _expiryTime;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? selectedVillage;
  String? selectedCategory;
  String? selectedSubCategory;
  bool isImageChanged = false;
  bool isLoading = false;
  List<File>? selectedImages = [];
  List<File> downloadedImages = [];

  int? currentCity;
  late List<dynamic> jsonCategory;

  @override
  void initState() {
    super.initState();
    _onProcess();
    if (widget.item != null) {
      if (widget.item?.expiryDate != null && widget.item?.expiryDate != "") {
        _isExpiryDateEnabled = true;
      } else if (widget.item?.expiryDate == null &&
          widget.item?.expiryDate == "") {
        _isExpiryDateEnabled = false;
      }
      context
          .read<AddListingCubit>()
          .setCategoryId(selectedCategory?.toLowerCase());
    } else if (widget.item == null) {
      _setDefaultExpiryDate();
      _isExpiryDateEnabled = true;
    }
  }

  void _setDefaultExpiryDate() {
    if (widget.item?.expiryDate == null || widget.item?.expiryDate == "") {
      DateTime now = DateTime.now();
      DateTime twoWeeksFromNow = now.add(const Duration(days: 14));
      setState(() {
        _expiryDate = DateFormat('yyyy-MM-dd').format(twoWeeksFromNow);
        _expiryTime = const TimeOfDay(hour: 0, minute: 0);
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentCity = await context.read<AddListingCubit>().getCurrentCityId();
    _onProcess();
  }

  String clearedText(String text) {
    var document = parse(text);
    return document.body!.text;
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
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<AddListingCubit>().clearAssets();
              Navigator.pop(context);
            },
          ),
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
          child: Stack(
            children: [
              _buildContent(),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Overlay background
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
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
      jsonCategory = loadCategoryResponse!.data;
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
            selectedCities.add(cityData['name']);
            break; // Exit the loop once the desired city is found
          }
        }
      } else {
        //selectedCities.add(loadCitiesResponse!.data.first['name']);
      }
      selectedSubCategory = loadCategoryResponse?.data.first['name'];
      listCity = loadCitiesResponse?.data;
      selectedCategory = selectedSubCategory;
      _processing = true;
    });

    if (selectedCategory?.toLowerCase() == "news" || selectedCategory == null) {
      await selectSubCategory(selectedCategory?.toLowerCase());
    }

    Map<String, dynamic> params = {};
    if (widget.item != null) {
      params['post_id'] = widget.item!.id;
    }

    if (widget.item != null) {
      if (!mounted) return;
      _featurePdf = widget.item?.pdf;
      statusId = widget.item?.statusId;
      _textTitleController.text = widget.item!.title;
      _textContentController.text = clearedText(widget.item!.description);
      _textAddressController.text = widget.item!.address;
      _textZipCodeController.text = widget.item?.zipCode ?? '';
      _textPhoneController.text = widget.item?.phone ?? '';
      _textEmailController.text = widget.item?.email ?? '';
      _textWebsiteController.text = widget.item?.website ?? '';
      _createdAt = widget.item?.createDate ?? '';
      selectedCategory = jsonCategory.firstWhere(
          (element) => element["id"] == widget.item!.categoryId)["name"];
      selectedSubCategory = listSubCategory.firstWhere(
          (element) => element["id"] == widget.item!.subcategoryId)["name"];

      final city = listCity
          .firstWhere((element) => element['id'] == widget.item?.cityId);
      selectedCities.add(city['name']);
      if (selectedCategory?.toLowerCase() == "news" ||
          selectedCategory == null) {
        final subCategoryResponse = await context
            .read<AddListingCubit>()
            .loadSubCategory(selectedCategory?.toLowerCase());
        listSubCategory = subCategoryResponse!.data;
      }
      if (widget.item?.startDate != '') {
        List<String> startDateTime = widget.item!.startDate.split(' ');
        List<String> endDateTime = widget.item!.endDate.split(' ');

        if (startDateTime.length == 2) {
          String dateString = startDateTime[0];
          DateTime parsedDateTime = DateFormat('dd.MM.yyyy').parse(dateString);
          _startDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
          List<String> startTimeParts = startDateTime[1].split(':');
          int startHour = int.parse(startTimeParts[0]);
          int startMinute = int.parse(startTimeParts[1]);
          _startTime = TimeOfDay(hour: startHour, minute: startMinute);
          if (endDateTime.length == 2) {
            String dateString = endDateTime[0];
            DateTime parsedDateTime =
                DateFormat('dd.MM.yyyy').parse(dateString);
            _endDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
            List<String> endTimeParts = endDateTime[1].split(':');
            int endHour = int.parse(endTimeParts[0]);
            int endMinute = int.parse(endTimeParts[1]);
            _endTime = TimeOfDay(hour: endHour, minute: endMinute);
          } else {
            String dateString = startDateTime[0];
            DateTime parsedDateTime =
                DateFormat('dd.MM.yyyy').parse(dateString);
            _endDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
            // List<String> endTimeParts = endDateTime[0].split(':');
            // int endHour = int.parse(endTimeParts[0]);
            // int endMinute = int.parse(endTimeParts[1]);
            _endTime = null;
          }
        }
      }
      if (widget.item?.expiryDate != '') {
        List<String> expiryDateTime = widget.item!.expiryDate.split(' ');
        String dateString = expiryDateTime[0];
        DateTime parsedDateTime = DateFormat('dd.MM.yyyy').parse(dateString);
        _expiryDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
        List<String> startTimeParts = expiryDateTime[1].split(':');
        int startHour = int.parse(startTimeParts[0]);
        int startMinute = int.parse(startTimeParts[1]);
        _expiryTime = TimeOfDay(hour: startHour, minute: startMinute);
      }
      if (widget.item?.pdf == '') {
        List<File> images = await downloadImages(widget.item!.imageLists!);
        setState(() {
          selectedImages?.clear();
          downloadedImages.clear();
          if (images.isNotEmpty) {
            if (!images[0].path.contains('Defaultimage')) {
              selectedImages?.addAll(images);
            }
          }
          downloadedImages.addAll(images);
        });
      }
    } else {
      if (currentCity != null && currentCity != 0) {
        for (var cityData in loadCitiesResponse?.data) {
          if (cityData['id'] == currentCity) {
            selectedCities.add(cityData['name']);
            break; // Exit the loop once the desired city is found
          }
        }
      } else {
        //selectedCities.add(loadCitiesResponse?.data.first['name']);
      }
      if (!loadCategoryResponse?.data.isEmpty) {
        if (!mounted) return;
        if (selectedCategory?.toLowerCase() == "news" ||
            selectedCategory == null) {
          final subCategoryResponse = await context
              .read<AddListingCubit>()
              .loadSubCategory(Translate.of(context)
                  .translate(_getCategoryTranslation(
                      loadCategoryResponse!.data.first['id']))
                  .toLowerCase());
          setState(() {
            listSubCategory = subCategoryResponse!.data;
          });
        }
      }
    }
    setState(() {
      _processing = false;
    });
  }

  void _onShowExpiryDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _expiryDate != null
        ? DateFormat('yyyy-MM-dd').parse(_expiryDate!)
        : now.add(const Duration(days: 14));
    final DateTime firstDate = DateTime(now.year - 5);
    final DateTime lastDate = DateTime(now.year + 5);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && mounted) {
      setState(() {
        _expiryDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<List<File>> downloadImages(List<ImageListModel> imageUrls) async {
    List<File> downloadedImages = [];
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    imageUrls.sort((a, b) => a.imageOrder!.compareTo(b.imageOrder as num));
    for (final imageUrl in imageUrls) {
      try {
        var response = await http
            .get(Uri.parse("${Application.picturesURL}${imageUrl.logo}"));
        if (response.statusCode == 200) {
          String savePath =
              '${appDocumentsDirectory.path}/${imageUrl.logo?.replaceAll(RegExp(r'[^\w\s\.]'), '_')}';

          File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);
          downloadedImages.add(file);
          // return file;
        } else {
          throw Exception('Failed to download image');
        }
      } catch (e) {
        logError('Error downloading image: $e');
      }
    }
    return downloadedImages;
  }

  void _onShowStartDatePicker(String? startDate) async {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');
    if (startDate != null) {
      final parsedDate = dateFormat.parse(startDate);
      final picked = await showDatePicker(
        initialDate: parsedDate,
        firstDate: DateTime(now.year),
        context: context,
        lastDate: DateTime(now.year + 2, now.month, now.day),
      );
      if (picked != null) {
        setState(() {
          _startDate = picked.dateView;
        });
      }
    } else {
      final picked = await showDatePicker(
        initialDate: now,
        firstDate: DateTime(now.year),
        context: context,
        lastDate: DateTime(now.year + 2, now.month, now.day),
      );

      if (picked != null) {
        setState(() {
          _startDate = picked.dateView;
        });
      }
    }
  }

  void _onShowEndDatePicker(String? endDate) async {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');
    if (endDate != null) {
      final parsedDate = dateFormat.parse(endDate);
      final picked = await showDatePicker(
        initialDate: parsedDate,
        firstDate: DateTime(now.year),
        context: context,
        lastDate: DateTime(now.year + 2, now.month, now.day),
      );
      if (picked != null) {
        setState(() {
          _endDate = picked.dateView;
        });
      }
    } else {
      final picked = await showDatePicker(
        initialDate: now,
        firstDate: DateTime(now.year),
        context: context,
        lastDate: DateTime(now.year + 2, now.month, now.day),
      );

      if (picked != null) {
        setState(() {
          _endDate = picked.dateView;
        });
      }
    }
  }

  Future<void> _onShowExpiryTimePicker() async {
    final TimeOfDay initialTime =
        _expiryTime ?? const TimeOfDay(hour: 0, minute: 0);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && mounted) {
      setState(() {
        _expiryTime = pickedTime;
      });
    }
  }

  Future<void> _onShowStartTimePicker(TimeOfDay? startTime) async {
    if (startTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: startTime,
      );

      if (pickedTime != null) {
        setState(() {
          _startTime = pickedTime;
        });
      }
    } else {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _startTime = pickedTime;
        });
      }
    }
  }

  Future<void> _onShowEndTimePicker(TimeOfDay? endTime) async {
    if (endTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: endTime,
      );

      if (pickedTime != null) {
        setState(() {
          _endTime = pickedTime;
        });
      }
    } else {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _endTime = pickedTime;
        });
      }
    }
  }

  void _onSubmit() async {
    final success = _validData();
    if (success) {
      if (widget.item != null) {
        if (isImageChanged) {
          await context
              .read<AddListingCubit>()
              .deleteImage(widget.item?.cityId, widget.item?.id);
          await context
              .read<AddListingCubit>()
              .deletePdf(widget.item?.cityId, widget.item?.id);
        }
        String? submitExpiryDate = _isExpiryDateEnabled ? _expiryDate : null;
        TimeOfDay? submitExpiryTime = _isExpiryDateEnabled ? _expiryTime : null;

        setState(() {
          isLoading = true;
        });
        final result = await context.read<AddListingCubit>().onEdit(
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
              expiryDate: submitExpiryDate,
              expiryTime: submitExpiryTime,
              startDate: _startDate,
              endDate: _endDate,
              createdAt: _createdAt,
              startTime: _startTime,
              endTime: _endTime,
              timeless: _isExpiryDateEnabled ? 0 : 1,
              isImageChanged: isImageChanged,
              statusId: statusId,
              imagesList: selectedImages,
            );
        if (result) {
          await AppBloc.homeCubit.onLoad(false);
          setState(() {
            isLoading = false;
          });
          _onSuccess();
          if (!mounted) return;
          context.read<AddListingCubit>().clearAssets();
        }
      } else {
        String? submitExpiryDate = _isExpiryDateEnabled ? _expiryDate : null;
        TimeOfDay? submitExpiryTime = _isExpiryDateEnabled ? _expiryTime : null;

        setState(() {
          isLoading = true;
        });
        final result = await context.read<AddListingCubit>().onSubmit(
              title: _textTitleController.text,
              city: selectedCities,
              place: _textPlaceController.text,
              description: _textContentController.text,
              address: _textAddressController.text,
              email: _textEmailController.text,
              phone: _textPhoneController.text,
              website: _textWebsiteController.text,
              expiryDate: submitExpiryDate,
              startDate: _startDate,
              endDate: _endDate,
              createdAt: _createdAt ?? '',
              expiryTime: submitExpiryTime,
              timeless: _isExpiryDateEnabled ? 0 : 1,
              startTime: _startTime,
              endTime: _endTime,
              imagesList: selectedImages,
              isImageChanged: isImageChanged,
            );
        if (result) {
          await AppBloc.homeCubit.onLoad(false);
          setState(() {
            isLoading = false;
          });
          _onSuccess();
          if (!mounted) return;
          context.read<AddListingCubit>().clearImagePath();
          if (!mounted) return;
          context.read<AddListingCubit>().clearAssets();
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  void _onSuccess() {
    Navigator.pop(context);
    // context.read<HomeCubit>().onLoad(false);
    if (widget.isNewList) {
      Navigator.pushNamed(context, Routes.submitSuccess);
    }
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

    // _errorEmail = UtilValidator.validate(
    //   _textEmailController.text,
    //   type: ValidateType.email,
    //   allowEmpty: true,
    // );

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

    if (_textContentController.text.length >= 65535) {
      _errorContent = "value_desc_limit_exceeded";
    } else {
      _errorContent = UtilValidator.validate(_textContentController.text,
          allowEmpty: false);
    }

    if (selectedCategory?.toLowerCase() == "events") {
      if (_startDate == null || _startDate == "" || _startTime == null) {
        _errorSDate = "value_not_date_empty";
      } else {
        _errorSDate = null;
      }
    }

    if (selectedCities.isEmpty) {
      _errorCity = "city_require";
    } else {
      _errorCity = null;
    }

    List<String?> errors = [
      _errorTitle,
      _errorContent,
      _errorCategory,
      _errorPhone,
      // _errorEmail,
      _errorWebsite,
      _errorStatus,
      _errorSDate,
      _errorCity
    ];

    if (_errorTitle != null ||
        _errorContent != null ||
        _errorCategory != null ||
        _errorPhone != null ||
        // _errorEmail != null ||
        _errorWebsite != null ||
        _errorStatus != null ||
        _errorSDate != null ||
        _errorCity != null) {
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
      4: "category_clubs_add",
      5: "category_products",
      6: "category_offer_search",
      7: "category_citizen_info",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies_add",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food",
      14: "category_rathaus",
      15: "category_newsletter",
      16: "category_official_notification"
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
      11: "subcategory_timeless_news"
    };
    return subCategories[id];
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
                title:
                    Translate.of(context).translate('upload_feature_image_pdf'),
                image: _featurePdf == ''
                    ? selectedImages!.isNotEmpty
                        ? selectedImages![0].path
                        : null
                    // downloadedImages[0].path
                    : _featurePdf,
                profile: false,
                onDelete: () {
                  if (selectedImages!.isNotEmpty) {
                    setState(() {
                      // downloadedImages.removeAt(0);
                      selectedImages?.removeAt(0);
                      isImageChanged = true;
                    });
                  }
                },
                onChange: (result) {
                  if (result.isNotEmpty) {
                    setState(() {
                      selectedImages?.clear();
                      if (downloadedImages.isNotEmpty &&
                          !downloadedImages[0].path.contains('Defaultimage')) {
                        selectedImages?.addAll(downloadedImages);
                      }
                      selectedImages?.addAll(result);
                    });
                  } else {
                    setState(() {
                      selectedImages?.clear();
                    });
                  }
                  isImageChanged = true;
                },
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: selectedImages!.length > 1,
              child: _buildImageList(),
            ),
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
                text: Translate.of(context).translate('content'),
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
                text: Translate.of(context).translate('category'),
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
                    child: listCategory.isEmpty
                        ? const LinearProgressIndicator()
                        : DropdownButton(
                            isExpanded: true,
                            menuMaxHeight: 200,
                            hint: Text(Translate.of(context)
                                .translate('input_category')),
                            value: selectedCategory,
                            items: listCategory.map((category) {
                              return DropdownMenuItem(
                                value: category['name'],
                                child: Text(
                                  Translate.of(context).translate(
                                    _getCategoryTranslation(category['id']),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(
                                () {
                                  selectedCategory = value as String?;
                                  context.read<AddListingCubit>().setCategoryId(
                                      selectedCategory?.toLowerCase());
                                },
                              );
                              if (selectedCategory?.toLowerCase() == "news" ||
                                  selectedCategory == null) {
                                selectSubCategory(
                                    selectedCategory?.toLowerCase());
                                _setDefaultExpiryDate();
                              }
                            })),
              ],
            ),
            if (selectedCategory?.toLowerCase() == "news" ||
                selectedCategory == null)
              const SizedBox(height: 8),
            if (selectedCategory?.toLowerCase() == "news" ||
                selectedCategory == null)
              Text.rich(
                TextSpan(
                  text: Translate.of(context).translate('subCategory'),
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
                if (selectedCategory?.toLowerCase() == "news")
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
                                  context
                                      .read<AddListingCubit>()
                                      .setSubCategoryId(
                                          selectedSubCategory?.toLowerCase());
                                });
                              },
                            )),
              ],
            ),
            if (selectedCategory?.toLowerCase() == "news" ||
                selectedCategory == null)
              const SizedBox(height: 8),
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
                      : (widget.item != null)
                          ? DropdownButton(
                              isExpanded: true,
                              menuMaxHeight: 200,
                              hint: Text(Translate.of(context)
                                  .translate('input_city')),
                              value: selectedCities.first,
                              items: listCity.map((city) {
                                return DropdownMenuItem(
                                    value: city['name'],
                                    child: Text(city['name']));
                              }).toList(),
                              onChanged: null)
                          : MultiSelectDropDown(
                              //isExpanded: true,
                              searchBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              borderColor: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color ??
                                  Colors.white,
                              optionsBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              optionTextStyle: TextStyle(
                                  color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ??
                                      Colors.white),
                              selectedOptionBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              dropdownHeight: 200,
                              hint:
                                  Translate.of(context).translate('input_city'),
                              options: listCity.map((city) {
                                return ValueItem(
                                    value: city['name'], label: city['name']);
                              }).toList(),
                              onOptionSelected: widget.item == null
                                  ? (List<ValueItem> selectedOptions) async {
                                      List<String> options = [];
                                      for (var option in selectedOptions) {
                                        options.add(option.value!);
                                      }
                                      setState(() {
                                        selectedCities = options;
                                        for (var element in listCity) {
                                          if (element["name"] == options.last) {
                                            cityIds.add(element["id"]);
                                          }
                                        }
                                      });
                                      selectedVillage = null;
                                      context
                                          .read<AddListingCubit>()
                                          .clearVillage();
                                      final loadVillageResponse = await context
                                          .read<AddListingCubit>()
                                          .loadVillages(options.last);
                                      selectedVillage = loadVillageResponse
                                          .data.first['name'];
                                      villageId =
                                          loadVillageResponse.data.first['id'];
                                      setState(() {
                                        listVillage = loadVillageResponse.data;
                                      });
                                    }
                                  : null),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (selectedCategory?.toLowerCase() == "news")
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isExpiryDateEnabled,
                      onChanged: (bool? value) {
                        setState(() {
                          _isExpiryDateEnabled = value!;
                          if (_isExpiryDateEnabled &&
                              (_expiryDate == null || _expiryTime == null)) {
                            DateTime now = DateTime.now();
                            DateTime twoWeeksFromNow =
                                now.add(const Duration(days: 14));
                            _expiryDate ??= DateFormat('yyyy-MM-dd')
                                .format(twoWeeksFromNow);
                            _expiryTime ??= const TimeOfDay(hour: 0, minute: 0);
                          }
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpiryDateEnabled = !_isExpiryDateEnabled;
                          });
                        },
                        child: Text(
                          Translate.of(context).translate('enable_expiry_date'),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 6),
            Visibility(
              visible: (selectedCategory?.toLowerCase() == "news") &&
                  (_isExpiryDateEnabled || widget.item?.timeless == 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: Translate.of(context).translate('expiry_date'),
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
                  AppPickerItem(
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    value: _expiryDate,
                    title: Translate.of(context).translate(
                      'choose_date',
                    ),
                    onPressed: () async {
                      _onShowExpiryDatePicker();
                    },
                  ),
                  const SizedBox(height: 8),
                  AppPickerItem(
                      leading: Icon(
                        Icons.access_time,
                        color: Theme.of(context).hintColor,
                      ),
                      value: _expiryTime?.format(context),
                      title: Translate.of(context).translate(
                        'choose_exptime',
                      ),
                      onPressed: () async {
                        _onShowExpiryTimePicker();
                      }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
              // errorText: _errorEmail,
              controller: _textEmailController,
              focusNode: _focusEmail,
              textInputAction: TextInputAction.next,
              // onChanged: (text) {
              //   setState(() {
              //     _errorEmail = UtilValidator.validate(
              //       _textEmailController.text,
              //       type: ValidateType.email,
              //       allowEmpty: true,
              //     );
              //   });
              // },
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
            Visibility(
              visible: selectedCategory?.toLowerCase() == "events",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: Translate.of(context).translate('start_date'),
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
                  AppPickerItem(
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    value: _startDate,
                    title: Translate.of(context).translate(
                      'choose_date',
                    ),
                    onPressed: () async {
                      _onShowStartDatePicker(_startDate);
                    },
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: Translate.of(context).translate('start_time'),
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
                  AppPickerItem(
                      leading: Icon(
                        Icons.access_time,
                        color: Theme.of(context).hintColor,
                      ),
                      value: _startTime?.format(context),
                      title: Translate.of(context).translate(
                        'choose_stime',
                      ),
                      onPressed: () async {
                        _onShowStartTimePicker(_startTime);
                      }),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: Translate.of(context).translate('end_date'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppPickerItem(
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    value: _endDate,
                    title: Translate.of(context).translate(
                      'choose_date',
                    ),
                    onPressed: () async {
                      _onShowEndDatePicker(_endDate);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: Translate.of(context).translate('end_time'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppPickerItem(
                    leading: Icon(
                      Icons.access_time,
                      color: Theme.of(context).hintColor,
                    ),
                    value: _endTime?.format(context),
                    title: Translate.of(context).translate(
                      'choose_etime',
                    ),
                    onPressed: () async {
                      _onShowEndTimePicker(_endTime);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageList() {
    return Visibility(
      visible: selectedImages!.length > 1,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: selectedImages!.length > 1
              ? selectedImages!.length - 1
              : 0, // Ensure itemCount is non-negative
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      // alignment: Alignment.center,
                      child: Image.file(selectedImages![index + 1],
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[900],
                      ),
                      onPressed: () {
                        setState(() {
                          isImageChanged = true;
                          if (selectedImages!.isNotEmpty &&
                              selectedImages!.length > 2) {
                            // if (selectedImages?[index + 1] is Asset) {
                            //
                            // }
                            context
                                .read<AddListingCubit>()
                                .removeAssetsByIndex(index);
                          }
                          if (downloadedImages.isNotEmpty) {
                            if (downloadedImages.length > index + 1) {
                              downloadedImages
                                  .remove(downloadedImages[index + 1]);
                              // selectedImages?.remove(selectedImages?[index + 1]);
                            }
                          }
                          selectedImages?.remove(selectedImages?[index + 1]);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> selectSubCategory(String? selectedCategory) async {
    context.read<AddListingCubit>().clearSubCategory();
    selectedSubCategory = null;
    // clearStartEndDate();
    final subCategoryResponse = await context
        .read<AddListingCubit>()
        .loadSubCategory(selectedCategory!.toLowerCase());
    if (!mounted) return;
    context
        .read<AddListingCubit>()
        .setCategoryId(selectedCategory.toLowerCase());
    context
        .read<AddListingCubit>()
        .setSubCategoryId(subCategoryResponse?.data.last['name']);
    setState(() {
      listSubCategory = subCategoryResponse!.data;
      selectedSubCategory = subCategoryResponse.data.last['name'];
    });
  }
}
