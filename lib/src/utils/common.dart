import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_device.dart';
import 'package:location/location.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Utils {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<DeviceModel?> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final android = await deviceInfoPlugin.androidInfo;
        return DeviceModel(
          uuid: android.id,
          model: "Android",
          version: android.version.sdkInt.toString(),
          type: android.model,
        );
      } else if (Platform.isIOS) {
        final IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
        if (ios.identifierForVendor != null) {
          return DeviceModel(
            uuid: ios.identifierForVendor!,
            name: ios.name,
            model: ios.systemName,
            version: ios.systemVersion,
            type: ios.utsname.machine,
          );
        } else {
          throw ("no uuid");
        }
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      // UtilLogger.log("ERROR", e);
    }
    return null;
  }

  static Future<LocationData?> getLocation() async {
    Location location = Location();
    PermissionStatus permissionGranted;
    LocationData? locationData;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return locationData;
      }
    }

    return await location.getLocation();
  }

  ///Singleton factory
  static final Utils _instance = Utils._internal();

  factory Utils() {
    return _instance;
  }

  Utils._internal();
}
