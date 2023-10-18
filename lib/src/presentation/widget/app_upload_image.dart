import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/multiple_gesture_detector.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';

enum UploadImageType { circle, square }

class AppUploadImage extends StatefulWidget {
  final String? title;
  final String? image;
  final Function(String) onChange;
  final UploadImageType type;
  final bool profile;

  const AppUploadImage({
    Key? key,
    this.title,
    this.image,
    required this.onChange,
    this.type = UploadImageType.square,
    required this.profile,
  }) : super(key: key);

  @override
  State<AppUploadImage> createState() => _AppUploadImageState();
}

class _AppUploadImageState extends State<AppUploadImage> {
  final _picker = ImagePicker();
  File? _file;
  double? _percent;
  bool isImageUploaded = false;
  bool showAction = false;
  String title = '';
  bool isPermanentlyDenied = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _uploadImage() async {
    Platform.isAndroid
        ? await Permission.storage.request()
        : await Permission.photos.request();

    String androidVersion = await _getAndroidVersion();
    var statusImage = await Permission.photos.status;
    if (int.parse(androidVersion) > 11) {
      statusImage = await Permission.photos.status;
    } else {
      statusImage = await Permission.storage.status;
    }

    if (showAction) {
      setState(() {
        showAction = false;
      });
      return;
    }
    try {
      if (statusImage.isGranted || statusImage.isLimited) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile == null) return;
        if (!mounted) return;
        setState(() {
          isImageUploaded = false;
          _file = File(pickedFile.path);
        });
        final profile = widget.profile;
        if (!profile) {
          await ListRepository.uploadImage(_file!, profile);
        } else {
          final response = await ListRepository.uploadImage(_file!, profile);
          if (response!.data['status'] == 'success') {
            setState(() {
              isImageUploaded = true;
            });
            final item = response.data['data']?['image'];
            widget.onChange(item);
          } else {}
        }
      } else if (statusImage.isDenied) {
        await openAppSettings();
        if (statusImage.isGranted || statusImage.isLimited) {
          final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedFile == null) return;
          if (!mounted) return;
          setState(() {
            isImageUploaded = false;
            _file = File(pickedFile.path);
          });
          final profile = widget.profile;
          if (!profile) {
          } else {
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
      } else if (statusImage.isPermanentlyDenied) {
        await openAppSettings();
      }
    } catch (e) {
      logError('Image Upload Permission Error', e);
    }
  }

  Future<void> showChooseFileTypeDialog() async {
    PermissionStatus status;
    if (await Permission.storage.isGranted) {
      status = PermissionStatus.granted;
    } else {
      String androidVersion = await _getAndroidVersion();
      if (int.parse(androidVersion) < 11) {
        status = await Permission.storage.status;
      } else {
        status = await Permission.photos.status;
      }
      status = await Permission.storage.request();
      status = await Permission.photos.request();
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
                    _file = File('');
                    widget.onChange('pdf');
                    setState(() {
                      _file = File(result.files.single.path!);
                      isImageUploaded = false;
                    });
                    final profile = widget.profile;
                    if (!profile) {
                      await ListRepository.uploadPdf(_file!);
                    }
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
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile == null) return;
                      if (!mounted) return;
                      setState(() {
                        isImageUploaded = false;
                        _file = File(pickedFile.path);
                      });
                      final profile = widget.profile;
                      if (!profile) {
                        await ListRepository.uploadImage(_file!, profile);
                        widget.onChange('image');
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
                    );
                    if (result != null) {
                      _file = File('');
                      setState(() {
                        _file = File(result.files.single.path!);
                        isImageUploaded = false;
                      });
                      final profile = widget.profile;
                      if (!profile) {
                        await ListRepository.uploadImage(_file!, profile);
                        widget.onChange('image');
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

  Future<String> _getAndroidVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.release;
    } else {
      return "0";
    }
  }

  Widget? _buildContent() {
    String uniqueKey = UniqueKey().toString();
    if (widget.image != null && _file == null) {
      if (widget.image!.contains(".pdf")) {
        return SizedBox(
            width: double.infinity,
            height: 400,
            child: RawGestureDetector(
              gestures: {
                AllowMultipleGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<
                        AllowMultipleGestureRecognizer>(
                  () => AllowMultipleGestureRecognizer(), //constructor
                  (AllowMultipleGestureRecognizer instance) {
                    //initializer
                    instance.onTap = () => showChooseFileTypeDialog();
                  },
                )
              },
              child: const PDF().cachedFromUrl(
                "${Application.picturesURL}${widget.image!}?cacheKey=$uniqueKey",
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
              if (_percent != null && _percent! < 100) {
                return Container(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }
            }
          }
        }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    BorderType borderType = BorderType.RRect;
    Widget circle = Container();

    if (widget.image != null && !widget.image!.contains(".pdf")) {
      decorationImage = DecorationImage(
        image: NetworkImage("${Application.picturesURL}${widget.image!}"),
        fit: BoxFit.cover,
      );
    }

    if (_file != null && !_file!.path.contains(".pdf")) {
      decorationImage = DecorationImage(
        image: FileImage(
          _file!,
        ),
        fit: BoxFit.cover,
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
      onTap: widget.profile ? _uploadImage : showChooseFileTypeDialog,
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
          Positioned.fill(child: circle),
        ],
      ),
    );
  }
}
