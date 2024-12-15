import 'package:dio/dio.dart';
import 'package:task_management/features/task_manager/model/create_task_model.dart';
import 'package:task_management/services/dio%20service/dio_service.dart';
import 'package:task_management/services/urls.dart';

class AddTaskAPI {
  Future<MCreateTask> getAddedTask(Map<String, dynamic> taskData) async {
    Response res = await DioService.post(path: Urls.createTask, data: taskData);
    return MCreateTask.fromJson(res.data);
  }
}
