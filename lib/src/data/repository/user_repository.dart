import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';

class UserRepository {

  UserRepository();

  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final prefs = await Preferences.openBox();
    prefs.deleteKey(Preferences.cityId);
    List<int> cityIds = [];

    final Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };

    final response = await Api.requestLogin(params);
    // final userId = response.data['userId'];
    if (response.success) {
      // fetchUser(userId);
      final userId = response.data['userId'];
      final cityUsers = response.data['cityUsers'];

      for (final cities in cityUsers) {
        cityIds.add(cities['cityId']);
      }

      List<String> cityIdsList = cityIds.map((i) => i.toString()).toList();
      prefs.setKeyValue(Preferences.userId, userId);
      final response1 = await Api.requestUser(userId: userId);
      prefs.setKeyValue(Preferences.token, response.data['accessToken']);
      prefs.setKeyValue(
          Preferences.refreshToken, response.data['refreshToken']);
      prefs.setKeyValue(Preferences.cityId, cityIdsList);
      // setCityIds(prefs, cityIdsList);
      return UserModel.fromJson(response1.data);
    }
    // AppBloc.messageCubit.onShow(response.message);
    UtilLogger.log('Login Response', response.message);
    // setToken(prefs, response.data);
    return null;
  }
}
