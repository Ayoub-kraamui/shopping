import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com')) {
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  Dio get dio => _dio;
}
