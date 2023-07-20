import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum UploadImageType { circle, square }

class AppUploadImage extends StatefulWidget {
  final String? title;
  final String? image;
  final Function(String) onChange;
  final UploadImageType type;

  const AppUploadImage({
    Key? key,
    this.title,
    this.image,
    required this.onChange,
    this.type = UploadImageType.square,
  }) : super(key: key);

  @override
  State<AppUploadImage> createState() => _AppUploadImageState();
}

class _AppUploadImageState extends State<AppUploadImage> {
  final _picker = ImagePicker();

  File? _file;
  double? _percent;
  bool _completed = false;
  bool showAction = false;
  String title = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _uploadImage() async {
    var statusImage = Platform.isAndroid
        ? await Permission.storage.request()
        : await Permission.photos.request();
    if (showAction) {
      setState(() {
        showAction = false;
      });
      return;
    }
    try {
      if (statusImage.isGranted) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile == null) return;
        if (!mounted) return;
        setState(() {
          _completed = false;
          _file = File(pickedFile.path);
        });
        final origin = widget.title;
        if (origin == 'Upload feature image') {
          await ListRepository.uploadImage(_file!, origin);
        } else {
          final response = await ListRepository.uploadImage(_file!, origin);
          if (response!.data['status'] == 'success') {
            setState(() {
              _completed = true;
            });
            final item = response.data['path'];
            widget.onChange(item);
          } else {
            logError('Image Upload Error', response.message);
          }
        }
      } else if (statusImage.isDenied) {
        if (statusImage.isGranted) {
          final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedFile == null) return;
          if (!mounted) return;
          setState(() {
            _completed = false;
            _file = File(pickedFile.path);
          });
          final origin = widget.title;
          if (origin == 'Upload feature image') {
            await ListRepository.uploadImage(_file!, origin);
          } else {
            final response = await ListRepository.uploadImage(_file!, origin);
            if (response!.data['status'] == 'success') {
              setState(() {
                _completed = true;
              });
              final item = response.data['path'];
              widget.onChange(item);
            } else {
              logError('Image Upload Error', response.message);
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

  Widget? _buildContent() {
    if (widget.image != null && _file == null) return null;

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

        if (_completed) {
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
        }

        if (_completed) {
          return Container(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.check_circle,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          );
        }

        if (_percent != null && _percent! < 100) {
          return Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
              // child: LinearProgressIndicator(
              //   value: _percent,
              //   backgroundColor: Theme.of(context).cardColor,
              // ),
            ),
          );
        }

        return Container(
          alignment: Alignment.bottomLeft,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            // child: LinearProgressIndicator(
            //   backgroundColor: Theme.of(context).cardColor,
            // ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    BorderType borderType = BorderType.RRect;
    Widget circle = Container();

    if (widget.image != null) {
      decorationImage = DecorationImage(
        image: NetworkImage(
            "${Application.picturesURL}${widget.image!}"),
        fit: BoxFit.cover,
      );
    }
    if (_file != null) {
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
      // if (_percent != null && _percent! < 100) {
      //   circle = CircularProgressIndicator(
      //     value: _percent,
      //     backgroundColor: Theme.of(context).cardColor,
      //   );
      // } else if (_file != null && !_completed) {
      //   circle = const CircularProgressIndicator();
      // }
    }

    return InkWell(
      onTap: _uploadImage,
      child: Stack(
        children: [
          DottedBorder(
            borderType: borderType,
            radius: const Radius.circular(8),
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.all(8),
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
