import 'package:power_state/power_state.dart';
import 'package:task_management/features/task_manager/api/tasks_api.dart';
import 'package:task_management/features/task_manager/model/get_all_task.dart';

class CAllTask extends PowerController {
  final AllTaskAPI _allTaskAPI = AllTaskAPI();

  MGetAllTask? _allTask;
  bool _loading = true;

  MGetAllTask? get allTask => _allTask;
  bool get loading => _loading;

  fetchAllTask() async {
    setLoading(true);
    try {
      final alltask = await _allTaskAPI.getAllTask();
      _allTask = alltask;
    } catch (err) {
      //print(err);
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
