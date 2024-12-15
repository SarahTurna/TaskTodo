import 'package:power_state/power_state.dart';
import 'package:task_management/features/task_manager/api/recent_task_api.dart';
import 'package:task_management/features/task_manager/model/get_task_model.dart';

class CRecentTask extends PowerController {
  final RecentTaskAPI _recentTaskAPI = RecentTaskAPI();

  MGetTask? _recentTask;
  bool _loading = true;

  MGetTask? get recentTask => _recentTask;
  bool get loading => _loading;

  fetchRecentTask() async {
    setLoading(true);
    try {
      final task = await _recentTaskAPI.getTask();
      _recentTask = task;
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
