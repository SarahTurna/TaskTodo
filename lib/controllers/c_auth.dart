import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/api%20services/auth_api.dart';
import 'package:task_management/constants/constant.dart';
import 'package:task_management/features/auth/signin_view.dart';
import 'package:task_management/features/task_manager/view/home_view.dart';
import 'package:task_management/features/user_profile/model/get_user_profile.dart';
import 'package:task_management/models/auth_model.dart';
import 'package:task_management/services/shared_preferences.dart';
import 'package:task_management/utils/enum.dart';
import 'package:task_management/utils/helper.dart';
import 'package:task_management/widgets/navigator.dart';
import 'package:task_management/widgets/snackbar.dart';

class CAuth extends PowerController {
  final AuthAPI _authAPI = AuthAPI();
  MAuthLogin? userData;
  MUserProfile? userDetail;

  final TextEditingController emailController = TextEditingController();

  /// Signs in the user with email and password.
  signIn({required String email, required String password}) async {
    if (email == '' || password == '') {
      WSnackbar.show(
          type: SnackbarType.info,
          title: "Oops!",
          description: "You may have forgot to put your email || password!");
      return;
    }
    try {
      loader();
      userData = await _authAPI.login(email: email, password: password);
      SharedPreferencesService.saveString(
          Pkeys.accessToken, userData?.data?.token ?? '');

      if (userData?.status == 'Success') {
        // ignore: use_build_context_synchronously
        pushReplacementUntil(screen: const Home());
      }
    } catch (e) {
      print(e);
      pop();
      if (e is DioException) {
        WSnackbar.show(
            type: SnackbarType.error,
            title: "Oh snap!",
            description: getErrorMessage(e));
      } else {
        WSnackbar.show(
            type: SnackbarType.error,
            title: "Oh snap!",
            description: "Something issue in backend!");
      }
    }
  }

  /// Checks the user state and navigates accordingly.
  checkUserState() async {
    if (SharedPreferencesService.validateAccessToken()) {
      try {
        userDetail = await _authAPI.getProfile();
        pushReplacementUntil(screen: const Home());
      } catch (e) {
        // print(e);
        Navigator.pushReplacement(Pkeys.context,
            MaterialPageRoute(builder: (_) => const SignInPage()));
      }
    } else {
      Navigator.pushReplacement(
          Pkeys.context, MaterialPageRoute(builder: (_) => const SignInPage()));
    }
  }
}
