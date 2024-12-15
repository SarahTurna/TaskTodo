import 'package:dio/dio.dart';
import 'package:task_management/features/user_profile/model/update_profile_model.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class ViewProfileAPI {
  Future<MPatchProfile> getUpdate() async {
    Response res = await DioService.patch(path: Urls.updateProfile);
    return MPatchProfile.fromJson(res.data);
  }
}
