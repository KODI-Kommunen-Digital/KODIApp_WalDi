import 'package:dio/dio.dart';
import 'package:heidi/src/data/remote/api_result.dart';
import 'package:heidi/src/data/remote/api_service.dart';
import 'package:heidi/src/data/remote/network_exceptions.dart';
import 'package:heidi/src/utils/logging/api_logger.dart';

class RemoteRepository with ApiLoggy {
  final ApiService _apiService;
  final Dio _dio;

  static const String _baseUrl = 'https://segelkurse.mintellity.dev/api/';

  factory RemoteRepository(String sessionToken) {
    final dio = Dio();

    if (sessionToken.isNotEmpty) {
      dio.options.headers['x-access-token'] = sessionToken;
    }
    dio.options.headers['authorization'] = 'Basic c2VnZWxrdXJzZTptaW50MjIyMg==';

    final restClient = ApiService(dio, baseUrl: _baseUrl);

    return RemoteRepository._(dio, restClient);
  }

  RemoteRepository._(this._dio, this._apiService);

  void setSessionToken(String sessionToken) {
    _dio.options.headers['x-access-token'] = sessionToken;
  }

  void addLogger() {
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (log) {
          loggy.debug(log);
        },
      ),
    );
  }

  Future<ApiResult<List<String>>> getCourses() async {
    try {
      final response = await _apiService.getCourses();
      return ApiResult.success(response.data);
    } catch (e, st) {
      return ApiResult.failure(error: NetworkExceptions.fromError(e, st));
    }
  }
}


