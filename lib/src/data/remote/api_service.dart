import 'package:dio/dio.dart';
import 'package:heidi/src/data/remote/responses/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('courses')
  Future<BaseResponse<List<String>>> getCourses();
}
