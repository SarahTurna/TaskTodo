import 'package:dio/dio.dart';
import 'package:task_management/api%20services/base_api.dart';
import 'package:task_management/features/user_profile/model/get_user_profile.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class UserProfileAPI {
  Future<MUserProfile> getProfile() async {
    Response res = await DioService.get(path: Urls.userProfile);
    return MUserProfile.fromJson(res.data);
  }
}
