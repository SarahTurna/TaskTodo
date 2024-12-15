import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_management/constants/constant.dart';
import 'package:task_management/features/auth/signin_view.dart';
import 'package:task_management/services/shared_preferences.dart';

class DioService {
  static late Dio dio;
  static void create() {
    final options = BaseOptions(
      baseUrl: "http://206.189.138.45:7152/",
      headers: {'Content-Type': 'application/json'},
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        String? accessToken =
            SharedPreferencesService.getString(Pkeys.accessToken);
        options.headers['Authorization'] = 'Bearer $accessToken';
        // Do something before request is sent.
        // If you want to resolve the request with custom data,
        // you can resolve a `Response` using `handler.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject with a `DioException` using `handler.reject(dioError)`.
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Do something with response data.
        // If you want to reject the request with a error message,
        // you can reject a `DioException` object using `handler.reject(dioError)`.
        print("========= ${response.statusCode} ===========");
        if (response.statusCode == 401) {
          Navigator.pushReplacement(Pkeys.context,
              MaterialPageRoute(builder: (_) => const SignInPage()));
        }
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        // Do something with response error.
        // If you want to resolve the request with some custom data,
        // you can resolve a `Response` object using `handler.resolve(response)`.
        return handler.next(e);
      },
    ));
  }

  static Future<Response> post(
      {required String path, dynamic data, Options? options}) async {
    return dio.post(path, data: data, options: options);
  }

  static Future<Response> get({required String path, dynamic data}) async {
    return dio.get(path, data: data);
  }

  static Future<Response> patch({required String path, dynamic data}) async {
    return dio.patch(path, data: data);
  }
}
