import 'package:heidi/src/data/model/model_device.dart';
import 'package:heidi/src/data/model/model_setting.dart';

class Application {
  static bool debug = true;
  static String domain = 'https://heidiapp.com';
  static DeviceModel? device;
  static SettingModel setting = SettingModel.fromDefault();

  static const String picturesURL =
  // 'https://test1heidi.obs.eu-de.otc.t-systems.com/';
      'https://smrauf1heidi.obs.eu-de.otc.t-systems.com/';

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
