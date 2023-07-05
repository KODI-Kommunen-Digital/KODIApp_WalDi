import 'package:heidi/src/data/model/model_device.dart';

class Application {
  static bool debug = true;
  static String domain = 'https://heidiapp.com';
  static DeviceModel? device;

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
