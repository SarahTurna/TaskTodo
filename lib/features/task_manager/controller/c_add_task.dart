import 'package:power_state/power_state.dart';
import 'package:task_management/features/task_manager/api/add_task_api.dart';
import 'package:task_management/features/task_manager/model/create_task_model.dart';

class CAddTask extends PowerController {
  final AddTaskAPI _addTaskAPI = AddTaskAPI();

  MCreateTask? _addTask;
  bool _loading = true;

  MCreateTask? get addTask => _addTask;
  bool get loading => _loading;

  fetchAddTask(Map<String, dynamic> taskData) async {
    setLoading(true);
    try {
      final addTaskResponse = await _addTaskAPI.getAddedTask(taskData);
      _addTask = addTaskResponse;
    } catch (err) {
      // Handle error
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }
}
