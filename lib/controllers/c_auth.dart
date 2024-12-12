// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:task_management/api%20services/api/auth_api.dart';
// import 'package:task_management/constants/constant.dart';
// import 'package:task_management/features/auth/signin_view.dart';

// import 'package:power_state/power_state.dart';

// class CAuth extends PowerController {
//   final AuthAPI _authAPI = AuthAPI();
//   MGetAccessToken? userToken;
//   MGetUserInfo? userInfo;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Future<void> signIn({required String email, required String password}) async {
//     if (email.isEmpty || password.isEmpty) {
//       SnackBarPage.show(
//         type: SnackbarType.info,
//         title: "Error!",
//         description: "Email and password cannot be empty.",
//       );
//       return;
//     }

//     try {
//       loader(); // Show loader
//       userToken =
//           await _authAPI.signInWithToken(email: email, password: password);
//       SharedPreferencesService.saveString(
//           Pkeys.accessToken, userToken?.accessToken);

//       if (userToken?.code == 200) {
//         pushReplacementUntil(screen: const HomePage());
//       } else {
//         _handleSignInError(userToken?.code);
//       }
//     } on DioException catch (e) {
//       pop(); // Hide loader
//       debugPrint('Dio Error: ${e.message}, ${e.response?.data}');
//       _handleException(e);
//     } catch (e) {
//       pop(); // Hide loader
//       debugPrint('Unknown Error: $e');
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: "An unknown error occurred.",
//       );
//     }
//   }

//   void _handleSignInError(int? code) {
//     if (code == 401) {
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: "Invalid credentials.",
//       );
//     } else if (code == 404) {
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: "API endpoint error.",
//       );
//     } else {
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: "Unexpected error occurred (Code: $code).",
//       );
//     }
//     pop(); // Hide loader
//   }

//   void _handleException(Exception e) {
//     if (e is DioException) {
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: getErrorMessage(e),
//       );
//     } else {
//       SnackBarPage.show(
//         type: SnackbarType.error,
//         title: "Error!",
//         description: "Something went wrong. Please try again.",
//       );
//     }
//   }

//   Future<void> checkUserState() async {
//     bool isTokenValid = SharedPreferencesService.validateAccessToken();

//     if (isTokenValid) {
//       try {
//         userToken = await _authAPI.signInWithToken(email: '', password: '');

//         pushReplacementUntil(screen: const DashBoard());
//       } catch (e) {
//         //print('Error during token sign-in: $e');

//         if (Pkeys.context.mounted) {
//           Navigator.pushReplacement(Pkeys.context,
//               MaterialPageRoute(builder: (_) => const AccessToken()));
//         }
//       }
//     } else {
//       if (Pkeys.context.mounted) {
//         Navigator.pushReplacement(Pkeys.context,
//             MaterialPageRoute(builder: (_) => const AccessToken()));
//       }
//     }
//   }

//   Future<void> forgotPassword(BuildContext context, String email) async {
//     SnackBarPage.show(
//       type: SnackbarType.success,
//       title: "Success!",
//       description: "Password reset link has been sent to your email.",
//     );
//   }
// }
