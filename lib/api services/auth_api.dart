import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_management/models/auth_model.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class AuthAPI {
  //signin
  Future<MAuthLogin?> signInWithToken({
    required String email,
    required String password,
  }) async {
    try {
      Response res = await DioService.post(
        path: Urls.login,
        data: {'email': email, 'password': password},
      );

      if (res.data is Map<String, dynamic>) {
        return MAuthLogin.fromJson(res.data);
      } else if (res.data is String) {
        try {
          final Map<String, dynamic> jsonData = json.decode(res.data);
          return MAuthLogin.fromJson(jsonData);
        } catch (e) {
          //print("Error parsing JSON string: $e");
          throw Exception("Invalid JSON response format");
        }
      } else {
        throw Exception("Unexpected response format");
      }
    } on DioException catch (dioError) {
      //print("Dio error occurred: ${dioError.message}");
      throw Exception(
          "Request failed with status: ${dioError.response?.statusCode}");
    } catch (e) {
      //print("An error occurred: $e");
      throw Exception("An unknown error occurred");
    }
  }
}
