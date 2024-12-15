import 'package:dio/dio.dart';
import 'package:task_management/api%20services/base_api.dart';
import 'package:task_management/features/task_manager/model/get_task_model.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class RecentTaskAPI {
  Future<MGetTask> getTask() async {
    Response res = await DioService.get(path: Urls.getTasks);
    return MGetTask.fromJson(res.data);
  }
}
