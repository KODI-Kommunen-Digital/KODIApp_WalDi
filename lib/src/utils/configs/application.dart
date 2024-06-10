import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/data/model/model_device.dart';
import 'package:heidi/src/data/model/model_setting.dart';

class Application {
  static bool debug = true;
  static String domain = 'https://heidiapp.com';
  static DeviceModel? device;
  static SettingModel setting = SettingModel.fromDefault();

  static String picturesURL = dotenv.env['IMAGE_URL'] ??
      'https://test1heidi.obs.eu-de.otc.t-systems.com/';

  // 'https://smrauf1heidi.obs.eu-de.otc.t-systems.com/';
  // 'https://developement1heidi.obs.eu-de.otc.t-systems.com/';
//       'https://gesekeheidi.obs.eu-de.otc.t-systems.com/';

  static String defaultPicturesURL = dotenv.env['DEFAULT_PROFILE_IMAGE_URL'] ??
      'https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png';

  // 'https://test1heidi.obs.eu-de.otc.t-systems.com/';
  // 'https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png';

  static String defaultAppointmentPicturesURL =
      'https://test1heidi.obs.eu-de.otc.t-systems.com/admin/AppointmentBooking/Defaultimage1.png';
  //
  //

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
