import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

Future<void> handleBackgroundMessage(RemoteMessage? message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;

  FirebaseApi(this.navigatorKey);

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message != null) {
      final item = await ListRepository.loadProduct(
          int.parse(message.data["cityId"]), int.parse(message.data["id"]));
      //Error, data not properly converted in routes
      if (item != null) {
        navigatorKey.currentState
            ?.pushNamed(Routes.productDetail, arguments: item);
      }
    }
  }

  /*
  static Future<void> sendPushNotification(
      String notificationTitle, String notificationBody) async {
    try {
      final body = {
        "to": "/topics/warnings",
        "notification": {
          "title": notificationTitle, //our name should be send
          "body": notificationBody,
        },
        /*
        "data": {
          "route":
        }*/
      };

      var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
      var response = await post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "key=AAAAmbJzFR8:APA91bEck_SIniItJ8pj6giDIqKOS8v-qv0Q0V0tNSzo_-0j_j21u5lo-hLMAg2V5_I0CUvhaEQfXi8hZ9HTul04bvvg69PWs3NpwXi0JlY71NAIAhz9bBX31658TaL4YvSHEP0lC7Y8"
          },
          body: jsonEncode(body));

      logError(response.statusCode);
    } catch (e) {
      logError("Failed to send notification");
    }
  }
*/

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.subscribeToTopic("warnings");
    int uId = await getLoggedUserId();

    if (uId > 0) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) uploadToken(uId, token);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> uploadToken(int userId, String token) async {
    final response = await Api.uploadToken(userId, {"firebaseToken": token});
    logInfo("FCM token upload success: ${response.success}");
  }

  Future<int> getLoggedUserId() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    return userId;
  }
}
