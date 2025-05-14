import 'package:dio/dio.dart';
import 'package:kanachat/core/api/api_constants.dart';

class ApiClient {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
}
