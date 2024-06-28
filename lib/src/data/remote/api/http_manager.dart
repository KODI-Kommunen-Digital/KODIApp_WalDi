import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logger.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HTTPManager {
  final exceptionCode = ['jwt_auth_bad_iss', 'jwt_auth_invalid_token'];
  late final Dio _dio;

  HTTPManager() {
    _dio = Dio(
      BaseOptions(
        //baseUrl: 'https://test.smartregion-auf.de/api/',
        baseUrl: 'https://waldi.app/api',
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
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
      }, onResponse: (response, handler) {
        handler.next(response);
      }, onError: (error, handler) async {
        if (error.response?.data['message'] ==
            'Unauthorized! Token was expired!') {
          final prefs = await Preferences.openBox();
          var rToken = prefs.getKeyValue(Preferences.refreshToken, '');
          final userId = prefs.getKeyValue(Preferences.userId, '');
          final Map<String, dynamic> params = {
            "refreshToken": rToken,
          };
          final result =
              await post(url: '/users/$userId/refresh', data: params);
          final response = ResultApiModel.fromJson(result);
          if (response.success) {
            final newToken = response.data['accessToken'];
            prefs.setKeyValue(Preferences.token, newToken);
            prefs.setKeyValue(
                Preferences.refreshToken, response.data['refreshToken']);
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            try {
              var response = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                  receiveTimeout: error.requestOptions.receiveTimeout,
                ),
              );
              handler.resolve(response);
            } catch (e, stackTrace) {

              logError('Refresh Token Response Failed', e);
              await Sentry.captureException(e, stackTrace: stackTrace);
              handler.reject(error);
            }
          } else if (response.message ==
              'Unauthorized! Refresh Token was expired!') {
            logError('Refresh Token Error', response.message);
            AppBloc.loginCubit.onLogout();
            final prefs = await Preferences.openBox();
            prefs.deleteKey(Preferences.userId);
            handler.next(error);
          }
        } else {
          final response = Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
          );
          return handler.resolve(response);
        }
      }),
    );
  }

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
    } on DioException catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

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
    } on DioException catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

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
    } on DioException catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

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
    } on DioException catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

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
    } on DioException catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
      return _errorHandle(error);
    } finally {
      if (loading == true) {
        SVProgressHUD.dismiss();
      }
    }
  }

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
  Map<String, dynamic> _errorHandle(DioException error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        if (error.response?.data['message'] ==
            'Unauthorized! Refresh Token was expired!') {
          AppBloc.loginCubit.onLogout();
          message = "Your session has expired. Please log in again.";
        } else {
          message = "Please make sure you are connected to the Internet";
        }
        break;
    }

    return {
      "success": false,
      "message": message,
      "data": data,
    };
  }
}
