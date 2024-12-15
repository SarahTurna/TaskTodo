import 'package:dio/dio.dart';
import 'package:task_management/features/task_manager/model/get_all_task.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class AllTaskAPI {
  Future<MGetAllTask> getAllTask() async {
    Response res = await DioService.get(path: Urls.taskList);
    return MGetAllTask.fromJson(res.data);
  }
}
