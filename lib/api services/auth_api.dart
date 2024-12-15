import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_management/api%20services/base_api.dart';
import 'package:task_management/features/user_profile/model/get_user_profile.dart';
import 'package:task_management/models/auth_model.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class AuthAPI {
  Future<MAuthLogin?> login(
      {required String email, required String password}) async {
    Response res = await DioService.post(
        path: Urls.login, data: {'email': email, 'password': password});

    return MAuthLogin.fromJson(res.data);
  }

  Future<MUserProfile> getProfile() async {
    Response res = await DioService.get(
      path: Urls.userProfile,
    );
    return MUserProfile.fromJson(res.data);
  }
}
