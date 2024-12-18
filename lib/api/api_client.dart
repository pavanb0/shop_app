import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;
  //local link
  String BaserUrl = "https://062a-152-52-228-70.ngrok-free.app";
  //Productio link

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BaserUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (option, handler) {
        option.headers['Authorization'] = "";
        return handler.next(option);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    return _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, {dynamic data}) {
    return _dio.post(endpoint, data: data);
  }
}
