import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class HTTPManager {
  final exceptionCode = ['jwt_auth_bad_iss', 'jwt_auth_invalid_token'];
  late final Dio _dio;

  HTTPManager() {
    ///Dio
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://app.smartregion-auf.de/api',
        // baseUrl: 'http://80.158.43.3:3001',
        // baseUrl: 'http://192.168.100.26:8002',
        // baseUrl: 'http://10.5.22.172:8002',
        connectTimeout: 30000,
        receiveTimeout: 30000,
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );

    ///Interceptors dio
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await Preferences.openBox();
          Map<String, dynamic> headers = {
            "Device-Id": Application.device?.uuid,
            "osName": Application.device?.model,
            "Device-Version": Application.device?.version,
            "deviceType":
                '${Application.device?.type} ${Application.device?.model}',
            "Device-Token": Application.device?.token,
            HttpHeaders.contentTypeHeader: 'application/json',
          };

          var token = prefs.getKeyValue(Preferences.token, '');
          if (token != '') {
            headers["Authorization"] = "Bearer $token";
          }
          options.headers.addAll(headers);
          _printRequest(options);
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.response?.data['status'] == 'error'){
            final response = Response(
              requestOptions: error.requestOptions,
              data: error.response?.data,
            );
            return handler.resolve(response);
          }
          else{
            final prefs = await Preferences.openBox();
            logError('error.response', error.response?.data['status']);
            if (error.type != DioErrorType.response) {
              return handler.next(error);
            }

            if (error.response?.statusCode == 401) {
              var rToken = prefs.getKeyValue(Preferences.refreshToken, '');
              final userId = prefs.getKeyValue(Preferences.userId, '');

              final Map<String, dynamic> params = {
                "refreshToken": rToken,
              };

              final result =
              await post(url: '/users/$userId/refresh', data: params);
              final response = ResultApiModel.fromJson(result);
              if (response.success) {
                prefs.setKeyValue(
                    Preferences.token, response.data['accessToken']);
                prefs.setKeyValue(
                    Preferences.refreshToken, response.data['refreshToken']);

                _dio.interceptors.add(QueuedInterceptorsWrapper(
                    onRequest: (options, handler) async {
                      var options = error.response!.requestOptions;
                      Map<String, dynamic> headers = {
                        "Device-Id": Application.device?.uuid,
                        "osName": Application.device?.model,
                        "Device-Version": Application.device?.version,
                        "deviceType": Application.device?.type,
                        "browserName": null,
                        "Device-Token": Application.device?.token,
                        HttpHeaders.contentTypeHeader: 'application/json',
                      };

                      var token = prefs.getKeyValue(Preferences.token, '');
                      if (token != '') {
                        headers["Authorization"] = "Bearer $token";
                      }
                      options.headers.addAll(headers);
                      _printRequest(options);

                      return handler.next(options);
                    }, onError: (DioError error, handler) async {
                  if (error.response?.statusCode == 401) {
                    AppBloc.loginCubit.onLogout();
                  }
                }));
              } else {
                AppBloc.loginCubit.onLogout();
              }
            }

            final response = Response(
              requestOptions: error.requestOptions,
              data: error.response?.data,
            );
            return handler.resolve(response);
          }
        }
      ),
    );
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    dynamic data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.post(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Delete method
  Future<dynamic> delete({
    required String url,
    dynamic data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
    bool? loading,
  }) async {
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.delete(
        url,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Post method
  Future<dynamic> patch({
    required String url,
    dynamic data,
    FormData? formData,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.patch(
        url,
        data: data ?? formData,
        options: options,
        onSendProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    dynamic params,
    Options? options,
    bool? loading,
  }) async {
    try {
      if (loading == true) {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
        SVProgressHUD.show();
      }
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///Post method
  Future<dynamic> download({
    required String url,
    required String filePath,
    dynamic params,
    Options? options,
    Function(num)? progress,
    bool? loading,
  }) async {
    if (loading == true) {
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
      SVProgressHUD.show();
    }
    try {
      final response = await _dio.download(
        url,
        filePath,
        options: options,
        queryParameters: params,
        onReceiveProgress: (received, total) {
          if (progress != null) {
            progress((received / total) / 0.01);
          }
        },
      );
      if (response.statusCode == 200) {
        return {
          "success": true,
          "data": File(filePath),
          "message": 'download_success',
        };
      }
      return {
        "success": false,
        "message": 'download_fail',
      };
    } on DioError catch (error) {
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

  ///On change domain
  // void changeDomain(String domain) {
  //   _dio.options.baseUrl = 'https://heidiapp.com/index.php/wp-json';
  // }

  ///Print request info
  void _printRequest(RequestOptions options) {
    UtilLogger.log("BEFORE REQUEST ====================================");
    UtilLogger.log("${options.method} URL", options.uri);
    UtilLogger.log("HEADERS", options.headers);
    if (options.method == 'GET') {
      UtilLogger.log("PARAMS", options.queryParameters);
    } else {
      UtilLogger.log("DATA", options.data);
    }
  }

  ///Error common handle
  Map<String, dynamic> _errorHandle(DioError error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "Please make sure you are connected to the Internet";
        break;
    }

    return {
      "success": false,
      "message": message,
      "data": data,
    };
  }
}