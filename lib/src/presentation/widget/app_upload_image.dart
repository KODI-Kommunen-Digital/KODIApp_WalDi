// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_cubit.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/multiple_gesture_detector.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

enum UploadImageType { circle, square }

class AppUploadImage extends StatefulWidget {
  final String? title;
  final String? image;
  final Function(List<File>) onChange;
  final VoidCallback? onDelete;
  final UploadImageType type;
  final bool profile;

  const AppUploadImage({
    Key? key,
    this.title,
    this.image,
    required this.onChange,
    this.type = UploadImageType.square,
    required this.profile,
    this.onDelete,
  }) : super(key: key);

  @override
  State<AppUploadImage> createState() => _AppUploadImageState();
}

class _AppUploadImageState extends State<AppUploadImage> {
  final _picker = ImagePicker();
  File? _file;
  bool isImageUploaded = false;
  bool showAction = false;
  String title = '';
  bool isPermanentlyDenied = false;
  List<File> images = [];
  List<Asset> resultList = <Asset>[];
  List<File> selectedFiles = [];
  List<Asset> selectedAssets = [];
  String? image;

  @override
  void initState() {
    image = widget.image;
    if (image != null) {
      if (!image!.contains('Defaultimage')) {
        _file = File(image!);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    BorderType borderType = BorderType.RRect;
    Widget circle = Container();
    if (widget.image != null) {
      if (!widget.image!.contains('pdf')) {
        image = widget.image;
        _file = File(image!);
      }
    }
    if (_file != null && !_file!.path.contains(".pdf")) {
      decorationImage = DecorationImage(
        image: FileImage(
          _file!,
        ),
        fit: BoxFit.contain,
      );
    }

    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: decorationImage,
    );

    if (widget.type == UploadImageType.circle) {
      borderType = BorderType.Circle;
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        image: decorationImage,
      );
    }

    return InkWell(
      onTap: widget.profile
          ? _uploadImage
          : selectedAssets.length > 1
              ? selectImages
              : showChooseFileTypeDialog,
      child: Stack(
        children: [
          DottedBorder(
            borderType: borderType,
            radius: const Radius.circular(8),
            color: Theme.of(context).primaryColor,
            child: Container(
              decoration: decoration,
              alignment: Alignment.center,
              child: _buildContent(),
            ),
          ),
          Visibility(
            visible: _file != null &&
                !_file!.path.contains('pdf') &&
                selectedAssets.length != 1,
            child: Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  widget.onDelete!();
                  setState(() {
                    image = null;
                    if (selectedAssets.length > 1) {
                      images.removeAt(0);
                      context.read<AddListingCubit>().removeAssetsByIndex(0);
                    }
                    _file = null;
                    if (images.isNotEmpty) {
                      _file ??= File(images[0].path);
                    }
                  });
                },
              ),
            ),
          ),
          Positioned.fill(child: circle),
        ],
      ),
    );
  }

  Future<void> _uploadImage() async {
    PermissionStatus statusImage;
    if (await Permission.storage.isGranted) {
      statusImage = PermissionStatus.granted;
    } else {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          statusImage = await Permission.storage.status;
          statusImage = await Permission.storage.request();
        } else {
          statusImage = await Permission.photos.status;
          statusImage = await Permission.photos.request();
        }
      } else {
        statusImage = await Permission.photos.status;
        statusImage = await Permission.photos.request();
      }
    }

    if (showAction) {
      setState(() {
        showAction = false;
      });
      return;
    }
    try {
      if (Platform.isIOS) {
        if (await Permission.photos.isGranted ||
            await Permission.photos.isLimited) {
          statusImage = PermissionStatus.granted;
          final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedFile == null) return;
          if (!mounted) return;
          setState(() {
            isImageUploaded = false;
            _file = File(pickedFile.path);
            widget.onChange([]);
          });
          final profile = widget.profile;

          if (!profile) {
            await ListRepository.uploadImage(_file!, profile);
          }
          if (profile) {
            final response = await ListRepository.uploadImage(_file!, profile);
            if (response!.data['status'] == 'success') {
              setState(() {
                isImageUploaded = true;
              });
              final item = response.data['data']?['image'];
              widget.onChange(item);
            } else {
              logError('Image Upload Permission Error', response);
            }
          }
        } else if (await Permission.photos.isDenied) {
          await Permission.photos.request();
        } else if (await Permission.photos.isPermanentlyDenied) {
          statusImage = PermissionStatus.permanentlyDenied;
          await openAppSettings();
        }
      } else {
        statusImage = PermissionStatus.granted;
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile == null) return;
        if (!mounted) return;
        setState(() {
          isImageUploaded = false;
          _file = File(pickedFile.path);
          widget.onChange([]);
        });
        final profile = widget.profile;

        if (!profile) {
          await ListRepository.uploadImage(_file!, profile);
        }
        if (profile) {
          final response = await ListRepository.uploadImage(_file!, profile);
          if (response!.data['status'] == 'success') {
            setState(() {
              isImageUploaded = true;
            });
            final item = response.data['data']?['image'];
            widget.onChange(item);
          } else {
            logError('Image Upload Permission Error', response);
          }
        }
      }
    } catch (e, stackTrace) {
      logError('Image Upload Permission Error', e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  Future<void> showChooseFileTypeDialog() async {
    PermissionStatus status;
    if (await Permission.storage.isGranted) {
      status = PermissionStatus.granted;
    } else {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          status = await Permission.storage.status;
          status = await Permission.storage.request();
        } else {
          status = await Permission.photos.status;
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.photos.status;
        status = await Permission.photos.request();
      }
    }

    if (!mounted) return;
    if (status == PermissionStatus.granted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(Translate.of(context).translate('Choose_File_Type')),
            children: [
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    widget.onChange([]);
                    setState(() {
                      _file = null;
                      images.clear();
                      widget.onChange(images);
                      _file = File(result.files.single.path!);
                      isImageUploaded = false;
                      selectedAssets.clear();
                    });
                    widget.onChange(images);
                    final profile = widget.profile;
                    if (!profile) {
                      await ListRepository.uploadPdf(_file!);
                    }
                    if (!mounted) return;
                    context.read<AddListingCubit>().clearAssets();
                  }
                },
                child: const ListTile(
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text('PDF'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  if (Platform.isIOS) {
                    if (await Permission.photos.isGranted ||
                        await Permission.photos.isLimited) {
                      status = PermissionStatus.granted;

                      setState(() {
                        selectedAssets =
                            context.read<AddListingCubit>().getSelectedAssets();
                      });
                      await selectImages();
                      final profile = widget.profile;
                      if (!profile) {
                        if (_file != null) {
                          await ListRepository.uploadImage(_file!, profile);
                        }
                      } else {
                        final response =
                            await ListRepository.uploadImage(_file!, profile);
                        if (response!.data['status'] == 'success') {
                          setState(() {
                            isImageUploaded = true;
                          });
                        }
                      }
                    } else if (await Permission.photos.isDenied) {
                      await Permission.photos.request();
                    } else if (await Permission.photos.isPermanentlyDenied) {
                      status = PermissionStatus.permanentlyDenied;
                      await openAppSettings();
                    }
                  } else {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowMultiple: true,
                    );
                    if (result != null) {
                      _file = File('');
                      setState(() {
                        _file = File(result.files.first.path!);
                        isImageUploaded = false;
                      });
                      images.clear();
                      for (final selectedImages in result.files) {
                        images.add(File(selectedImages.path!));
                      }
                      widget.onChange(images);
                      final profile = widget.profile;
                      if (!profile) {
                        await ListRepository.uploadImage(_file!, profile);
                        // widget.onChange([]);
                      } else {
                        final response =
                            await ListRepository.uploadImage(_file!, profile);
                        if (response!.data['status'] == 'success') {
                          setState(() {
                            isImageUploaded = true;
                          });
                          final item = response.data['data']?['image'];
                          widget.onChange(item);
                        }
                      }
                    }
                  }
                },
                child: ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(Translate.of(context).translate('images')),
                ),
              ),
            ],
          );
        },
      );
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Widget? _buildContent() {
    String uniqueKey = UniqueKey().toString();
    if (image != null && _file == null) {
      if (image!.contains(".pdf")) {
        return SizedBox(
            width: double.infinity,
            height: 400,
            child: RawGestureDetector(
              gestures: {
                AllowMultipleGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<
                        AllowMultipleGestureRecognizer>(
                  () => AllowMultipleGestureRecognizer(),
                  (AllowMultipleGestureRecognizer instance) {
                    instance.onTap = () => showChooseFileTypeDialog();
                  },
                )
              },
              child: const PDF().cachedFromUrl(
                "${Application.picturesURL}${image!}?cacheKey=$uniqueKey",
                placeholder: (progress) => Center(child: Text('$progress %')),
                errorWidget: (error) => Center(child: Text(error.toString())),
              ),
            ));
      }
    }
    switch (widget.type) {
      case UploadImageType.circle:
        if (_file == null) {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: const Icon(
              Icons.add,
              size: 18,
              color: Colors.white,
            ),
          );
        }

        if (isImageUploaded) {
          return Icon(
            Icons.check_circle,
            size: 18,
            color: Theme.of(context).primaryColor,
          );
        }
        return Container();

      default:
        if (_file == null) {
          Widget title = Container();
          if (widget.title != null) {
            title = Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title,
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          );
        } else {
          if (isImageUploaded) {
            return Container(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.check_circle,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (_file?.path != null) {
            if (_file!.path.contains(".pdf")) {
              return RawGestureDetector(
                gestures: {
                  AllowMultipleGestureRecognizer:
                      GestureRecognizerFactoryWithHandlers<
                          AllowMultipleGestureRecognizer>(
                    () => AllowMultipleGestureRecognizer(), //constructor
                    (AllowMultipleGestureRecognizer instance) {
                      instance.onTap = () => showChooseFileTypeDialog();
                    },
                  )
                },
                child: PDFView(
                  key: UniqueKey(),
                  filePath: _file?.path,
                  fitPolicy: FitPolicy.WIDTH,
                  onPageChanged: (page, total) {
                    // Do something when the page changes (optional)
                  },
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
          }
        }
    }
    return null;
  }

  Future<void> selectImages() async {
    try {
      if (!mounted) return;
      setState(() {
        selectedAssets = context.read<AddListingCubit>().getSelectedAssets();
      });
      if (!mounted) return;

      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 8,
        selectedAssets: selectedAssets,
      );
      if (resultList.isNotEmpty) {
        if (!mounted) return;
        context.read<AddListingCubit>().clearAssets();
        images.clear();
        context.read<AddListingCubit>().saveAssets(resultList);
        setState(() {
          selectedAssets = context.read<AddListingCubit>().getSelectedAssets();
        });
        List<Asset> resultListCopy = List.from(resultList);

        for (Asset asset in resultListCopy) {
          final ByteData byteData = await asset.getByteData();
          final List<int> imageData = byteData.buffer.asUint8List();
          final tempDir = await getTemporaryDirectory();
          final filePath = '${tempDir.path}/${asset.name}';

          final imageFile = File(filePath);
          await imageFile.writeAsBytes(imageData);

          int imageSizeInBytes = imageData.length;
          double imageSizeInMB = imageSizeInBytes / (1024 * 1024);
          logError('ImageSize', imageSizeInMB);

          if (imageSizeInMB > 20) {
            setState(() {
              images.remove(imageFile);
              resultList.remove(asset);
            });
            if (!mounted) return;
            context.read<AddListingCubit>().removeAssets(asset);

            if (!mounted) return;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  Translate.of(context).translate(
                    'image_size_exceed',
                  ),
                ),
                content: Text(
                  Translate.of(context).translate(
                    'select_small_images',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            setState(() {
              _file = null;
              images.add(imageFile);
              if (image == null) {
                _file ??= File(images[0].path);
              } else {
                if (!image!.contains('Defaultimage') &&
                    !image!.contains('pdf')) {
                  _file = File(image!);
                } else {
                  _file ??= File(images[0].path);
                }
              }
              widget.onChange(images);
              context.read<AddListingCubit>().saveAssets(resultList);
              selectedAssets =
                  context.read<AddListingCubit>().getSelectedAssets();
            });
          }
        }
      }
    } on Exception catch (e) {
      logError('Error Selecting Multiple Images', e);
    }
  }
}
